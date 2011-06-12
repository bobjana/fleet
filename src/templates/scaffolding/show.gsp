<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.show.label" args='[entityName, "\${${propertyName}}"]' default="Show ${className} - \${' ' + ${propertyName}}" encodeAs="HTML" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args='[entityName, "\${${propertyName}}"]' default="Show ${className} - \${' ' + ${propertyName}}" encodeAs="HTML" /></h1>
            <g:if test="\${flash.message}">
            <div class="message"><g:message code="\${flash.message}" args="\${flash.args}" default="\${flash.defaultMessage}" encodeAs="HTML"/></div>
            </g:if>
            <g:form>
            	<fieldset>
                <g:hiddenField name="id" value="\${${propertyName}?.compositeId}" />
            
	            <div class="dialog">
	                <table>
	                    <tbody>
	                    <%  excludedProps = Event.allEvents.toList() << 'version'
	                        allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
	                        props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
	                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
	                        props.each { p -> 
	                        
								cp = domainClass.constrainedProperties[p.name]
								display = (cp ? cp.display : true)
								pwd = (cp ? cp.password : false)
	
								url = false
								if(p.type == java.lang.String) {
									url = (cp ? cp.hasAppliedConstraint( "url" ) : false)
								}
								if(display && !pwd) {
	                        %>
	                        <tr class="prop" title="\${message(code:'${domainClass.propertyName}.${p.name}.hint' , default: '${p.naturalName}', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" encodeAs="HTML" /></td>
	                            <%  if (p.isEnum()) { %>
	                            <td class="value"><g:message code="${domainClass.propertyName}.${p.name}.\${fieldValue(bean:${propertyName}, field:'${p.name}')}" default="\${fieldValue(bean:${propertyName}, field:'${p.name}').toString()}"/></td>
	                            <%  } else if (p.oneToMany || p.manyToMany) { %>
	                            <td class="value">
	                            	<g:if test="\${${propertyName}.${p.name}?.size()>0}">
	                                <ul>
	                                <g:each in="\${${propertyName}.${p.name}.sort()}" var="${p.name[0]}">
	                                    <li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.compositeId}">\${${p.name[0]}?.encodeAsHTML()}</g:link></li>
	
											<%  subElement = (cp ? cp.attributes.subElement : null)
	                                    	if (subElement != null) {
	
	                                    		subProps = p.referencedDomainClass?.properties.findAll{!excludedProps.contains(it.name)}.sort()
	                                    		subProps.each { sp -> 
	                                    			if (sp.name.equals(subElement)) {
	                                    				controllerName = sp.referencedDomainClass?.propertyName
	                                    			}
	                                    		}
	
	                                    		%>
	                                    		<ul>
	                                    		<g:each var="${subElement}Sub" in="\${${p.name[0]}.${subElement}.sort()}">
	                                    			<li><g:link controller="${controllerName}" action="show" id="\${${subElement}Sub.compositeId}">\${${subElement}Sub.encodeAsHTML()}</g:link></li>
	                                    		</g:each>
	                                    		</ul>
	                                    		<br>
	                                    		<%
	                                    	} %>
	                                </g:each>
	                                </ul>
	                                </g:if>
	                            &nbsp;</td>
	                            <%  } else if (p.manyToOne || p.oneToOne) { %>
	                            <td class="value"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.compositeId}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link>&nbsp;</td>
	                            <%  } else  { 
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
								<td class="date"><g:formatDate date="\${${propertyName}.${p.name}}" ${formatString}/>&nbsp;</td>
									<% } else if (p.type == boolean.class || p.type == Boolean.class) { %>
								<td class="checkbox"><g:checkBox class="checkbox" name="${p.name}" disabled="true" checked="\${fieldValue(bean:${propertyName}, field:'${p.name}').toString()}" value="\${fieldValue(bean:${propertyName}, field:'${p.name}')}"></g:checkBox>&nbsp;</td>
									<% } else if (url) { %>
								<td class="value"><a target="_blank" href="\${fieldValue(bean:${propertyName}, field:'${p.name}')}">\${fieldValue(bean:${propertyName}, field:"${p.name}")}</a>&nbsp;</td>
								 <% } else if (p.type == int || p.type == long || p.type == double || p.type == float || p.type == Integer.class || p.type == Long.class || p.type == Double.class || p.type == Float.class || BigDecimal.class.isAssignableFrom(p.type)) { 
							    	numberFormatName = (cp ? cp.attributes.numberFormatName : null)
							    	if (numberFormatName != null) {
							    		formatString = "formatName=\"" + numberFormatName + "\""
							    	} else {
							    		numberFormat = (cp ? cp.attributes.numberFormat : null)
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
								<td class="number"><g:formatNumber number="\${${propertyName}.${p.name}}" ${formatString}/>&nbsp;</td>
	                        		<% } else { %>
	                        	<td class="value">\${fieldValue(bean:${propertyName}, field:"${p.name}")}&nbsp;</td>
	                        		<% }   
	                            
	                                } %>
	                        </tr>
		                    <%  	} 
		                        } %>
		               	</tbody>
	                </table>
		            <div class="buttons">
	                    <span class="button"><g:actionSubmit class="edit" action="edit" value="\${message(code: 'default.button.edit.label', default: 'Edit', encodeAs:'HTML')}" /></span>
	                    <span class="button"><g:actionSubmit class="delete" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete', encodeAs:'HTML')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?', encodeAs:'HTML')}');" /></span>
		            </div>
	            </div>
	        	</fieldset>
			</g:form>
        </div>
    </body>
</html>
