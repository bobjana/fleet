

<%@ page import="fleetmanagement.Supervisor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supervisor.label', default: 'Supervisor')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${supervisorInstance}">
            <div class="errors">
                <g:renderErrors bean="${supervisorInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${supervisorInstance?.id}" />
                <g:hiddenField name="version" value="${supervisorInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="firstName"><g:message code="supervisor.firstName.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" maxlength="50" value="${supervisorInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="surname"><g:message code="supervisor.surname.label" default="Surname" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'surname', 'errors')}">
                                    <g:textField name="surname" maxlength="50" value="${supervisorInstance?.surname}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="branch"><g:message code="supervisor.branch.label" default="Branch" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'branch', 'errors')}">
                                    <g:select name="branch.id" from="${fleetmanagement.Branch.list()}" optionKey="id" value="${supervisorInstance?.branch?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cellPhoneNumber"><g:message code="supervisor.cellPhoneNumber.label" default="Cell Phone Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'cellPhoneNumber', 'errors')}">
                                    <g:textField name="cellPhoneNumber" value="${supervisorInstance?.cellPhoneNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="supervisor.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${fleetmanagement.User.list()}" optionKey="id" value="${supervisorInstance?.user?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="email"><g:message code="supervisor.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${supervisorInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fullName"><g:message code="supervisor.fullName.label" default="Full Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'fullName', 'errors')}">
                                    <g:textField name="fullName" value="${supervisorInstance?.fullName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="idNumber"><g:message code="supervisor.idNumber.label" default="Id Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'idNumber', 'errors')}">
                                    <g:textField name="idNumber" value="${supervisorInstance?.idNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="vehicles"><g:message code="supervisor.vehicles.label" default="Vehicles" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'vehicles', 'errors')}">
                                    <g:select name="vehicles" from="${fleetmanagement.Vehicle.list()}" multiple="yes" optionKey="id" size="5" value="${supervisorInstance?.vehicles*.id}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
