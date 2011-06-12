<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
        <g:set var="onLoadContent" value="${((params.action=='edit'||params.action == 'create')?'setFocusOnFirstControl()':'')}" />
    </head>
    <body onload="${onLoadContent}">
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
        <div id="grailsLogo"><a href="http://grails.org"><img src="${resource(dir:'images',file:'grails_logo.png')}" alt="Grails" /></a></div>

        <div class="mainnav">
			<div id="tabs">
			<ul>
				<li class='${params.controller==null?"active":""}'><g:link controller="."><g:message code="default.home.label" /></g:link></li>
			<g:each var="c" in="${grailsApplication.controllerClasses.findAll {e -> e.name != 'Base'}.sort { a,b -> a.fullName <=> b.fullName }   }">
			    <li class='${params.controller==c.logicalPropertyName?"active":""}'><g:link controller="${c.logicalPropertyName}"><g:message code="${c.logicalPropertyName}.menu" default="${c.fullName.replace("Controller","")}"/></g:link></li>
			</g:each>
			</ul>
			</div>
        </div>

        <g:layoutBody />
    </body>
</html>