

<%@ page import="fleetmanagement.Vehicle" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'vehicle.label', default: 'Vehicle')}" />
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
            <g:hasErrors bean="${vehicleInstance}">
            <div class="errors">
                <g:renderErrors bean="${vehicleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${vehicleInstance?.id}" />
                <g:hiddenField name="version" value="${vehicleInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="registrationNumber"><g:message code="vehicle.registrationNumber.label" default="Registration Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'registrationNumber', 'errors')}">
                                    <g:textField name="registrationNumber" value="${vehicleInstance?.registrationNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="make"><g:message code="vehicle.make.label" default="Make" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'make', 'errors')}">
                                    <g:textField name="make" maxlength="50" value="${vehicleInstance?.make}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="model"><g:message code="vehicle.model.label" default="Model" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'model', 'errors')}">
                                    <g:textField name="model" maxlength="50" value="${vehicleInstance?.model}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="year"><g:message code="vehicle.year.label" default="Year" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'year', 'errors')}">
                                    <g:textField name="year" maxlength="5" value="${vehicleInstance?.year}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="branch"><g:message code="vehicle.branch.label" default="Branch" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'branch', 'errors')}">
                                    <g:select name="branch.id" from="${fleetmanagement.Branch.list()}" optionKey="id" value="${vehicleInstance?.branch?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="serviceSchedule"><g:message code="vehicle.serviceSchedule.label" default="Service Schedule" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'serviceSchedule', 'errors')}">
                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="driver"><g:message code="vehicle.driver.label" default="Driver" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'driver', 'errors')}">
                                    <g:select name="driver.id" from="${fleetmanagement.Driver.list()}" optionKey="id" value="${vehicleInstance?.driver?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="licenseExpiryDate"><g:message code="vehicle.licenseExpiryDate.label" default="License Expiry Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'licenseExpiryDate', 'errors')}">
                                    <g:datePicker name="licenseExpiryDate" precision="day" value="${vehicleInstance?.licenseExpiryDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="odoReadings"><g:message code="vehicle.odoReadings.label" default="Odo Readings" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'odoReadings', 'errors')}">
                                    <g:select name="odoReadings" from="${fleetmanagement.OdoReading.list()}" multiple="yes" optionKey="id" size="5" value="${vehicleInstance?.odoReadings*.id}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reminders"><g:message code="vehicle.reminders.label" default="Reminders" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'reminders', 'errors')}">
                                    <g:select name="reminders" from="${fleetmanagement.Reminder.list()}" multiple="yes" optionKey="id" size="5" value="${vehicleInstance?.reminders*.id}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tracking"><g:message code="vehicle.tracking.label" default="Tracking" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'tracking', 'errors')}">
                                    <g:checkBox name="tracking" value="${vehicleInstance?.tracking}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="vinNumber"><g:message code="vehicle.vinNumber.label" default="Vin Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'vinNumber', 'errors')}">
                                    <g:textField name="vinNumber" value="${vehicleInstance?.vinNumber}" />
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
