<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.list.label" args="[entityName]" encodeAs="HTML"/></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" encodeAs="HTML"/></h1>
            <g:if test="\${flash.message}">
            <div class="message"><g:message code="\${flash.message}" args="\${flash.args}" default="\${flash.defaultMessage}" encodeAs="HTML"/></div>
            </g:if>
            
            <g:hasErrors bean="\${${propertyName}}">
            <div class="errors">
                <g:renderErrors bean="\${${propertyName}}" as="list" />
            </div>
            </g:hasErrors>
            
			<g:form action="list" method="post" >
				<fieldset>
					<!-- do not forget sort and order criteria -->
					<g:hiddenField name="sort" value="\${params.sort}" />
					<g:hiddenField name="order" value="\${params.order}" />
	
					<!-- do not forget source for associating existing objects -->
					<g:if test="\${params.callback}">
						<g:hiddenField name="callback" value="\${params.callback}" />
					</g:if>
					<g:if test="\${params.source}">
						<g:hiddenField name="source" value="\${params.source}" />
					</g:if>
					<g:if test="\${params.source_id}">
						<g:hiddenField name="source_id" value="\${params.source_id}" />
					</g:if>
					<g:if test="\${params.class}">
						<g:hiddenField name="class" value="\${params.class}" />
					</g:if>
					<g:if test="\${params.dest}">
						<g:hiddenField name="dest" value="\${params.dest}" />
					</g:if>
					<g:if test="\${params.refDest}">
						<g:hiddenField name="refDest" value="\${params.refDest}" />
					</g:if>
		
		            <g:if test="\${!${propertyName}List}">
						<g:message code="default.list.empty" default="No records available." encodeAs="HTML"/>
					</g:if>            
					<g:else>
		            <div class="list">
		                <table>
		                    <thead>
		                        <tr><% // one empty header for icon column %>
		                        	<th>&nbsp;</th>
		                        <%  excludedProps = Event.allEvents.toList() << 'version'
		                            allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
		                            // HK 24.08.10 removed isAssignableFrom() for manyInList feature
									//props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && !Collection.isAssignableFrom(it.type) }
									props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
		                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
		
									props.eachWithIndex { p, i ->
												cp = domainClass.constrainedProperties[p.name]
					                            display = (cp ? cp.display : true)      
												pwd = (cp ? cp.password : false)
												listable = (cp?.attributes?.listable != null ? cp.attributes.listable : true)
												manyInList = cp?.attributes?.manyInList
												
					                    		if(display && listable && !pwd && ((!Collection.isAssignableFrom(p.type) && !Map.isAssignableFrom(p.type)) || manyInList)) { 
														// filter transients and 1:n many side
					                   	                if(!p.isPersistent() || Collection.isAssignableFrom(p.type)) { %>
					                   	        <th class="notsortable"><g:message code="${propertyName}.${p.name}" default="${p.naturalName}" encodeAs="HTML"/></th>
					                   	    <%          } else { 
					                   	    				if (!p.isAssociation() || p.isEnum()) { %>
					                   	        <g:sortableColumn params="\${(!sortableParams.isEmpty()?sortableParams:\"\")}" property="${p.name}" title="${p.naturalName}" titleKey="${domainClass.propertyName}.${p.name}.label" />
															<% } else { 
																	mappingSort = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(className.class, 'mapping')?.getMapping()?.getSort()
																	mappingOrder = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(className.class, 'mapping')?.getMapping()?.getOrder()
																	if (!mappingOrder) { mappingOrder="asc" }
																	if (!mappingSort) { %>
												<th class="notsortable"><g:message code="${propertyName}.${p.name}" default="${p.naturalName}" encodeAs="HTML"/></th>
																		<% } else { %>
												<g:sortableColumn params="\${(!sortableParams.isEmpty()?sortableParams:\"\")}" property="${p.name}.\${${p.getType().getName()}.mapping.getMapping().getSort()}" defaultOrder="\${${p.getType().getName()}.mapping.getMapping().getOrder()}" title="${p.naturalName}" titleKey="${domainClass.propertyName}.${p.name}.label" />
					                <%  }	}	   }   } } %>
		                        </tr>
		                    </thead>
		                    <tbody> <% //HK filterable column features START %>
		                        <tr><% // one empty filter for icon column %> 
		                        	<td>&nbsp;</td>
		                        	 <% 
										//a property 			<g:select onchange="submit();" noSelection="[Integer.MIN_VALUE:'-Filter-']" optionKey="" from="${Project.executeQuery('select distinct a.isCompany from Project as a where a.isCompany is not null order by a.isCompany')}" name="filter.isCompany" value="${params.filter?.isCompany}" optionValue=''></g:select>
										//b timestamp property	<g:select onchange="submit();" noSelection="[Integer.MIN_VALUE:'-Filter-']" optionKey="time" from="${Project.executeQuery('select distinct a.begindate from Project as a where a.begindate is not null order by a.begindate')}" name="filter.begindate" value="${params.filter?.begindate}" optionValue=''></g:select>
										//c nested property		<g:select onchange="submit();" noSelection="[Integer.MIN_VALUE:'-Filter-']" optionKey="id" from="${Person.executeQuery('select distinct a from Person as a, Project as b where a=b.extPerson').sort()}" name="filter.extPerson" value="${params.filter?.extPerson}" optionValue=''></g:select>
										//d enum property
									 	//e boolean property -> valueMessagePrefix required
										props.eachWithIndex { p,i ->
											cp = domainClass.constrainedProperties[p.name]
				                            display = (cp ? cp.display : true)      
											pwd = (cp ? cp.password : false)
											listable = (cp?.attributes?.listable != null ? cp.attributes.listable : true)
											manyInList = cp?.attributes?.manyInList
											cssStyle = (cp?.attributes ? cp.attributes.cssStyle : "")
											if (cssStyle == null) {
												cssStyle = ""
											} else {
												cssStyle = "style=\"" + cssStyle + "\"" 
											}
				                    		if(display && listable && !pwd && (!Collection.isAssignableFrom(p.type) || manyInList)) { 
												def optionKey = ""
												def optionValue = ""
												def valueMessagePrefix = ""
												// filter transients and 1:n many side
			                   	                if(p.isPersistent() && !Collection.isAssignableFrom(p.type)) {
			                   	                	if (!p.isAssociation() || p.isEnum()) {
		                   	                			from = "\${${className}.executeQuery('select distinct a.${p.name} from ${className} as a where a.${p.name} is not null and length(a.${p.name})>0 order by a.${p.name}')}"
														if (p.isEnum()) {
			                   	                			optionValue = "\${{message(code:'${propertyName}.${p.name}.'+it,default:it.toString(), encodeAs:'HTML')}}"
			                   	                		} else if (p.type == Boolean.class || p.type == boolean) {
															// e
														    // translate true/false to something more readable    
															valueMessagePrefix = "default.boolean"
			                   	                		} else if (!(p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class)) {
			                   	                			// a
			                   	                		} else {
			                   	                			// b
			                   	                			optionKey = "time"
													    	dateFormatName = (cp?.attributes ? cp.attributes.dateFormatName : null)
													    	if (dateFormatName != null) {
													    		optionValue = "\${{formatDate(formatName:'${dateFormatName}',date:it)}}"
													    	} else {
													    		dateFormat = (cp?.attributes ? cp.attributes.dateFormat : null)
													    		if (dateFormat != null) {
													    			optionValue = "\${{formatDate(format:'${dateFormat}',date:it)}}"
													    		} else {
													    			if (p.type == java.sql.Time.class) { 
													    				optionValue = "\${{formatDate(format:'HH:mm:SS',date:it)}}"
													    			} else {
																		optionValue = "\${{formatDate(format:'dd.MM.yyyy',date:it)}}"
																	}
													    		}
													    	}
			                   	                		}
			                   	                	} else {
			                   	                		// c - association
													    // workaround hsql due to hibernate "bug": left and right hand sides of a binary logic operator were incompatibile
													    // solution in http://jira.sakaiproject.org/browse/SAK-11193
													   	String otherSideName=""
													    if (p.otherSide && !p.manyToOne) {
														   otherSideName = "." + p.otherSide.name
													    }
			                   	                		from = "\${${p.type.name}.executeQuery('select distinct a from ${p.type.name} as a, ${className} as b where a${otherSideName}=b.${p.name}${otherSideName}').sort()}"
			                   	                		optionKey = "id"
			                   	                		optionValue = ""
			                   	                	}
			                   	                	
			                   	        %>
										<td>
											<g:select ${cssStyle} onchange="submit();" noSelection="['${Integer.MIN_VALUE}':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="${optionKey}" from="${from}" name="filter.${p.name}" value="\${params.filter?.${p.name}}" optionValue="${optionValue}" valueMessagePrefix="${valueMessagePrefix}"></g:select>
										</td>
								<% 
			                   	                } else {
			                   	                	// transient, no filter
			                   	        %>
			                   	        <td>&nbsp;
			                   	        </td>
			                   	        	 <%
			                   	                }
			                   	            } // < display !pwd
										}
			%></tr>
							
							<% //HK filterable column features END %>
		                  
		                  <% //output data rows %>
		                  	<g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
		                      		<tr class="\${(i % 2) == 0 ? 'odd' : 'even'}">
		                      <%  firstColumnDone = false
		                     		props.eachWithIndex { p,i ->
		
		                     		cp = domainClass.constrainedProperties[p.name]
							display = (cp ? cp.display : true)   
		                          pwd = (cp ? cp.password : false)
		                          listable = (cp?.attributes?.listable != null ? cp.attributes.listable : true)
							manyInList = cp?.attributes?.manyInList
							cssStyle = (cp?.attributes ? cp.attributes.cssStyle : "")
		
							if ((cssStyle == null) || (cssStyle == "")) {
								cssStyle = ""
							} else {
								cssStyle = " style=\"" + cssStyle + "\"" 
							}
		                             
		                          url = false
		                  	    if(p.type == java.lang.String) {
		                  	    	url = (cp ? cp.hasAppliedConstraint( "url" ) : false)
		                  	    }
		
		                          if(display && listable && !pwd && (!Collection.isAssignableFrom(p.type) || manyInList)) { 
		
								//HK add one column with icons to show/edit/delete
		                        if(!firstColumnDone) { 
		                        	firstColumnDone = true %>
				                    <td>
				   						<g:if test="\${params.callback}"> 
				   							<g:link action="choose" params="\${params}" id="\${${propertyName}.compositeId}"><img src='<g:resource dir="images/skin" file="database_add.png"/>' alt="Associate"/></g:link>
										</g:if>  
										<g:if test="\${params?.callback==null}"> 
											<g:link action="show"   id="\${${propertyName}.compositeId}"><img src='<g:resource dir="images/skin" file="information.png"/>' alt="Show"/></g:link>
											<g:link action="edit"   id="\${${propertyName}.compositeId}"><img src='<g:resource dir="images/skin" file="database_edit.png"/>' alt="Edit"/></g:link>
											<g:link action="delete" id="\${${propertyName}.compositeId}" onclick="return confirm('\${message(code:'default.button.delete.confirm.message', default:'Are you sure?', encodeAs:'HTML')}');"><img src='<g:resource dir="images/skin" file="database_delete.png"/>' alt="Delete"/></g:link>
				                    	</g:if>  	
				                    </td>
					            <%      
								} 
								if(p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) {
							    	dateFormatName = (cp?.attributes ? cp.attributes.dateFormatName : null)
							    	if (dateFormatName != null) {
							    		formatString = "formatName=\"" + dateFormatName + "\""
							    	} else {
							    		dateFormat = (cp?.attributes ? cp.attributes.dateFormat : null)
							    		if (dateFormat != null) {
							    			formatString = "format=\"" + dateFormat + "\""
							    		} else {
							    			if (p.type == java.sql.Time.class) { 
							    				formatString = "format=\"HH:mm:SS\""
							    			} else {
												formatString = "format=\"dd.MM.yyyy\""
											}
							    		}
							    	}
		                     				%> 
									<td${cssStyle} class="date"><g:formatDate date="\${${propertyName}.${p.name}}" ${formatString}/>&nbsp;</td>
											 <% } else if (p.type == boolean.class || p.type == Boolean.class) { %>
									<td${cssStyle} class="checkbox"><g:checkBox class="checkbox" name="${p.name}\${${propertyName}.compositeId}" disabled="true" checked="\${fieldValue(bean:${propertyName}, field:'${p.name}').toString()}" value="\${fieldValue(bean:${propertyName}, field:'${p.name}')}"></g:checkBox></td>
											 <% } else if (url) { %>
									<td${cssStyle} class="url"><g:if test="\${fieldValue(bean:${propertyName}, field:'${p.name}')}"><a target="_blank" href="\${fieldValue(bean:${propertyName}, field:'${p.name}')}">\${fieldValue(bean:${propertyName}, field:"${p.name}")}</a></g:if>&nbsp;</td>
											 <% } else if (p.isEnum()) { %>
									<td${cssStyle} class="value"><g:message code="${propertyName}.${p.name}.\${fieldValue(bean:${propertyName}, field:'${p.name}')}" default="\${fieldValue(bean:${propertyName}, field:'${p.name}').toString()}" /></td>
											 <% } else if (p.isAssociation() && !p.isEnum() && !Collection.isAssignableFrom(p.type)) { // show (1,n):1 linked %>
									<td${cssStyle} class="value"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.compositeId}">\${fieldValue(bean:${propertyName}, field:"${p.name}")}</g:link>&nbsp;</td>
											 <% } else if (p.isAssociation() && Collection.isAssignableFrom(p.type) && manyInList) { // show 1:(1,n) many elements %>
									<td${cssStyle} class="value">
										<g:if test="\${${propertyName}.${p.name}?.size()>0}">
										<% // manyInList is always available here
											if (!manyInList.maxSize) {
												manyInList.maxSize = 10
											} 
											if (manyInList.ulli) { %><ul><% } %>
			                                <g:each in="\${${propertyName}.${p.name}.sort()}" var="${p.name[0]}" status="index">
			                                	<g:if test="\${index < ${manyInList.maxSize}}">
			                                	<% if (manyInList.ulli) { %><li><% } %>
			                                    	<% if (manyInList.linked) { %><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.compositeId}">\${${p.name[0]}?.encodeAsHTML()}</g:link><% } else { %>\${${p.name[0]}?.encodeAsHTML()}<% } %><% if (!manyInList.ulli) { %><g:if test="\${(${propertyName}.${p.name}?.size()-1)!=index && index<${manyInList.maxSize-1}}">,</g:if><% } %>
			                                    <% if (manyInList.ulli) { %></li><% } %>
			                                    </g:if>
			                                </g:each>
			                                <% if (manyInList.ulli) { %><g:if test="\${${propertyName}.${p.name}?.size()>${manyInList.maxSize}}"><li>...</li></g:if><% } %>
			                                <% if (!manyInList.ulli) { %><g:if test="\${${propertyName}.${p.name}?.size()>${manyInList.maxSize}}">, ...</g:if><% } %>
			                                <% if (manyInList.ulli) { %></ul><% } %>
		                                </g:if>
		                                <g:else>&nbsp;</g:else>
									</td>
											 <% } else if (p.type == int || p.type == long || p.type == double || p.type == float || p.type == Integer.class || p.type == Long.class || p.type == Double.class || p.type == Float.class || BigDecimal.class.isAssignableFrom(p.type)) {
										    	numberFormatName = (cp?.attributes ? cp.attributes.numberFormatName : null)
										    	if (numberFormatName != null) {
										    		formatString = "formatName=\"" + numberFormatName + "\""
										    	} else {
										    		numberFormat = (cp?.attributes ? cp.attributes.numberFormat : null)
										    		if (numberFormat != null) {
										    			formatString = "format=\"" + numberFormat + "\""
										    		} else {
										    			if (p.type == int || p.type == long || p.type == Integer.class || p.type == Long.class) { 
										    				formatString = "format=\"###,##0\""
										    			} else {
															formatString = "format=\"###,##0.00\""
														}
										    		}
										    	}
											 %>
									<td${cssStyle} class="number"><g:formatNumber number="\${${propertyName}.${p.name}}" ${formatString}/>&nbsp;</td>
			                        		<% } else { %>
			                        <td${cssStyle} class="value">\${fieldValue(bean:${propertyName}, field:"${p.name}")}&nbsp;</td>
			                        		<% }   
		                        		} 
		                               }
		                %>
		                     	</tr>
		                </g:each>
		                		<tr>
		                			<td class="paginateButtons" colspan="100%">
							            <div class="">
											<g:paginate max="20" params="\${params.findAll{ k,v -> k != 'filter' && k!= 'offset'}}" total="\${paginateTotal}" />
		           						</div>
		           					</td>
		           				</tr>
		                    </tbody>
		                </table>
		            </div>
					</g:else>
        		</fieldset>
			</g:form>
        </div>
    </body>
</html>
