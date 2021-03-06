

<%@ page import="fleetmanagement.ServiceSchedule" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'serviceSchedule.label', default: 'ServiceSchedule')}" />
        <title><g:message code="default.create.label" args="[entityName]" encodeAs="HTML"/></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" encodeAs="HTML" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" encodeAs="HTML"/></div>
            </g:if>
            <g:hasErrors bean="${serviceScheduleInstance}">
            <div class="errors">
                <g:renderErrors bean="${serviceScheduleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form controller="serviceSchedule" action="save" >
            	<fieldset>
				
				<!-- do not forget source for adding to other objects -->
				<g:if test="${params.source}">
					<g:hiddenField name="source" value="${params.source}" />
				</g:if>
				<g:if test="${params.source_id}">
					<g:hiddenField name="source_id" value="${params.source_id}" />
				</g:if>
				<g:if test="${params.class}">
					<g:hiddenField name="class" value="${params.class}" />
				</g:if>
				<g:if test="${params.dest}">
					<g:hiddenField name="dest" value="${params.dest}" />
				</g:if>
				<g:if test="${params.refDest}">
					<g:hiddenField name="refDest" value="${params.refDest}" />
				</g:if>
            
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop" title="${message(code:'serviceSchedule.nextService.hint' , default: 'Next Service', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	
									<g:message code="serviceSchedule.nextService.label" default="Next Service" encodeAs="HTML" />
                                	
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: serviceScheduleInstance, field: 'nextService', 'errors')}">
                                    <g:datePicker name="nextService" precision="day" value="${serviceScheduleInstance?.nextService}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'serviceSchedule.serviceInterval.hint' , default: 'Service Interval', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="serviceInterval">
									<g:message code="serviceSchedule.serviceInterval.label" default="Service Interval" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: serviceScheduleInstance, field: 'serviceInterval', 'errors')}">
                                    <g:textField  name="serviceInterval" value="${fieldValue(bean: serviceScheduleInstance, field: 'serviceInterval')}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
	                <div class="buttons">
	                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create', encodeAs:'HTML')}" /></span>
	                </div>
                </div>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
