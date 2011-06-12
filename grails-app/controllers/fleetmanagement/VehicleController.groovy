package fleetmanagement

class VehicleController {

	static allowedMethods = [save: "POST", update: "POST", delete: ['POST','GET']]
	
	def index = {
		redirect(action: "list", params: params)
	}
	
	def list = {
		// pre process the input params and set defaults
		if (!params.max) params.max = 20
		if (!params.offset) params.offset = 0
		
		// sort may stay null, if Domain does not support sorting 
		
		if (!params.sort) params.sort = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(Vehicle.class, 'mapping')?.getMapping()?.getSort()
		if (!params.order) params.order = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(Vehicle.class, 'mapping')?.getMapping()?.getOrder()
		if (!params.order) params.order = "asc"
		
		// parameters for hsql query
		Hashtable namedParams = new Hashtable();
		
		// parameters for sortableColumn in list view, they have a prefix "filter."
		Hashtable sortableParams = new Hashtable();
		
		// separated parts of the hsql query
		def querySql = "FROM Vehicle vehicle WHERE 1=1"
		def whereSql = ""
		def orderBySql = ""
		
		// create query for filter and sort
		whereSql = applyFilters(params,namedParams, sortableParams, whereSql)
		
		// restrict resultset according to callback params
		// when user is (de-)associating objects
		whereSql = applyCallbackParams(params,namedParams, sortableParams, whereSql)
		
		// create the order by clause
		orderBySql = applySortCriterias(params)
		
		// last but not least get the result list...		
		def result = Vehicle.findAll(querySql + whereSql + orderBySql, namedParams, [max:params.max.toInteger(), offset:params.offset.toInteger()])
		
		/// ...and the total number of records        
		def countResult = Vehicle.executeQuery("select count(*) "+ querySql + whereSql, namedParams)
		def paginateTotal = countResult[0]
		
		// use "show" view instead of list, if there is only one record in result
		// as long as there is no (de-)associating on the way
		if ((paginateTotal == 1) && (result.size == 1) && (!params.callback)) {
			redirect(action: "show", id: result.get(0).compositeId)
			return
		} 
		
		return [vehicleInstanceList: result, paginateTotal:paginateTotal, sortableParams:sortableParams]
	}
	
	
	def create = {
		def vehicleInstance = new Vehicle()
		vehicleInstance.properties = params
        def serviceSchedule = new ServiceSchedule()
		return [vehicleInstance: vehicleInstance, serviceSchedule: serviceSchedule]
	}
	
	
	def save = {
		def vehicleInstance = new Vehicle(params)

        vehicleInstance.serviceSchedule = new ServiceSchedule(nextService: params.nextService,
            serviceInterval: params.serviceInterval)

        if (vehicleInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), vehicleInstance])}"
			
			// during association, the callback must be executed
			if (params.source != null && params.source != "") {
				def linkClass = grailsApplication.getClassForName(params.class)
				def theLink = linkClass.getComposite(params.source_id)
				def d = params.dest
				theLink."addTo${d[0].toUpperCase()+d.substring(1)}"( vehicleInstance );
				
				def rd = params.refDest
				// set just if not unidirectional
				if (rd && rd != "") {
					if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(Vehicle.class, rd))) {
						vehicleInstance."addTo${rd[0].toUpperCase()+rd.substring(1)}"( theLink );
					}
				}
				theLink.save()
				
				// and back to edit page of associated object
				redirect(controller:params.source, action:"edit", id:params.source_id)
			} else {
				// HK go to list instead of show
				//redirect(action: "show", id: vehicleInstance.id)
				redirect(action:list)
			}
		}
		else {
			render(view: "create", model: [vehicleInstance: vehicleInstance])
		}
	}
	
	
	def show = {
		def vehicleInstance = Vehicle.getComposite(params.id)

        log.info("------->" + vehicleInstance.reminders.size())
		if (!vehicleInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), params.id])}"
			redirect(action: "list")
		}
		else {
			[vehicleInstance: vehicleInstance]
		}
	}
	
	
	def edit = {
		def vehicleInstance = Vehicle.getComposite(params.id)
		if (!vehicleInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [vehicleInstance: vehicleInstance, serviceScheduleInstance: vehicleInstance.serviceSchedule]
		}
	}
	
	
	def update = {
		def vehicleInstance = Vehicle.getComposite(params.id)
		if (vehicleInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (vehicleInstance.version > version) {
					
					vehicleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'vehicle.label', default: 'Vehicle')] as Object[], "Another user has updated this Vehicle while you were editing.")
					render(view: "edit", model: [vehicleInstance: vehicleInstance])
					return
				}
			}
			vehicleInstance.properties = params
			if (!vehicleInstance.hasErrors() && vehicleInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), vehicleInstance])}"
				// go to list instead of show
				//redirect(action: "show", id: vehicleInstance.id)
				redirect(action:"list")
			}
			else {
				render(view: "edit", model: [vehicleInstance: vehicleInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), params.id])}"
			redirect(action: "list")
		}
	}
	
	
	def delete = {
		def vehicleInstance = Vehicle.getComposite(params.id)
		if (vehicleInstance) {
			try {
				// HK: special deletion neccessary for some relationships
				// the final delete is placed in the domain class
				// vehicleInstance.delete(flush: true)
				deleteReferencesInController(vehicleInstance)
				vehicleInstance.deleteAndClearReferences()
				
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), vehicleInstance])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				log.error("Delete Exception: " + e)
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), params.id])}"
			redirect(action: "list")
		}
	}
	
	
	def choose = {
		// redirect to (de-)associating
		params.class="fleetmanagement.Vehicle"
		redirect(controller:params.source,action:params.callback,params:params)
	}
	
	
	def link = {
		// establish the association
		def vehicleInstance = Vehicle.getComposite(params.source_id)
		def linkClass = grailsApplication.getClassForName(params.class)
		def theLink = linkClass.getComposite(params.id)
		def d = params.dest
		
		vehicleInstance."addTo${d[0].toUpperCase()+d.substring(1)}"( theLink );
		vehicleInstance.validate() // will mark any errors in edit view
		
		def rd = params.refDest
		// set other side just if not unidirectional
		if (rd && rd != "") {
			if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(linkClass, rd))) {
				// n:m
				theLink."addTo${rd[0].toUpperCase()+rd.substring(1)}"(vehicleInstance)
				
				try {
					theLink.save(flush:true)
				} catch (org.springframework.dao.DataIntegrityViolationException e) {
					log.error("Link Exception: " + e)
					vehicleInstance.errors.reject("vehicleInstance.${d}.associate.failed", [params.id] as Object[], "Unable to associate " + linkClass + " with id ${params.id}")
				}
			}
		}	  
		// use render instead of redirect to get validation errors
		render(view:'edit',model:[vehicleInstance:vehicleInstance])
	}
	
	
	def unlink = {
		// remove the association, without deleting any object
		def vehicleInstance = Vehicle.getComposite(params.source_id)
		def linkClass = grailsApplication.getClassForName(params.class)
		def theLink = linkClass.getComposite(params.id)
		def d = params.dest
		vehicleInstance."removeFrom${d[0].toUpperCase()+d.substring(1)}"( theLink );
		
		vehicleInstance.validate() // will mark any errors in edit view
		
		def rd = params.refDest
		// set other side just if not unidirectional
		if (rd && rd != "") {
			if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(linkClass, rd))) {
				// n:m
				theLink."removeFrom${rd[0].toUpperCase()+rd.substring(1)}"(vehicleInstance)
				
				try {
					theLink.save(flush:true)
				} catch (org.springframework.dao.DataIntegrityViolationException e) {
					log.error("Unlink Exception: " + e)
					vehicleInstance.errors.reject("vehicleInstance.${d}.deassociate.failed", [params.id] as Object[], "Unable to deassociate " + linkClass + " with id ${params.id}")
				}
			}
		}
		
		// use render instead of redirect to get validation errors
		render(view:'edit',model:[vehicleInstance:vehicleInstance])
	}
	
	
	private void deleteReferencesInController(x) {
		// would be better to place this code in domain or service
		// but that's not possible due to generation limitations
		
	}
	
	
	// internal helper methods
	def applyFilters(params,namedParams, sortableParams, whereSql) {
		
		// start with filter attributes...
		
				if (params.filter?.registrationNumber && params.filter?.registrationNumber!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND vehicle.registrationNumber=:registrationNumber"
					namedParams.put("registrationNumber", params.filter.registrationNumber)
					sortableParams.put("filter.registrationNumber", params.filter.registrationNumber) 
				}
				
				if (params.filter?.make && params.filter?.make!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND vehicle.make=:make"
					namedParams.put("make", params.filter.make)
					sortableParams.put("filter.make", params.filter.make) 
				}
				
				if (params.filter?.model && params.filter?.model!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND vehicle.model=:model"
					namedParams.put("model", params.filter.model)
					sortableParams.put("filter.model", params.filter.model) 
				}
				
				if (params.filter?.year && params.filter?.year!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND vehicle.year=:year"
					namedParams.put("year", params.filter.year)
					sortableParams.put("filter.year", params.filter.year) 
				}
				
				if (params.filter?.branch && params.filter?.branch!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND vehicle.branch.id=:branch"
					namedParams.put("branch", new Long(params.filter.branch))
					sortableParams.put("filter.branch", params.filter.branch) 
				}
				
				if (params.filter?.serviceSchedule && params.filter?.serviceSchedule!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND vehicle.serviceSchedule.id=:serviceSchedule"
					namedParams.put("serviceSchedule", new Long(params.filter.serviceSchedule))
					sortableParams.put("filter.serviceSchedule", params.filter.serviceSchedule) 
				}
				
				if (params.filter?.driver && params.filter?.driver!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND vehicle.driver.id=:driver"
					namedParams.put("driver", new Long(params.filter.driver))
					sortableParams.put("filter.driver", params.filter.driver) 
				}
				
				if (params.filter?.licenseExpiryDate && params.filter?.licenseExpiryDate!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND vehicle.licenseExpiryDate=:licenseExpiryDate"
					namedParams.put("licenseExpiryDate", new Date(new Long(params.filter.licenseExpiryDate)))
					sortableParams.put("filter.licenseExpiryDate", params.filter.licenseExpiryDate) 
				}
				
				if (params.filter?.tracking && params.filter?.tracking!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND vehicle.tracking=:tracking"
					namedParams.put("tracking", new Boolean(params.filter.tracking))
					sortableParams.put("filter.tracking", params.filter.tracking) 
				}
				
				if (params.filter?.vinNumber && params.filter?.vinNumber!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND vehicle.vinNumber=:vinNumber"
					namedParams.put("vinNumber", params.filter.vinNumber)
					sortableParams.put("filter.vinNumber", params.filter.vinNumber) 
				}
				
		return whereSql
	}
	
	
	def applyCallbackParams(params,namedParams, sortableParams, whereSql) {
		
		// if list is shown to associate or deassociate objects,
		// the filter must show only not already associated objects or only the associated objects
		if (params.callback && params.callback != "") {
			def notOperator = ""
			def neOperator = "="
			if (params.callback == "link") {
				notOperator = "not"
				neOperator = "<>"
			}
			
			def rd = params.refDest
			// restrict list only if not unidirectional
			if (rd && rd != "") {
				if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(Vehicle.class, rd))) {
					// n:m
					whereSql += " AND :xxx " + notOperator + " in elements(vehicle.${rd})"
					namedParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
					sortableParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
				} else {
					// 1:n
					whereSql += " AND vehicle.${rd} " + neOperator + " :xxx"
					namedParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
					sortableParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
				}
			}
		}
		return whereSql
	}
	
	
	def applySortCriterias(params) {
		
		// now start with sorting criterias...
		String sql = ""
		if (params.sort) {
			def sortProperties = params.sort.split(",")
			
			for ( String p : sortProperties ){
				p = p.trim()
				sql += p + " " + (params.order ? params.order : "") + ", "
			}
			
			// ...and finally add the order by
			if (sql.length() > 1) {
				sql = " order by " + sql.substring(0, sql.length()-2)
			}
		}
		return sql
	}


    def showReminders = {
        def vehicleInstance = Vehicle.getComposite(params.id)
        def reminders = vehicleInstance.listActiveReminders()
        return [reminders: reminders]
    }

	
}
