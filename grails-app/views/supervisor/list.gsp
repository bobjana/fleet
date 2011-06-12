
<%@ page import="fleetmanagement.Supervisor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supervisor.label', default: 'Supervisor')}" />
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
            
            <g:hasErrors bean="${supervisorInstance}">
            <div class="errors">
                <g:renderErrors bean="${supervisorInstance}" as="list" />
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
		
		            <g:if test="${!supervisorInstanceList}">
						<g:message code="default.list.empty" default="No records available." encodeAs="HTML"/>
					</g:if>            
					<g:else>
		            <div class="list">
		                <table>
		                    <thead>
		                        <tr>
		                        	<th>&nbsp;</th>
		                        
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="firstName" title="First Name" titleKey="supervisor.firstName.label" />
															
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="surname" title="Surname" titleKey="supervisor.surname.label" />
															
												<th class="notsortable"><g:message code="supervisorInstance.branch" default="Branch" encodeAs="HTML"/></th>
																		
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="cellPhoneNumber" title="Cell Phone Number" titleKey="supervisor.cellPhoneNumber.label" />
															
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="email" title="Email" titleKey="supervisor.email.label" />
															
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="employeeCode" title="Employee Code" titleKey="supervisor.employeeCode.label" />
															
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="idNumber" title="Id Number" titleKey="supervisor.idNumber.label" />
															
		                        </tr>
		                    </thead>
		                    <tbody> 
		                        <tr> 
		                        	<td>&nbsp;</td>
		                        	 
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Supervisor.executeQuery('select distinct a.firstName from Supervisor as a where a.firstName is not null and length(a.firstName)>0 order by a.firstName')}" name="filter.firstName" value="${params.filter?.firstName}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Supervisor.executeQuery('select distinct a.surname from Supervisor as a where a.surname is not null and length(a.surname)>0 order by a.surname')}" name="filter.surname" value="${params.filter?.surname}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="id" from="${fleetmanagement.Branch.executeQuery('select distinct a from fleetmanagement.Branch as a, Supervisor as b where a=b.branch').sort()}" name="filter.branch" value="${params.filter?.branch}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Supervisor.executeQuery('select distinct a.cellPhoneNumber from Supervisor as a where a.cellPhoneNumber is not null and length(a.cellPhoneNumber)>0 order by a.cellPhoneNumber')}" name="filter.cellPhoneNumber" value="${params.filter?.cellPhoneNumber}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Supervisor.executeQuery('select distinct a.email from Supervisor as a where a.email is not null and length(a.email)>0 order by a.email')}" name="filter.email" value="${params.filter?.email}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Supervisor.executeQuery('select distinct a.employeeCode from Supervisor as a where a.employeeCode is not null and length(a.employeeCode)>0 order by a.employeeCode')}" name="filter.employeeCode" value="${params.filter?.employeeCode}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Supervisor.executeQuery('select distinct a.idNumber from Supervisor as a where a.idNumber is not null and length(a.idNumber)>0 order by a.idNumber')}" name="filter.idNumber" value="${params.filter?.idNumber}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								</tr>
							
							
		                  
		                  
		                  	<g:each in="${supervisorInstanceList}" status="i" var="supervisorInstance">
		                      		<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		                      
				                    <td>
				   						<g:if test="${params.callback}"> 
				   							<g:link action="choose" params="${params}" id="${supervisorInstance.compositeId}"><img src='<g:resource dir="images/skin" file="database_add.png"/>' alt="Associate"/></g:link>
										</g:if>  
										<g:if test="${params?.callback==null}"> 
											<g:link action="show"   id="${supervisorInstance.compositeId}"><img src='<g:resource dir="images/skin" file="information.png"/>' alt="Show"/></g:link>
											<g:link action="edit"   id="${supervisorInstance.compositeId}"><img src='<g:resource dir="images/skin" file="database_edit.png"/>' alt="Edit"/></g:link>
											<g:link action="delete" id="${supervisorInstance.compositeId}" onclick="return confirm('${message(code:'default.button.delete.confirm.message', default:'Are you sure?', encodeAs:'HTML')}');"><img src='<g:resource dir="images/skin" file="database_delete.png"/>' alt="Delete"/></g:link>
				                    	</g:if>  	
				                    </td>
					            
			                        <td class="value">${fieldValue(bean:supervisorInstance, field:"firstName")}&nbsp;</td>
			                        		
			                        <td class="value">${fieldValue(bean:supervisorInstance, field:"surname")}&nbsp;</td>
			                        		
									<td class="value"><g:link controller="branch" action="show" id="${supervisorInstance?.branch?.compositeId}">${fieldValue(bean:supervisorInstance, field:"branch")}</g:link>&nbsp;</td>
											 
			                        <td class="value">${fieldValue(bean:supervisorInstance, field:"cellPhoneNumber")}&nbsp;</td>
			                        		
			                        <td class="value">${fieldValue(bean:supervisorInstance, field:"email")}&nbsp;</td>
			                        		
			                        <td class="value">${fieldValue(bean:supervisorInstance, field:"employeeCode")}&nbsp;</td>
			                        		
			                        <td class="value">${fieldValue(bean:supervisorInstance, field:"idNumber")}&nbsp;</td>
			                        		
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
