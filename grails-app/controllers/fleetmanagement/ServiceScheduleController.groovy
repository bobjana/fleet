package fleetmanagement

class ServiceScheduleController {
	
	
	
	static allowedMethods = [save: "POST", update: "POST", delete: ['POST','GET']]
	
	def index = {
		redirect(action: "list", params: params)
	}
	
	def list = {
		// pre process the input params and set defaults
		if (!params.max) params.max = 20
		if (!params.offset) params.offset = 0
		
		// sort may stay null, if Domain does not support sorting 
		
		if (!params.sort) params.sort = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(ServiceSchedule.class, 'mapping')?.getMapping()?.getSort()
		if (!params.order) params.order = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(ServiceSchedule.class, 'mapping')?.getMapping()?.getOrder()
		if (!params.order) params.order = "asc"
		
		// parameters for hsql query
		Hashtable namedParams = new Hashtable();
		
		// parameters for sortableColumn in list view, they have a prefix "filter."
		Hashtable sortableParams = new Hashtable();
		
		// separated parts of the hsql query
		def querySql = "FROM ServiceSchedule serviceSchedule WHERE 1=1"
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
		def result = ServiceSchedule.findAll(querySql + whereSql + orderBySql, namedParams, [max:params.max.toInteger(), offset:params.offset.toInteger()])
		
		/// ...and the total number of records        
		def countResult = ServiceSchedule.executeQuery("select count(*) "+ querySql + whereSql, namedParams)
		def paginateTotal = countResult[0]
		
		// use "show" view instead of list, if there is only one record in result
		// as long as there is no (de-)associating on the way
		if ((paginateTotal == 1) && (result.size == 1) && (!params.callback)) {
			redirect(action: "show", id: result.get(0).compositeId)
			return
		} 
		
		return [serviceScheduleInstanceList: result, paginateTotal:paginateTotal, sortableParams:sortableParams]
	}
	
	
	def create = {
		def serviceScheduleInstance = new ServiceSchedule()
		serviceScheduleInstance.properties = params
		return [serviceScheduleInstance: serviceScheduleInstance]
	}
	
	
	def save = {
		def serviceScheduleInstance = new ServiceSchedule(params)
		if (serviceScheduleInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'serviceSchedule.label', default: 'ServiceSchedule'), serviceScheduleInstance])}"
			
			// during association, the callback must be executed
			if (params.source != null && params.source != "") {
				def linkClass = grailsApplication.getClassForName(params.class)
				def theLink = linkClass.getComposite(params.source_id)
				def d = params.dest
				theLink."addTo${d[0].toUpperCase()+d.substring(1)}"( serviceScheduleInstance );
				
				def rd = params.refDest
				// set just if not unidirectional
				if (rd && rd != "") {
					if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(ServiceSchedule.class, rd))) {
						serviceScheduleInstance."addTo${rd[0].toUpperCase()+rd.substring(1)}"( theLink );
					}
				}
				theLink.save()
				
				// and back to edit page of associated object
				redirect(controller:params.source, action:"edit", id:params.source_id)
			} else {
				// HK go to list instead of show
				//redirect(action: "show", id: serviceScheduleInstance.id)
				redirect(action:list)
			}
		}
		else {
			render(view: "create", model: [serviceScheduleInstance: serviceScheduleInstance])
		}
	}
	
	
	def show = {
		def serviceScheduleInstance = ServiceSchedule.getComposite(params.id)
		if (!serviceScheduleInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'serviceSchedule.label', default: 'ServiceSchedule'), params.id])}"
			redirect(action: "list")
		}
		else {
			[serviceScheduleInstance: serviceScheduleInstance]
		}
	}
	
	
	def edit = {
		def serviceScheduleInstance = ServiceSchedule.getComposite(params.id)
		if (!serviceScheduleInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'serviceSchedule.label', default: 'ServiceSchedule'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [serviceScheduleInstance: serviceScheduleInstance]
		}
	}
	
	
	def update = {
		def serviceScheduleInstance = ServiceSchedule.getComposite(params.id)
		if (serviceScheduleInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (serviceScheduleInstance.version > version) {
					
					serviceScheduleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'serviceSchedule.label', default: 'ServiceSchedule')] as Object[], "Another user has updated this ServiceSchedule while you were editing.")
					render(view: "edit", model: [serviceScheduleInstance: serviceScheduleInstance])
					return
				}
			}
			serviceScheduleInstance.properties = params
			if (!serviceScheduleInstance.hasErrors() && serviceScheduleInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'serviceSchedule.label', default: 'ServiceSchedule'), serviceScheduleInstance])}"
				// go to list instead of show
				//redirect(action: "show", id: serviceScheduleInstance.id)
				redirect(action:"list")
			}
			else {
				render(view: "edit", model: [serviceScheduleInstance: serviceScheduleInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'serviceSchedule.label', default: 'ServiceSchedule'), params.id])}"
			redirect(action: "list")
		}
	}
	
	
	def delete = {
		def serviceScheduleInstance = ServiceSchedule.getComposite(params.id)
		if (serviceScheduleInstance) {
			try {
				// HK: special deletion neccessary for some relationships
				// the final delete is placed in the domain class
				// serviceScheduleInstance.delete(flush: true)
				deleteReferencesInController(serviceScheduleInstance)
				serviceScheduleInstance.deleteAndClearReferences()
				
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'serviceSchedule.label', default: 'ServiceSchedule'), serviceScheduleInstance])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				log.error("Delete Exception: " + e)
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'serviceSchedule.label', default: 'ServiceSchedule'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'serviceSchedule.label', default: 'ServiceSchedule'), params.id])}"
			redirect(action: "list")
		}
	}
	
	
	def choose = {
		// redirect to (de-)associating
		params.class="fleetmanagement.ServiceSchedule"
		redirect(controller:params.source,action:params.callback,params:params)
	}
	
	
	def link = {
		// establish the association
		def serviceScheduleInstance = ServiceSchedule.getComposite(params.source_id)
		def linkClass = grailsApplication.getClassForName(params.class)
		def theLink = linkClass.getComposite(params.id)
		def d = params.dest
		
		serviceScheduleInstance."addTo${d[0].toUpperCase()+d.substring(1)}"( theLink );
		serviceScheduleInstance.validate() // will mark any errors in edit view
		
		def rd = params.refDest
		// set other side just if not unidirectional
		if (rd && rd != "") {
			if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(linkClass, rd))) {
				// n:m
				theLink."addTo${rd[0].toUpperCase()+rd.substring(1)}"(serviceScheduleInstance)
				
				try {
					theLink.save(flush:true)
				} catch (org.springframework.dao.DataIntegrityViolationException e) {
					log.error("Link Exception: " + e)
					serviceScheduleInstance.errors.reject("serviceScheduleInstance.${d}.associate.failed", [params.id] as Object[], "Unable to associate " + linkClass + " with id ${params.id}")
				}
			}
		}	  
		// use render instead of redirect to get validation errors
		render(view:'edit',model:[serviceScheduleInstance:serviceScheduleInstance])
	}
	
	
	def unlink = {
		// remove the association, without deleting any object
		def serviceScheduleInstance = ServiceSchedule.getComposite(params.source_id)
		def linkClass = grailsApplication.getClassForName(params.class)
		def theLink = linkClass.getComposite(params.id)
		def d = params.dest
		serviceScheduleInstance."removeFrom${d[0].toUpperCase()+d.substring(1)}"( theLink );
		
		serviceScheduleInstance.validate() // will mark any errors in edit view
		
		def rd = params.refDest
		// set other side just if not unidirectional
		if (rd && rd != "") {
			if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(linkClass, rd))) {
				// n:m
				theLink."removeFrom${rd[0].toUpperCase()+rd.substring(1)}"(serviceScheduleInstance)
				
				try {
					theLink.save(flush:true)
				} catch (org.springframework.dao.DataIntegrityViolationException e) {
					log.error("Unlink Exception: " + e)
					serviceScheduleInstance.errors.reject("serviceScheduleInstance.${d}.deassociate.failed", [params.id] as Object[], "Unable to deassociate " + linkClass + " with id ${params.id}")
				}
			}
		}
		
		// use render instead of redirect to get validation errors
		render(view:'edit',model:[serviceScheduleInstance:serviceScheduleInstance])
	}
	
	
	private void deleteReferencesInController(x) {
		// would be better to place this code in domain or service
		// but that's not possible due to generation limitations
		
	}
	
	
	// internal helper methods
	def applyFilters(params,namedParams, sortableParams, whereSql) {
		
		// start with filter attributes...
		
				if (params.filter?.nextService && params.filter?.nextService!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND serviceSchedule.nextService=:nextService"
					namedParams.put("nextService", new Date(new Long(params.filter.nextService)))
					sortableParams.put("filter.nextService", params.filter.nextService) 
				}
				
				if (params.filter?.serviceInterval && params.filter?.serviceInterval!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND serviceSchedule.serviceInterval=:serviceInterval"
					namedParams.put("serviceInterval", new Integer(params.filter.serviceInterval))
					sortableParams.put("filter.serviceInterval", params.filter.serviceInterval) 
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
				if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(ServiceSchedule.class, rd))) {
					// n:m
					whereSql += " AND :xxx " + notOperator + " in elements(serviceSchedule.${rd})"
					namedParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
					sortableParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
				} else {
					// 1:n
					whereSql += " AND serviceSchedule.${rd} " + neOperator + " :xxx"
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
	
}
