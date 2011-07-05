
<%@ page import="fleetmanagement.Vehicle" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'vehicle.label', default: 'Vehicle')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                                 <th class="listControls">&nbsp;</th>
                                
                            <g:sortableColumn property="registrationNumber" title="${message(code: 'vehicle.registrationNumber.label', default: 'Registration Number')}" />
                        
                            <g:sortableColumn property="make" title="${message(code: 'vehicle.make.label', default: 'Make')}" />
                        
                            <g:sortableColumn property="model" title="${message(code: 'vehicle.model.label', default: 'Model')}" />
                        
                            <g:sortableColumn property="year" title="${message(code: 'vehicle.year.label', default: 'Year')}" />
                        
                            <th><g:message code="vehicle.branch.label" default="Branch" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${vehicleInstanceList}" status="i" var="vehicleInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td class="listControls">
                                    <g:link action="show" id="${vehicleInstance.id}"><img src='<g:resource dir="images/skin" file="information.png"/>' alt="Show"/></g:link>
                                    <g:link action="edit"   id="${vehicleInstance.id}"><img src='<g:resource dir="images/skin" file="database_edit.png"/>' alt="Edit"/></g:link>
                                    <g:link action="delete" id="${vehicleInstance.id}" onclick="return confirm('${message(code:'default.button.delete.confirm.message', default:'Are you sure?', encodeAs:'HTML')}');"><img src='<g:resource dir="images/skin" file="database_delete.png"/>' alt="Delete"/></g:link>
                            </td>
                        
                            <td>${fieldValue(bean: vehicleInstance, field: "registrationNumber")}</td>
                        
                            <td>${fieldValue(bean: vehicleInstance, field: "make")}</td>
                        
                            <td>${fieldValue(bean: vehicleInstance, field: "model")}</td>
                        
                            <td>${fieldValue(bean: vehicleInstance, field: "year")}</td>
                        
                            <td>${fieldValue(bean: vehicleInstance, field: "branch")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${vehicleInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
