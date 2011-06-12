
<%@ page import="fleetmanagement.Driver" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'driver.label', default: 'Driver')}" />
        <title><g:message code="default.show.label" args='[entityName, "${driverInstance}"]' default="Show Driver - ${' ' + driverInstance}" encodeAs="HTML" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args='[entityName, "${driverInstance}"]' default="Show Driver - ${' ' + driverInstance}" encodeAs="HTML" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" encodeAs="HTML"/></div>
            </g:if>
            <g:form>
            	<fieldset>
                <g:hiddenField name="id" value="${driverInstance?.compositeId}" />
            
	            <div class="dialog">
	                <table>
	                    <tbody>
	                    
	                        <tr class="prop" title="${message(code:'driver.firstName.hint' , default: 'First Name', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="driver.firstName.label" default="First Name" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:driverInstance, field:"firstName")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'driver.surname.hint' , default: 'Surname', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="driver.surname.label" default="Surname" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:driverInstance, field:"surname")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'driver.branch.hint' , default: 'Branch', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="driver.branch.label" default="Branch" encodeAs="HTML" /></td>
	                            
	                            <td class="value"><g:link controller="branch" action="show" id="${driverInstance?.branch?.compositeId}">${driverInstance?.branch?.encodeAsHTML()}</g:link>&nbsp;</td>
	                            
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'driver.cellPhoneNumber.hint' , default: 'Cell Phone Number', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="driver.cellPhoneNumber.label" default="Cell Phone Number" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:driverInstance, field:"cellPhoneNumber")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'driver.licenseExpiryDate.hint' , default: 'License Expiry Date', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="driver.licenseExpiryDate.label" default="License Expiry Date" encodeAs="HTML" /></td>
	                             
								<td class="date"><g:formatDate date="${driverInstance.licenseExpiryDate}" format="dd.MM.yyyy"/>&nbsp;</td>
									
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'driver.ptcExpiryDate.hint' , default: 'Ptc Expiry Date', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="driver.ptcExpiryDate.label" default="Ptc Expiry Date" encodeAs="HTML" /></td>
	                             
								<td class="date"><g:formatDate date="${driverInstance.ptcExpiryDate}" format="dd.MM.yyyy"/>&nbsp;</td>
									
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'driver.licenseCopy.hint' , default: 'License Copy', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="driver.licenseCopy.label" default="License Copy" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:driverInstance, field:"licenseCopy")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'driver.ptcCopy.hint' , default: 'Ptc Copy', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="driver.ptcCopy.label" default="Ptc Copy" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:driverInstance, field:"ptcCopy")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'driver.employeeCode.hint' , default: 'Employee Code', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="driver.employeeCode.label" default="Employee Code" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:driverInstance, field:"employeeCode")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'driver.idNumber.hint' , default: 'Id Number', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="driver.idNumber.label" default="Id Number" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:driverInstance, field:"idNumber")}&nbsp;</td>
	                        		
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
