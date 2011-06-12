

<%@ page import="fleetmanagement.Branch" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'branch.label', default: 'Branch')}" />
        <title><g:message code="default.edit.label" args='[entityName, "${branchInstance}"]' default="Edit Branch - ${' ' + branchInstance}" encodeAs="HTML" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args='[entityName, "${branchInstance}"]' default="Edit Branch - ${' ' + branchInstance}" encodeAs="HTML"/></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" encodeAs="HTML"/></div>
            </g:if>
            <g:hasErrors bean="${branchInstance}">
            <div class="errors">
                <g:renderErrors bean="${branchInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form controller="branch" >
                <fieldset>
                <g:hiddenField name="id" value="${branchInstance?.compositeId}" />
                <g:hiddenField name="version" value="${branchInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop" title="${message(code:'branch.name.hint' , default: 'Name', encodeAs:'HTML')}">
                                <td valign="top" class="name">
                                	<label for="name">
									<g:message code="branch.name.label" default="Name" encodeAs="HTML" />
                                	</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: branchInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="15" value="${branchInstance?.name}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
	                <div class="buttons">
	                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update', encodeAs:'HTML')}" /></span>
	                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete', encodeAs:'HTML')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?', encodeAs:'HTML')}');" /></span>
	                </div>
                </div>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
