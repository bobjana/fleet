

<%@ page import="fleetmanagement.Driver" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'driver.label', default: 'Driver')}" />
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
            <g:hasErrors bean="${driverInstance}">
            <div class="errors">
                <g:renderErrors bean="${driverInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post"  enctype="multipart/form-data">
                <g:hiddenField name="id" value="${driverInstance?.id}" />
                <g:hiddenField name="version" value="${driverInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="firstName"><g:message code="driver.firstName.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" maxlength="50" value="${driverInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="surname"><g:message code="driver.surname.label" default="Surname" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'surname', 'errors')}">
                                    <g:textField name="surname" maxlength="50" value="${driverInstance?.surname}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="branch"><g:message code="driver.branch.label" default="Branch" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'branch', 'errors')}">
                                    <g:select name="branch.id" from="${fleetmanagement.Branch.list()}" optionKey="id" value="${driverInstance?.branch?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cellPhoneNumber"><g:message code="driver.cellPhoneNumber.label" default="Cell Phone Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'cellPhoneNumber', 'errors')}">
                                    <g:textField name="cellPhoneNumber" value="${driverInstance?.cellPhoneNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="user"><g:message code="driver.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${fleetmanagement.User.list()}" optionKey="id" value="${driverInstance?.user?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="licenseExpiryDate"><g:message code="driver.licenseExpiryDate.label" default="License Expiry Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'licenseExpiryDate', 'errors')}">
                                    <g:datePicker name="licenseExpiryDate" precision="day" value="${driverInstance?.licenseExpiryDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="ptcExpiryDate"><g:message code="driver.ptcExpiryDate.label" default="Ptc Expiry Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'ptcExpiryDate', 'errors')}">
                                    <g:datePicker name="ptcExpiryDate" precision="day" value="${driverInstance?.ptcExpiryDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="licenseCopy"><g:message code="driver.licenseCopy.label" default="License Copy" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'licenseCopy', 'errors')}">
                                    <input type="file" id="licenseCopy" name="licenseCopy" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="ptcCopy"><g:message code="driver.ptcCopy.label" default="Ptc Copy" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'ptcCopy', 'errors')}">
                                    <input type="file" id="ptcCopy" name="ptcCopy" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="active"><g:message code="driver.active.label" default="Active" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'active', 'errors')}">
                                    <g:checkBox name="active" value="${driverInstance?.active}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fullName"><g:message code="driver.fullName.label" default="Full Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'fullName', 'errors')}">
                                    <g:textField name="fullName" value="${driverInstance?.fullName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="idNumber"><g:message code="driver.idNumber.label" default="Id Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'idNumber', 'errors')}">
                                    <g:textField name="idNumber" value="${driverInstance?.idNumber}" />
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
