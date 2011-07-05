
<%@ page import="fleetmanagement.Supervisor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supervisor.label', default: 'Supervisor')}" />
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
                                
                            <g:sortableColumn property="firstName" title="${message(code: 'supervisor.firstName.label', default: 'First Name')}" />
                        
                            <g:sortableColumn property="surname" title="${message(code: 'supervisor.surname.label', default: 'Surname')}" />
                        
                            <th><g:message code="supervisor.branch.label" default="Branch" /></th>
                        
                            <g:sortableColumn property="cellPhoneNumber" title="${message(code: 'supervisor.cellPhoneNumber.label', default: 'Cell Phone Number')}" />
                        
                            <th><g:message code="supervisor.user.label" default="User" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${supervisorInstanceList}" status="i" var="supervisorInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td class="listControls">
                                    <g:link action="show" id="${supervisorInstance.id}"><img src='<g:resource dir="images/skin" file="information.png"/>' alt="Show"/></g:link>
                                    <g:link action="edit"   id="${supervisorInstance.id}"><img src='<g:resource dir="images/skin" file="database_edit.png"/>' alt="Edit"/></g:link>
                                    <g:link action="delete" id="${supervisorInstance.id}" onclick="return confirm('${message(code:'default.button.delete.confirm.message', default:'Are you sure?', encodeAs:'HTML')}');"><img src='<g:resource dir="images/skin" file="database_delete.png"/>' alt="Delete"/></g:link>
                            </td>
                        
                            <td>${fieldValue(bean: supervisorInstance, field: "firstName")}</td>
                        
                            <td>${fieldValue(bean: supervisorInstance, field: "surname")}</td>
                        
                            <td>${fieldValue(bean: supervisorInstance, field: "branch")}</td>
                        
                            <td>${fieldValue(bean: supervisorInstance, field: "cellPhoneNumber")}</td>
                        
                            <td>${fieldValue(bean: supervisorInstance, field: "user")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${supervisorInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
