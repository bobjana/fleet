<%@ page import="fleetmanagement.Vehicle" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'vehicle.label', default: 'Vehicle')}"/>
    <title><g:message code="default.edit.label" args='[entityName, "${vehicleInstance}"]' default="Edit Vehicle - ${' ' + vehicleInstance}" encodeAs="HTML"/></title>
</head>
<body>
<div class="nav">
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" encodeAs="HTML"/></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" encodeAs="HTML"/></g:link></span>
</div>
<div class="body">
    <h1><g:message code="default.edit.label" args='[entityName, "${vehicleInstance}"]' default="Edit Vehicle - ${' ' + vehicleInstance}" encodeAs="HTML"/></h1>
    <g:if test="${flash.message}">
        <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" encodeAs="HTML"/></div>
    </g:if>
    <g:hasErrors bean="${vehicleInstance}">
        <div class="errors">
            <g:renderErrors bean="${vehicleInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form controller="vehicle">
        <fieldset>
            <g:hiddenField name="id" value="${vehicleInstance?.compositeId}"/>
            <g:hiddenField name="version" value="${vehicleInstance?.version}"/>
            <div class="dialog">
                <table>
                    <tbody>

                    <tr class="prop" title="${message(code: 'vehicle.registrationNumber.hint', default: 'Registration Number', encodeAs: 'HTML')}">
                        <td valign="top" class="name">
                            <label for="registrationNumber">
                                <g:message code="vehicle.registrationNumber.label" default="Registration Number" encodeAs="HTML"/>
                            </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'registrationNumber', 'errors')}">
                            <g:textField name="registrationNumber" value="${vehicleInstance?.registrationNumber}"/>
                        </td>
                    </tr>

                    <tr class="prop" title="${message(code: 'vehicle.make.hint', default: 'Make', encodeAs: 'HTML')}">
                        <td valign="top" class="name">
                            <label for="make">
                                <g:message code="vehicle.make.label" default="Make" encodeAs="HTML"/>
                            </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'make', 'errors')}">
                            <g:textField name="make" maxlength="50" value="${vehicleInstance?.make}"/>
                        </td>
                    </tr>

                    <tr class="prop" title="${message(code: 'vehicle.model.hint', default: 'Model', encodeAs: 'HTML')}">
                        <td valign="top" class="name">
                            <label for="model">
                                <g:message code="vehicle.model.label" default="Model" encodeAs="HTML"/>
                            </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'model', 'errors')}">
                            <g:textField name="model" maxlength="50" value="${vehicleInstance?.model}"/>
                        </td>
                    </tr>

                    <tr class="prop" title="${message(code: 'vehicle.year.hint', default: 'Year', encodeAs: 'HTML')}">
                        <td valign="top" class="name">
                            <label for="year">
                                <g:message code="vehicle.year.label" default="Year" encodeAs="HTML"/>
                            </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'year', 'errors')}">
                            <g:textField name="year" maxlength="5" value="${vehicleInstance?.year}"/>
                        </td>
                    </tr>

                    <tr class="prop" title="${message(code: 'vehicle.branch.hint', default: 'Branch', encodeAs: 'HTML')}">
                        <td valign="top" class="name">
                            <label for="branch">
                                <g:message code="vehicle.branch.label" default="Branch" encodeAs="HTML"/>
                            </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'branch', 'errors')}">
                            <g:select id="branch" name="branch.id" from="${fleetmanagement.Branch.list().sort()}" optionKey="id" value="${vehicleInstance?.branch?.compositeId}" noSelection="['null': message(code:'default.choose.required', default:'Select one')]"/>
                        </td>
                    </tr>

                    <tr class="prop" title="${message(code: 'vehicle.driver.hint', default: 'Driver', encodeAs: 'HTML')}">
                        <td valign="top" class="name">
                            <label for="driver">
                                <g:message code="vehicle.driver.label" default="Driver" encodeAs="HTML"/>
                            </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'driver', 'errors')}">
                            <g:select id="driver" name="driver.id" from="${fleetmanagement.Driver.list().sort()}" optionKey="id" value="${vehicleInstance?.driver?.compositeId}" noSelection="['null': message(code:'default.choose.required', default:'Select one')]"/>
                        </td>
                    </tr>

                    <tr class="prop" title="${message(code: 'vehicle.licenseExpiryDate.hint', default: 'License Expiry Date', encodeAs: 'HTML')}">
                        <td valign="top" class="name">

                            <g:message code="vehicle.licenseExpiryDate.label" default="License Expiry Date" encodeAs="HTML"/>

                        </td>
                        <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'licenseExpiryDate', 'errors')}">
                            <g:datePicker name="licenseExpiryDate" precision="day" value="${vehicleInstance?.licenseExpiryDate}"/>
                        </td>
                    </tr>

                    <tr class="prop" title="${message(code: 'vehicle.tracking.hint', default: 'Tracking', encodeAs: 'HTML')}">
                        <td valign="top" class="name">
                            <label for="tracking">
                                <g:message code="vehicle.tracking.label" default="Tracking" encodeAs="HTML"/>
                            </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'tracking', 'errors')}">
                            <g:checkBox name="tracking" value="${vehicleInstance?.tracking}"/>
                        </td>
                    </tr>

                    <tr class="prop" title="${message(code: 'vehicle.vinNumber.hint', default: 'Vin Number', encodeAs: 'HTML')}">
                        <td valign="top" class="name">
                            <label for="vinNumber">
                                <g:message code="vehicle.vinNumber.label" default="Vin Number" encodeAs="HTML"/>
                            </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'vinNumber', 'errors')}">
                            <g:textField name="vinNumber" value="${vehicleInstance?.vinNumber}"/>
                        </td>
                    </tr>

                    </tbody>
                </table>

                <table>
                    <tbody>

                    <tr class="prop" title="${message(code: 'serviceSchedule.nextService.hint',
                            default: 'Service Interval', encodeAs: 'HTML')}">
                        <td valign="top" class="name">
                            <label for="nextService">
                                <g:message code="serviceSchedule.nextService.label" default="Next Service (KM's)"
                                        encodeAs="HTML"/>
                            </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: serviceScheduleInstance, field: 'nextService', 'errors')}">
                            <g:textField name="nextService" value="${fieldValue(bean: serviceScheduleInstance, field: 'nextService')}"/>
                        </td>
                    </tr>

                    <tr class="prop" title="${message(code: 'serviceSchedule.serviceInterval.hint', default: 'Service Interval', encodeAs: 'HTML')}">
                        <td valign="top" class="name">
                            <label for="serviceInterval">
                                <g:message code="serviceSchedule.serviceInterval.label" default="Service Interval" encodeAs="HTML"/>
                            </label>
                        </td>
                        <td valign="top" class="value ${hasErrors(bean: serviceScheduleInstance, field: 'serviceInterval', 'errors')}">
                            <g:textField name="serviceInterval" value="${fieldValue(bean: serviceScheduleInstance, field: 'serviceInterval')}"/>
                        </td>
                    </tr>

                    </tbody>
                </table>

                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update', encodeAs:'HTML')}"/></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete', encodeAs:'HTML')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?', encodeAs:'HTML')}');"/></span>
                </div>
            </div>
        </fieldset>
    </g:form>
</div>
</body>
</html>
