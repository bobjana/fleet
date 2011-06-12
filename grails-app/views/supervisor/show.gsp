
<%@ page import="fleetmanagement.Supervisor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supervisor.label', default: 'Supervisor')}" />
        <title><g:message code="default.show.label" args='[entityName, "${supervisorInstance}"]' default="Show Supervisor - ${' ' + supervisorInstance}" encodeAs="HTML" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args='[entityName, "${supervisorInstance}"]' default="Show Supervisor - ${' ' + supervisorInstance}" encodeAs="HTML" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" encodeAs="HTML"/></div>
            </g:if>
            <g:form>
            	<fieldset>
                <g:hiddenField name="id" value="${supervisorInstance?.compositeId}" />
            
	            <div class="dialog">
	                <table>
	                    <tbody>
	                    
	                        <tr class="prop" title="${message(code:'supervisor.firstName.hint' , default: 'First Name', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="supervisor.firstName.label" default="First Name" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:supervisorInstance, field:"firstName")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'supervisor.surname.hint' , default: 'Surname', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="supervisor.surname.label" default="Surname" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:supervisorInstance, field:"surname")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'supervisor.branch.hint' , default: 'Branch', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="supervisor.branch.label" default="Branch" encodeAs="HTML" /></td>
	                            
	                            <td class="value"><g:link controller="branch" action="show" id="${supervisorInstance?.branch?.compositeId}">${supervisorInstance?.branch?.encodeAsHTML()}</g:link>&nbsp;</td>
	                            
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'supervisor.cellPhoneNumber.hint' , default: 'Cell Phone Number', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="supervisor.cellPhoneNumber.label" default="Cell Phone Number" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:supervisorInstance, field:"cellPhoneNumber")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'supervisor.email.hint' , default: 'Email', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="supervisor.email.label" default="Email" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:supervisorInstance, field:"email")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'supervisor.employeeCode.hint' , default: 'Employee Code', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="supervisor.employeeCode.label" default="Employee Code" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:supervisorInstance, field:"employeeCode")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'supervisor.idNumber.hint' , default: 'Id Number', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="supervisor.idNumber.label" default="Id Number" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:supervisorInstance, field:"idNumber")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'supervisor.vehicles.hint' , default: 'Vehicles', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="supervisor.vehicles.label" default="Vehicles" encodeAs="HTML" /></td>
	                            
	                            <td class="value">
	                            	<g:if test="${supervisorInstance.vehicles?.size()>0}">
	                                <ul>
	                                <g:each in="${supervisorInstance.vehicles.sort()}" var="v">
	                                    <li><g:link controller="vehicle" action="show" id="${v.compositeId}">${v?.encodeAsHTML()}</g:link></li>
	
											
	                                </g:each>
	                                </ul>
	                                </g:if>
	                            &nbsp;</td>
	                            
	                        </tr>
		                    
		               	</tbody>
	                </table>
		            <div class="buttons">
	                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit', encodeAs:'HTML')}" /></span>
	                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete', encodeAs:'HTML')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?', encodeAs:'HTML')}');" /></span>
		            </div>
	            </div>
	        	</fieldset>
			</g:form>
        </div>
    </body>
</html>
