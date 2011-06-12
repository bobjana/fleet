<%=packageName ? "package ${packageName}\n\n" : ''%>class ${className}Controller {
	
	<% import grails.persistence.Event %>
	
	static allowedMethods = [save: "POST", update: "POST", delete: ['POST','GET']]
	
	def index = {
		redirect(action: "list", params: params)
	}
	
	def list = {
		// pre process the input params and set defaults
		if (!params.max) params.max = 20
		if (!params.offset) params.offset = 0
		
		// sort may stay null, if Domain does not support sorting 
		
		if (!params.sort) params.sort = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(${className}.class, 'mapping')?.getMapping()?.getSort()
		if (!params.order) params.order = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(${className}.class, 'mapping')?.getMapping()?.getOrder()
		if (!params.order) params.order = "asc"
		
		// parameters for hsql query
		Hashtable namedParams = new Hashtable();
		
		// parameters for sortableColumn in list view, they have a prefix "filter."
		Hashtable sortableParams = new Hashtable();
		
		// separated parts of the hsql query
		def querySql = "FROM ${className} ${domainClass.propertyName} WHERE 1=1"
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
		def result = ${className}.findAll(querySql + whereSql + orderBySql, namedParams, [max:params.max.toInteger(), offset:params.offset.toInteger()])
		
		/// ...and the total number of records        
		def countResult = ${className}.executeQuery("select count(*) "+ querySql + whereSql, namedParams)
		def paginateTotal = countResult[0]
		
		// use "show" view instead of list, if there is only one record in result
		// as long as there is no (de-)associating on the way
		if ((paginateTotal == 1) && (result.size == 1) && (!params.callback)) {
			redirect(action: "show", id: result.get(0).compositeId)
			return
		} 
		
		return [${propertyName}List: result, paginateTotal:paginateTotal, sortableParams:sortableParams]
	}
	
	
	def create = {
		def ${propertyName} = new ${className}()
		${propertyName}.properties = params
		return [${propertyName}: ${propertyName}]
	}
	
	
	def save = {
		def ${propertyName} = new ${className}(params)
		if (${propertyName}.save(flush: true)) {
			flash.message = "\${message(code: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}])}"
			
			// during association, the callback must be executed
			if (params.source != null && params.source != "") {
				def linkClass = grailsApplication.getClassForName(params.class)
				def theLink = linkClass.getComposite(params.source_id)
				def d = params.dest
				theLink."addTo\${d[0].toUpperCase()+d.substring(1)}"( ${propertyName} );
				
				def rd = params.refDest
				// set just if not unidirectional
				if (rd && rd != "") {
					if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(${className}.class, rd))) {
						${propertyName}."addTo\${rd[0].toUpperCase()+rd.substring(1)}"( theLink );
					}
				}
				theLink.save()
				
				// and back to edit page of associated object
				redirect(controller:params.source, action:"edit", id:params.source_id)
			} else {
				// HK go to list instead of show
				//redirect(action: "show", id: ${propertyName}.id)
				redirect(action:list)
			}
		}
		else {
			render(view: "create", model: [${propertyName}: ${propertyName}])
		}
	}
	
	
	def show = {
		def ${propertyName} = ${className}.getComposite(params.id)
		if (!${propertyName}) {
			flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
			redirect(action: "list")
		}
		else {
			[${propertyName}: ${propertyName}]
		}
	}
	
	
	def edit = {
		def ${propertyName} = ${className}.getComposite(params.id)
		if (!${propertyName}) {
			flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [${propertyName}: ${propertyName}]
		}
	}
	
	
	def update = {
		def ${propertyName} = ${className}.getComposite(params.id)
		if (${propertyName}) {
			if (params.version) {
				def version = params.version.toLong()
				if (${propertyName}.version > version) {
					<% def lowerCaseName = grails.util.GrailsNameUtils.getPropertyName(className) %>
					${propertyName}.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: '${domainClass.propertyName}.label', default: '${className}')] as Object[], "Another user has updated this ${className} while you were editing.")
					render(view: "edit", model: [${propertyName}: ${propertyName}])
					return
				}
			}
			${propertyName}.properties = params
			if (!${propertyName}.hasErrors() && ${propertyName}.save(flush: true)) {
				flash.message = "\${message(code: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}])}"
				// go to list instead of show
				//redirect(action: "show", id: ${propertyName}.id)
				redirect(action:"list")
			}
			else {
				render(view: "edit", model: [${propertyName}: ${propertyName}])
			}
		}
		else {
			flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
			redirect(action: "list")
		}
	}
	
	
	def delete = {
		def ${propertyName} = ${className}.getComposite(params.id)
		if (${propertyName}) {
			try {
				// HK: special deletion neccessary for some relationships
				// the final delete is placed in the domain class
				// ${propertyName}.delete(flush: true)
				deleteReferencesInController(${propertyName})
				${propertyName}.deleteAndClearReferences()
				
				flash.message = "\${message(code: 'default.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				log.error("Delete Exception: " + e)
				flash.message = "\${message(code: 'default.not.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
			redirect(action: "list")
		}
	}
	
	
	def choose = {
		// redirect to (de-)associating
		params.class="${(packageName!=""?packageName+".":"")}${className}"
		redirect(controller:params.source,action:params.callback,params:params)
	}
	
	
	def link = {
		// establish the association
		def ${propertyName} = ${className}.getComposite(params.source_id)
		def linkClass = grailsApplication.getClassForName(params.class)
		def theLink = linkClass.getComposite(params.id)
		def d = params.dest
		
		${propertyName}."addTo\${d[0].toUpperCase()+d.substring(1)}"( theLink );
		${propertyName}.validate() // will mark any errors in edit view
		
		def rd = params.refDest
		// set other side just if not unidirectional
		if (rd && rd != "") {
			if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(linkClass, rd))) {
				// n:m
				theLink."addTo\${rd[0].toUpperCase()+rd.substring(1)}"(${propertyName})
				
				try {
					theLink.save(flush:true)
				} catch (org.springframework.dao.DataIntegrityViolationException e) {
					log.error("Link Exception: " + e)
					${propertyName}.errors.reject("${propertyName}.\${d}.associate.failed", [params.id] as Object[], "Unable to associate " + linkClass + " with id \${params.id}")
				}
			}
		}	  
		// use render instead of redirect to get validation errors
		render(view:'edit',model:[${propertyName}:${propertyName}])
	}
	
	
	def unlink = {
		// remove the association, without deleting any object
		def ${propertyName} = ${className}.getComposite(params.source_id)
		def linkClass = grailsApplication.getClassForName(params.class)
		def theLink = linkClass.getComposite(params.id)
		def d = params.dest
		${propertyName}."removeFrom\${d[0].toUpperCase()+d.substring(1)}"( theLink );
		
		${propertyName}.validate() // will mark any errors in edit view
		
		def rd = params.refDest
		// set other side just if not unidirectional
		if (rd && rd != "") {
			if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(linkClass, rd))) {
				// n:m
				theLink."removeFrom\${rd[0].toUpperCase()+rd.substring(1)}"(${propertyName})
				
				try {
					theLink.save(flush:true)
				} catch (org.springframework.dao.DataIntegrityViolationException e) {
					log.error("Unlink Exception: " + e)
					${propertyName}.errors.reject("${propertyName}.\${d}.deassociate.failed", [params.id] as Object[], "Unable to deassociate " + linkClass + " with id \${params.id}")
				}
			}
		}
		
		// use render instead of redirect to get validation errors
		render(view:'edit',model:[${propertyName}:${propertyName}])
	}
	
	
	private void deleteReferencesInController(x) {
		// would be better to place this code in domain or service
		// but that's not possible due to generation limitations
		<%
		props = domainClass.properties.findAll { it.type == Set.class }
		props.eachWithIndex { p,i ->
			
			if(!p.isOwningSide() && p.manyToMany) { %>
				${p.referencedDomainClass.fullName}.findAll("from ${p.referencedDomainClass.shortName} y where :x in elements(y.${p.otherSide.name})", [x:x])?.each {
					it.removeFrom${p.otherSide.naturalName.replaceAll(" ", "")}(x)
				}
				<% } } %>
	}
	
	
	// internal helper methods
	def applyFilters(params,namedParams, sortableParams, whereSql) {
		
		// start with filter attributes...
		<%
		excludedProps = Event.allEvents.toList() << 'version' // << 'id' << 'dateCreated' << 'lastUpdated'
		persistentPropNames = domainClass.persistentProperties*.name
		// Set.class has many elements, which cannot be filtered -> exclude
		props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != Set.class}
		Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
		
		props.eachWithIndex { p,i ->
			cp = domainClass.constrainedProperties[p.name]
			display = (cp ? cp.display : true)
			if (p.isPersistent() && display) {
				
				// association difference is only
				// a) the additional .id after property name
				// b) always Long typecasting in namedParams
				String filterValue = ""
				String associationSuffix = ""
				if (p.isAssociation()) {
					filterValue = "new Long(params.filter.${p.name})"
					associationSuffix = ".id"
				} else if (p.type.name == "java.util.Date") {
					filterValue = "new Date(new Long(params.filter.${p.name}))"
				} else if (p.type.name == "java.lang.Long" || p.type.name == "long") {
					filterValue = "new Long(params.filter.${p.name})"
				} else if (p.type.name == "java.lang.Integer" || p.type.name == "int") {
					filterValue = "new Integer(params.filter.${p.name})"
				} else if (p.type.name == "boolean" || p.type.name == "java.lang.Boolean") {
					filterValue = "new Boolean(params.filter.${p.name})"
				} else if (p.type.name == "double" || p.type.name == "java.lang.Double") {
					filterValue = "new Double(params.filter.${p.name})"
				} else if (p.type.name == "java.math.BigDecimal") {
					filterValue = "new BigDecimal(params.filter.${p.name})"
				} else if (p.isEnum()) {
					filterValue = "(${p.type.name})Enum.valueOf(${p.type.name}.class, params.filter.${p.name})"
				} else {
					// default for strings
					filterValue = "params.filter.${p.name}"
				}
				%>
				if (params.filter?.${p.name} && params.filter?.${p.name}!= Integer.MIN_VALUE.toString()) {
					whereSql += " AND ${domainClass.propertyName}.${p.name}${associationSuffix}=:${p.name}"
					namedParams.put("${p.name}", ${filterValue})
					sortableParams.put("filter.${p.name}", params.filter.${p.name}) 
				}
				<%		
			} // if isPersistent
		} // eachWithIndex
		%>
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
				if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(${className}.class, rd))) {
					// n:m
					whereSql += " AND :xxx " + notOperator + " in elements(${domainClass.propertyName}.\${rd})"
					namedParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
					sortableParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
				} else {
					// 1:n
					whereSql += " AND ${domainClass.propertyName}.\${rd} " + neOperator + " :xxx"
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
