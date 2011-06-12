

<%@ page import="fleetmanagement.Supervisor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supervisor.label', default: 'Supervisor')}" />
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
            <g:hasErrors bean="${supervisorInstance}">
            <div class="errors">
                <g:renderErrors bean="${supervisorInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form controller="supervisor" action="save" >
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
                        
                            <tr class="prop" title="${message(code:'supervisor.firstName.hint' , default: 'First Name', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="firstName">
									<g:message code="supervisor.firstName.label" default="First Name" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" maxlength="50" value="${supervisorInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'supervisor.surname.hint' , default: 'Surname', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="surname">
									<g:message code="supervisor.surname.label" default="Surname" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'surname', 'errors')}">
                                    <g:textField name="surname" maxlength="50" value="${supervisorInstance?.surname}" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'supervisor.branch.hint' , default: 'Branch', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="branch">
									<g:message code="supervisor.branch.label" default="Branch" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'branch', 'errors')}">
                                    <g:select id="branch" name="branch.id" from="${fleetmanagement.Branch.list().sort()}" optionKey="id" value="${supervisorInstance?.branch?.compositeId}" noSelection="['null': message(code:'default.choose.required', default:'Select one')]" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'supervisor.cellPhoneNumber.hint' , default: 'Cell Phone Number', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="cellPhoneNumber">
									<g:message code="supervisor.cellPhoneNumber.label" default="Cell Phone Number" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'cellPhoneNumber', 'errors')}">
                                    <g:textField name="cellPhoneNumber" value="${supervisorInstance?.cellPhoneNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'supervisor.email.hint' , default: 'Email', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="email">
									<g:message code="supervisor.email.label" default="Email" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${supervisorInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'supervisor.employeeCode.hint' , default: 'Employee Code', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="employeeCode">
									<g:message code="supervisor.employeeCode.label" default="Employee Code" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'employeeCode', 'errors')}">
                                    <g:textField name="employeeCode" value="${supervisorInstance?.employeeCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop" title="${message(code:'supervisor.idNumber.hint' , default: 'Id Number', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="idNumber">
									<g:message code="supervisor.idNumber.label" default="Id Number" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supervisorInstance, field: 'idNumber', 'errors')}">
                                    <g:textField name="idNumber" value="${supervisorInstance?.idNumber}" />
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
