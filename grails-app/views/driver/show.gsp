<%@ page import="fleetmanagement.Driver" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'driver.label', default: 'Driver')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                           args="[entityName]"/></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label"
                                                                               args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>

    <div class="dialog">

        <jqueryui:jquiTab id="tabs"/>

        <div id="tabs">
            <ul>
                <li><a href="#tabs-1">General</a></li>
                <li><a href="#tabs-2">License</a></li>
                <li><a href="#tabs-3">PTC</a></li>
            </ul>

                <div id="tabs-1">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="driver.firstName.label" default="First Name"/></td>

                    <td valign="top" class="value">${fieldValue(bean: driverInstance, field: "firstName")}</td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="driver.surname.label" default="Surname"/></td>

                    <td valign="top" class="value">${fieldValue(bean: driverInstance, field: "surname")}</td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="driver.branch.label" default="Branch"/></td>

                    <td valign="top" class="value"><g:link controller="branch" action="show"
                                                           id="${driverInstance?.branch?.id}">${driverInstance?.branch?.encodeAsHTML()}</g:link></td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="driver.cellPhoneNumber.label"
                                                             default="Cell Phone Number"/></td>

                    <td valign="top" class="value">${fieldValue(bean: driverInstance, field: "cellPhoneNumber")}</td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="driver.licenseExpiryDate.label"
                                                             default="License Expiry Date"/></td>

                    <td valign="top" class="value"><g:formatDate date="${driverInstance?.licenseExpiryDate}"/></td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="driver.ptcExpiryDate.label"
                                                             default="Ptc Expiry Date"/></td>

                    <td valign="top" class="value"><g:formatDate date="${driverInstance?.ptcExpiryDate}"/></td>

                </tr>

                <tr class="prop">
                    <td valign="top" class="name"><g:message code="driver.idNumber.label" default="Id Number"/></td>

                    <td valign="top" class="value">${fieldValue(bean: driverInstance, field: "idNumber")}</td>

                </tr>

                </tbody>
            </table>

            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${driverInstance?.id}"/>
                    <span class="button"><g:actionSubmit class="edit" action="edit"
                                                         value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete"
                                                         value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                         onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                </g:form>
            </div>

        </div>


        <div id="tabs-2">
            <div class="imageContainer" id="licenseCopy">
                <img src="${createLink(action: 'displayLicenseCopy',
                        id: driverInstance?.id)}" style="width:430;height:445px;"/>
            </div>

            %{--<gui:dialog--}%
                    %{--title="Upload Copy"--}%
                    %{--form="true"--}%
                    %{--modal="true"--}%
                    %{--controller="driver"--}%
                    %{--action="uploadLicenseCopy"--}%
                    %{--update="licenseCopy"--}%
                    %{--triggers="[show:[id:'uploadLicenseCopyBtn', on:'click']]">--}%
                %{--<input type="file" id="licenseCopy" name="ptcCopy"/>--}%
                %{--<g:hiddenField name="id" value="${driverInstance?.id}"/>--}%
            %{--</gui:dialog>--}%

            <div class="buttons">
                <g:form>

                    <span class="button"><input type="button" id="uploadLicenseCopyBtn"
                                                value="${message(code: 'default.button.edit.label')}"/></span>
                    <g:if test="${driverInstance.licenseCopy}">
                        <span class="button"><g:actionSubmit class="delete" action="deleteLicenseCopy" value="${message(code:
                            'default.button.delete.label', default: 'Delete')}"
                                                             onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                    </g:if>
                </g:form>
            </div>

        </div>

        <div id="tabs-3">
            <table>
                <tr>
                    <td><img src="${createLink(action: 'displayPtcCopy', id: driverInstance?.id)}"
                             style="width:430;height:445px;"/>
                    </td>
                </tr>
            </table>
        </div>


        </div>




    </div>

</body>
</html>
