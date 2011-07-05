
<%@ page import="fleetmanagement.Vehicle" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'vehicle.label', default: 'Vehicle')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vehicleInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.registrationNumber.label" default="Registration Number" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vehicleInstance, field: "registrationNumber")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.make.label" default="Make" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vehicleInstance, field: "make")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.model.label" default="Model" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vehicleInstance, field: "model")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.year.label" default="Year" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vehicleInstance, field: "year")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.branch.label" default="Branch" /></td>
                            
                            <td valign="top" class="value"><g:link controller="branch" action="show" id="${vehicleInstance?.branch?.id}">${vehicleInstance?.branch?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.serviceSchedule.label" default="Service Schedule" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vehicleInstance, field: "serviceSchedule")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.driver.label" default="Driver" /></td>
                            
                            <td valign="top" class="value"><g:link controller="driver" action="show" id="${vehicleInstance?.driver?.id}">${vehicleInstance?.driver?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.licenseExpiryDate.label" default="License Expiry Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${vehicleInstance?.licenseExpiryDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.odoReadings.label" default="Odo Readings" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${vehicleInstance.odoReadings}" var="o">
                                    <li><g:link controller="odoReading" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.reminders.label" default="Reminders" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${vehicleInstance.reminders}" var="r">
                                    <li><g:link controller="reminder" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.tracking.label" default="Tracking" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${vehicleInstance?.tracking}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vehicle.vinNumber.label" default="Vin Number" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vehicleInstance, field: "vinNumber")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${vehicleInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
