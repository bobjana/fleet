
<%@ page import="fleetmanagement.Branch" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'branch.label', default: 'Branch')}" />
        <title><g:message code="default.list.label" args="[entityName]" encodeAs="HTML"/></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" encodeAs="HTML" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" encodeAs="HTML"/></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" encodeAs="HTML"/></div>
            </g:if>
            
            <g:hasErrors bean="${branchInstance}">
            <div class="errors">
                <g:renderErrors bean="${branchInstance}" as="list" />
            </div>
            </g:hasErrors>
            
			<g:form action="list" method="post" >
				<fieldset>
					<!-- do not forget sort and order criteria -->
					<g:hiddenField name="sort" value="${params.sort}" />
					<g:hiddenField name="order" value="${params.order}" />
	
					<!-- do not forget source for associating existing objects -->
					<g:if test="${params.callback}">
						<g:hiddenField name="callback" value="${params.callback}" />
					</g:if>
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
		
		            <g:if test="${!branchInstanceList}">
						<g:message code="default.list.empty" default="No records available." encodeAs="HTML"/>
					</g:if>            
					<g:else>
		            <div class="list">
		                <table>
		                    <thead>
		                        <tr>
		                        	<th>&nbsp;</th>
		                        
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="name" title="Name" titleKey="branch.name.label" />
															
		                        </tr>
		                    </thead>
		                    <tbody> 
		                        <tr> 
		                        	<td>&nbsp;</td>
		                        	 
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Branch.executeQuery('select distinct a.name from Branch as a where a.name is not null and length(a.name)>0 order by a.name')}" name="filter.name" value="${params.filter?.name}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								</tr>
							
							
		                  
		                  
		                  	<g:each in="${branchInstanceList}" status="i" var="branchInstance">
		                      		<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		                      
				                    <td>
				   						<g:if test="${params.callback}"> 
				   							<g:link action="choose" params="${params}" id="${branchInstance.compositeId}"><img src='<g:resource dir="images/skin" file="database_add.png"/>' alt="Associate"/></g:link>
										</g:if>  
										<g:if test="${params?.callback==null}"> 
											<g:link action="show"   id="${branchInstance.compositeId}"><img src='<g:resource dir="images/skin" file="information.png"/>' alt="Show"/></g:link>
											<g:link action="edit"   id="${branchInstance.compositeId}"><img src='<g:resource dir="images/skin" file="database_edit.png"/>' alt="Edit"/></g:link>
											<g:link action="delete" id="${branchInstance.compositeId}" onclick="return confirm('${message(code:'default.button.delete.confirm.message', default:'Are you sure?', encodeAs:'HTML')}');"><img src='<g:resource dir="images/skin" file="database_delete.png"/>' alt="Delete"/></g:link>
				                    	</g:if>  	
				                    </td>
					            
			                        <td class="value">${fieldValue(bean:branchInstance, field:"name")}&nbsp;</td>
			                        		
		                     	</tr>
		                </g:each>
		                		<tr>
		                			<td class="paginateButtons" colspan="100%">
							            <div class="">
											<g:paginate max="20" params="${params.findAll{ k,v -> k != 'filter' && k!= 'offset'}}" total="${paginateTotal}" />
		           						</div>
		           					</td>
		           				</tr>
		                    </tbody>
		                </table>
		            </div>
					</g:else>
        		</fieldset>
			</g:form>
        </div>
    </body>
</html>
