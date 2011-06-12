
<%@ page import="fleetmanagement.ServiceSchedule" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'serviceSchedule.label', default: 'ServiceSchedule')}" />
        <title><g:message code="default.show.label" args='[entityName, "${serviceScheduleInstance}"]' default="Show ServiceSchedule - ${' ' + serviceScheduleInstance}" encodeAs="HTML" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args='[entityName, "${serviceScheduleInstance}"]' default="Show ServiceSchedule - ${' ' + serviceScheduleInstance}" encodeAs="HTML" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" encodeAs="HTML"/></div>
            </g:if>
            <g:form>
            	<fieldset>
                <g:hiddenField name="id" value="${serviceScheduleInstance?.compositeId}" />
            
	            <div class="dialog">
	                <table>
	                    <tbody>
	                    
	                        <tr class="prop" title="${message(code:'serviceSchedule.nextService.hint' , default: 'Next Service', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="serviceSchedule.nextService.label" default="Next Service" encodeAs="HTML" /></td>
	                             
								<td class="date"><g:formatDate date="${serviceScheduleInstance.nextService}" format="dd.MM.yyyy"/>&nbsp;</td>
									
	                        </tr>
		                    
	                        <tr class="prop" title="${message(code:'serviceSchedule.serviceInterval.hint' , default: 'Service Interval', encodeAs:'HTML')}">
	                            <td class="name"><g:message code="serviceSchedule.serviceInterval.label" default="Service Interval" encodeAs="HTML" /></td>
	                            
								<td class="number"><g:formatNumber number="${serviceScheduleInstance.serviceInterval}" format="###,##0"/>&nbsp;</td>
	                        		
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
