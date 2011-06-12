

<%@ page import="fleetmanagement.Driver" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'driver.label', default: 'Driver')}" />
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
            <g:hasErrors bean="${driverInstance}">
            <div class="errors">
                <g:renderErrors bean="${driverInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form controller="driver" action="save"  enctype="multipart/form-data">
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
                        
                            <tr class="prop" title="${message(code:'driver.firstName.hint' , default: 'First Name', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="firstName">
									<g:message code="driver.firstName.label" default="First Name" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" maxlength="50" value="${driverInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'driver.surname.hint' , default: 'Surname', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="surname">
									<g:message code="driver.surname.label" default="Surname" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'surname', 'errors')}">
                                    <g:textField name="surname" maxlength="50" value="${driverInstance?.surname}" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'driver.branch.hint' , default: 'Branch', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="branch">
									<g:message code="driver.branch.label" default="Branch" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'branch', 'errors')}">
                                    <g:select id="branch" name="branch.id" from="${fleetmanagement.Branch.list().sort()}" optionKey="id" value="${driverInstance?.branch?.compositeId}" noSelection="['null': message(code:'default.choose.required', default:'Select one')]" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'driver.cellPhoneNumber.hint' , default: 'Cell Phone Number', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="cellPhoneNumber">
									<g:message code="driver.cellPhoneNumber.label" default="Cell Phone Number" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'cellPhoneNumber', 'errors')}">
                                    <g:textField name="cellPhoneNumber" value="${driverInstance?.cellPhoneNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'driver.licenseExpiryDate.hint' , default: 'License Expiry Date', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	
									<g:message code="driver.licenseExpiryDate.label" default="License Expiry Date" encodeAs="HTML" />
                                	
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'licenseExpiryDate', 'errors')}">
                                    <g:datePicker name="licenseExpiryDate" precision="day" value="${driverInstance?.licenseExpiryDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'driver.ptcExpiryDate.hint' , default: 'Ptc Expiry Date', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	
									<g:message code="driver.ptcExpiryDate.label" default="Ptc Expiry Date" encodeAs="HTML" />
                                	
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'ptcExpiryDate', 'errors')}">
                                    <g:datePicker name="ptcExpiryDate" precision="day" value="${driverInstance?.ptcExpiryDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'driver.licenseCopy.hint' , default: 'License Copy', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="licenseCopy">
									<g:message code="driver.licenseCopy.label" default="License Copy" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'licenseCopy', 'errors')}">
                                    <input  type="file" id="licenseCopy" name="licenseCopy" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'driver.ptcCopy.hint' , default: 'Ptc Copy', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="ptcCopy">
									<g:message code="driver.ptcCopy.label" default="Ptc Copy" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'ptcCopy', 'errors')}">
                                    <input  type="file" id="ptcCopy" name="ptcCopy" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'driver.employeeCode.hint' , default: 'Employee Code', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="employeeCode">
									<g:message code="driver.employeeCode.label" default="Employee Code" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'employeeCode', 'errors')}">
                                    <g:textField name="employeeCode" value="${driverInstance?.employeeCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'driver.idNumber.hint' , default: 'Id Number', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="idNumber">
									<g:message code="driver.idNumber.label" default="Id Number" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: driverInstance, field: 'idNumber', 'errors')}">
                                    <g:textField name="idNumber" value="${driverInstance?.idNumber}" />
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
