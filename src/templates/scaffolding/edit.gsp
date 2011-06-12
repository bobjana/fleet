<% import grails.persistence.Event %>
<% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
        <title><g:message code="default.edit.label" args='[entityName, "\${${propertyName}}"]' default="Edit ${className} - \${' ' + ${propertyName}}" encodeAs="HTML" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args='[entityName, "\${${propertyName}}"]' default="Edit ${className} - \${' ' + ${propertyName}}" encodeAs="HTML"/></h1>
            <g:if test="\${flash.message}">
            <div class="message"><g:message code="\${flash.message}" args="\${flash.args}" default="\${flash.defaultMessage}" encodeAs="HTML"/></div>
            </g:if>
            <g:hasErrors bean="\${${propertyName}}">
            <div class="errors">
                <g:renderErrors bean="\${${propertyName}}" as="list" />
            </div>
            </g:hasErrors>
            <g:form controller="${domainClass.propertyName}" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
                <fieldset>
                <g:hiddenField name="id" value="\${${propertyName}?.compositeId}" />
                <g:hiddenField name="version" value="\${${propertyName}?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        <%  excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
                            persistentPropNames = domainClass.persistentProperties*.name
                            props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            display = true
                            boolean hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate')
                            props.each { p ->
                                if (hasHibernate) {
                                    cp = domainClass.constrainedProperties[p.name]
                                    display = (cp?.display ?: true)
                                    isRadio = (cp ? cp.attributes.isRadio : false)
                                }
                                if(display) { %>
                            <tr class="prop" title="\${message(code:'${domainClass.propertyName}.${p.name}.hint' , default: '${p.naturalName}', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<% if(!Collection.class.isAssignableFrom(p.type) && !isRadio && !(p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class)) { // not for radios, dates and 1:n/m:n properties %><label for="${p.name}"><% } %>
									<g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" encodeAs="HTML" />
                                	<% if(!Collection.class.isAssignableFrom(p.type) && !isRadio && !(p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class)) { // not for radios, dates and 1:n/m:n properties %></label><% } %>
                                </td>
                                <td valign="top" class="value \${hasErrors(bean: ${propertyName}, field: '${p.name}', 'errors')}">
                                    ${renderEditor(p)}
                                </td>
                            </tr>
                        <%  }   } %>
                        </tbody>
                    </table>
	                <div class="buttons">
	                    <span class="button"><g:actionSubmit class="save" action="update" value="\${message(code: 'default.button.update.label', default: 'Update', encodeAs:'HTML')}" /></span>
	                    <span class="button"><g:actionSubmit class="delete" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete', encodeAs:'HTML')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?', encodeAs:'HTML')}');" /></span>
	                </div>
                </div>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
