
<%@ page import="fleetmanagement.Vehicle" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'vehicle.label', default: 'Vehicle')}" />
        <title><g:message code="default.show.label" args='[entityName, "${vehicleInstance}"]' default="Show Vehicle - ${' ' + vehicleInstance}" encodeAs="HTML" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args='[entityName, "${vehicleInstance}"]' default="Show Vehicle - ${' ' + vehicleInstance}" encodeAs="HTML" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" encodeAs="HTML"/></div>
            </g:if>

            <g:if test="${vehicleInstance?.reminders}">
                <g:each in="${vehicleInstance?.reminders}" status="i" var="reminderInstance">
                    <div class="message">
                        <g:message code="${reminderInstance.code}" default="${reminderInstance.message}"
                                encodeAs="HTML"/>
                    </div>
                </g:each>

            </g:if>


            <g:form>
            	<fieldset>
                <g:hiddenField name="id" value="${vehicleInstance?.compositeId}" />
            
	            <div class="dialog">
	                <table>
	                    <tbody>
	                    
	                        <tr class="prop" title="${message(code:'vehicle.registrationNumber.hint' , default: 'Registration Number', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="vehicle.registrationNumber.label" default="Registration Number" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:vehicleInstance, field:"registrationNumber")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'vehicle.make.hint' , default: 'Make', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="vehicle.make.label" default="Make" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:vehicleInstance, field:"make")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'vehicle.model.hint' , default: 'Model', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="vehicle.model.label" default="Model" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:vehicleInstance, field:"model")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'vehicle.year.hint' , default: 'Year', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="vehicle.year.label" default="Year" encodeAs="HTML" /></td>
	                            
	                        	<td class="value">${fieldValue(bean:vehicleInstance, field:"year")}&nbsp;</td>
	                        		
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'vehicle.branch.hint' , default: 'Branch', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="vehicle.branch.label" default="Branch" encodeAs="HTML" /></td>
	                            
	                            <td class="value"><g:link controller="branch" action="show" id="${vehicleInstance?.branch?.compositeId}">${vehicleInstance?.branch?.encodeAsHTML()}</g:link>&nbsp;</td>
	                            
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'vehicle.serviceSchedule.hint' , default: 'Service Schedule', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="vehicle.serviceSchedule.label" default="Service Schedule" encodeAs="HTML" /></td>
	                        	<td class="value">${fieldValue(bean:vehicleInstance, field:"serviceSchedule")}&nbsp;</td>
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'vehicle.driver.hint' , default: 'Driver', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="vehicle.driver.label" default="Driver" encodeAs="HTML" /></td>
	                            
	                            <td class="value"><g:link controller="driver" action="show" id="${vehicleInstance?.driver?.compositeId}">${vehicleInstance?.driver?.encodeAsHTML()}</g:link>&nbsp;</td>
	                            
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'vehicle.licenseExpiryDate.hint' , default: 'License Expiry Date', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="vehicle.licenseExpiryDate.label" default="License Expiry Date" encodeAs="HTML" /></td>
	                             
								<td class="date"><g:formatDate date="${vehicleInstance.licenseExpiryDate}" format="dd.MM.yyyy"/>&nbsp;</td>
									
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'vehicle.tracking.hint' , default: 'Tracking', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="vehicle.tracking.label" default="Tracking" encodeAs="HTML" /></td>
	                            
								<td class="checkbox"><g:checkBox class="checkbox" name="tracking" disabled="true" checked="${fieldValue(bean:vehicleInstance, field:'tracking').toString()}" value="${fieldValue(bean:vehicleInstance, field:'tracking')}"></g:checkBox>&nbsp;</td>
									
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'vehicle.vinNumber.hint' , default: 'Vin Number', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="vehicle.vinNumber.label" default="Vin Number" encodeAs="HTML" /></td>
	                        	<td class="value">${fieldValue(bean:vehicleInstance, field:"vinNumber")}&nbsp;</td>
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
