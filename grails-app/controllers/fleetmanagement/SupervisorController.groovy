package fleetmanagement

class SupervisorController {
	
	
	
	static allowedMethods = [save: "POST", update: "POST", delete: ['POST','GET']]
	
	def index = {
		redirect(action: "list", params: params)
	}
	
	def list = {
		// pre process the input params and set defaults
		if (!params.max) params.max = 20
		if (!params.offset) params.offset = 0
		
		// sort may stay null, if Domain does not support sorting 
		
		if (!params.sort) params.sort = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(Supervisor.class, 'mapping')?.getMapping()?.getSort()
		if (!params.order) params.order = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(Supervisor.class, 'mapping')?.getMapping()?.getOrder()
		if (!params.order) params.order = "asc"
		
		// parameters for hsql query
		Hashtable namedParams = new Hashtable();
		
		// parameters for sortableColumn in list view, they have a prefix "filter."
		Hashtable sortableParams = new Hashtable();
		
		// separated parts of the hsql query
		def querySql = "FROM Supervisor supervisor WHERE 1=1"
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
		def result = Supervisor.findAll(querySql + whereSql + orderBySql, namedParams, [max:params.max.toInteger(), offset:params.offset.toInteger()])
		
		/// ...and the total number of records        
		def countResult = Supervisor.executeQuery("select count(*) "+ querySql + whereSql, namedParams)
		def paginateTotal = countResult[0]
		
		// use "show" view instead of list, if there is only one record in result
		// as long as there is no (de-)associating on the way
		if ((paginateTotal == 1) && (result.size == 1) && (!params.callback)) {
			redirect(action: "show", id: result.get(0).compositeId)
			return
		} 
		
		return [supervisorInstanceList: result, paginateTotal:paginateTotal, sortableParams:sortableParams]
	}
	
	
	def create = {
		def supervisorInstance = new Supervisor()
		supervisorInstance.properties = params
		return [supervisorInstance: supervisorInstance]
	}
	
	
	def save = {
		def supervisorInstance = new Supervisor(params)
		if (supervisorInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), supervisorInstance])}"
			
			// during association, the callback must be executed
			if (params.source != null && params.source != "") {
				def linkClass = grailsApplication.getClassForName(params.class)
				def theLink = linkClass.getComposite(params.source_id)
				def d = params.dest
				theLink."addTo${d[0].toUpperCase()+d.substring(1)}"( supervisorInstance );
				
				def rd = params.refDest
				// set just if not unidirectional
				if (rd && rd != "") {
					if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(Supervisor.class, rd))) {
						supervisorInstance."addTo${rd[0].toUpperCase()+rd.substring(1)}"( theLink );
					}
				}
				theLink.save()
				
				// and back to edit page of associated object
				redirect(controller:params.source, action:"edit", id:params.source_id)
			} else {
				// HK go to list instead of show
				//redirect(action: "show", id: supervisorInstance.id)
				redirect(action:list)
			}
		}
		else {
			render(view: "create", model: [supervisorInstance: supervisorInstance])
		}
	}
	
	
	def show = {
		def supervisorInstance = Supervisor.getComposite(params.id)
		if (!supervisorInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), params.id])}"
			redirect(action: "list")
		}
		else {
			[supervisorInstance: supervisorInstance]
		}
	}
	
	
	def edit = {
		def supervisorInstance = Supervisor.getComposite(params.id)
		if (!supervisorInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [supervisorInstance: supervisorInstance]
		}
	}
	
	
	def update = {
		def supervisorInstance = Supervisor.getComposite(params.id)
		if (supervisorInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (supervisorInstance.version > version) {
					
					supervisorInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'supervisor.label', default: 'Supervisor')] as Object[], "Another user has updated this Supervisor while you were editing.")
					render(view: "edit", model: [supervisorInstance: supervisorInstance])
					return
				}
			}
			supervisorInstance.properties = params
			if (!supervisorInstance.hasErrors() && supervisorInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), supervisorInstance])}"
				// go to list instead of show
				//redirect(action: "show", id: supervisorInstance.id)
				redirect(action:"list")
			}
			else {
				render(view: "edit", model: [supervisorInstance: supervisorInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), params.id])}"
			redirect(action: "list")
		}
	}
	
	
	def delete = {
		def supervisorInstance = Supervisor.getComposite(params.id)
		if (supervisorInstance) {
			try {
				// HK: special deletion neccessary for some relationships
				// the final delete is placed in the domain class
				// supervisorInstance.delete(flush: true)
				deleteReferencesInController(supervisorInstance)
				supervisorInstance.deleteAndClearReferences()
				
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), supervisorInstance])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				log.error("Delete Exception: " + e)
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), params.id])}"
			redirect(action: "list")
		}
	}
	
	
	def choose = {
		// redirect to (de-)associating
		params.class="fleetmanagement.Supervisor"
		redirect(controller:params.source,action:params.callback,params:params)
	}
	
	
	def link = {
		// establish the association
		def supervisorInstance = Supervisor.getComposite(params.source_id)
		def linkClass = grailsApplication.getClassForName(params.class)
		def theLink = linkClass.getComposite(params.id)
		def d = params.dest
		
		supervisorInstance."addTo${d[0].toUpperCase()+d.substring(1)}"( theLink );
		supervisorInstance.validate() // will mark any errors in edit view
		
		def rd = params.refDest
		// set other side just if not unidirectional
		if (rd && rd != "") {
			if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(linkClass, rd))) {
				// n:m
				theLink."addTo${rd[0].toUpperCase()+rd.substring(1)}"(supervisorInstance)
				
				try {
					theLink.save(flush:true)
				} catch (org.springframework.dao.DataIntegrityViolationException e) {
					log.error("Link Exception: " + e)
					supervisorInstance.errors.reject("supervisorInstance.${d}.associate.failed", [params.id] as Object[], "Unable to associate " + linkClass + " with id ${params.id}")
				}
			}
		}	  
		// use render instead of redirect to get validation errors
		render(view:'edit',model:[supervisorInstance:supervisorInstance])
	}
	
	
	def unlink = {
		// remove the association, without deleting any object
		def supervisorInstance = Supervisor.getComposite(params.source_id)
		def linkClass = grailsApplication.getClassForName(params.class)
		def theLink = linkClass.getComposite(params.id)
		def d = params.dest
		supervisorInstance."removeFrom${d[0].toUpperCase()+d.substring(1)}"( theLink );
		
		supervisorInstance.validate() // will mark any errors in edit view
		
		def rd = params.refDest
		// set other side just if not unidirectional
		if (rd && rd != "") {
			if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(linkClass, rd))) {
				// n:m
				theLink."removeFrom${rd[0].toUpperCase()+rd.substring(1)}"(supervisorInstance)
				
				try {
					theLink.save(flush:true)
				} catch (org.springframework.dao.DataIntegrityViolationException e) {
					log.error("Unlink Exception: " + e)
					supervisorInstance.errors.reject("supervisorInstance.${d}.deassociate.failed", [params.id] as Object[], "Unable to deassociate " + linkClass + " with id ${params.id}")
				}
			}
		}
		
		// use render instead of redirect to get validation errors
		render(view:'edit',model:[supervisorInstance:supervisorInstance])
	}
	
	
	private void deleteReferencesInController(x) {
		// would be better to place this code in domain or service
		// but that's not possible due to generation limitations
		
	}
	
	
	// internal helper methods
	def applyFilters(params,namedParams, sortableParams, whereSql) {
		
		// start with filter attributes...
		
				if (params.filter?.firstName && params.filter?.firstName!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND supervisor.firstName=:firstName"
					namedParams.put("firstName", params.filter.firstName)
					sortableParams.put("filter.firstName", params.filter.firstName) 
				}
				
				if (params.filter?.surname && params.filter?.surname!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND supervisor.surname=:surname"
					namedParams.put("surname", params.filter.surname)
					sortableParams.put("filter.surname", params.filter.surname) 
				}
				
				if (params.filter?.branch && params.filter?.branch!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND supervisor.branch.id=:branch"
					namedParams.put("branch", new Long(params.filter.branch))
					sortableParams.put("filter.branch", params.filter.branch) 
				}
				
				if (params.filter?.cellPhoneNumber && params.filter?.cellPhoneNumber!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND supervisor.cellPhoneNumber=:cellPhoneNumber"
					namedParams.put("cellPhoneNumber", params.filter.cellPhoneNumber)
					sortableParams.put("filter.cellPhoneNumber", params.filter.cellPhoneNumber) 
				}
				
				if (params.filter?.email && params.filter?.email!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND supervisor.email=:email"
					namedParams.put("email", params.filter.email)
					sortableParams.put("filter.email", params.filter.email) 
				}
				
				if (params.filter?.employeeCode && params.filter?.employeeCode!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND supervisor.employeeCode=:employeeCode"
					namedParams.put("employeeCode", params.filter.employeeCode)
					sortableParams.put("filter.employeeCode", params.filter.employeeCode) 
				}
				
				if (params.filter?.idNumber && params.filter?.idNumber!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND supervisor.idNumber=:idNumber"
					namedParams.put("idNumber", params.filter.idNumber)
					sortableParams.put("filter.idNumber", params.filter.idNumber) 
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
				if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(Supervisor.class, rd))) {
					// n:m
					whereSql += " AND :xxx " + notOperator + " in elements(supervisor.${rd})"
					namedParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
					sortableParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
				} else {
					// 1:n
					whereSql += " AND supervisor.${rd} " + neOperator + " :xxx"
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
