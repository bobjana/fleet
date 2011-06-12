
<%@ page import="fleetmanagement.Vehicle" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'vehicle.label', default: 'Vehicle')}" />
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
            
            <g:hasErrors bean="${vehicleInstance}">
            <div class="errors">
                <g:renderErrors bean="${vehicleInstance}" as="list" />
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
		
		            <g:if test="${!vehicleInstanceList}">
						<g:message code="default.list.empty" default="No records available." encodeAs="HTML"/>
					</g:if>            
					<g:else>
		            <div class="list">
		                <table>
		                    <thead>
		                        <tr>
		                        	<th>&nbsp;</th>
		                        
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="registrationNumber" title="Registration Number" titleKey="vehicle.registrationNumber.label" />
															
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="make" title="Make" titleKey="vehicle.make.label" />
															
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="model" title="Model" titleKey="vehicle.model.label" />
															
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="year" title="Year" titleKey="vehicle.year.label" />
															
												<th class="notsortable"><g:message code="vehicleInstance.branch" default="Branch" encodeAs="HTML"/></th>
																		
												<th class="notsortable"><g:message code="vehicleInstance.serviceSchedule" default="Service Schedule" encodeAs="HTML"/></th>
																		
												<th class="notsortable"><g:message code="vehicleInstance.driver" default="Driver" encodeAs="HTML"/></th>
																		
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="licenseExpiryDate" title="License Expiry Date" titleKey="vehicle.licenseExpiryDate.label" />
															
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="tracking" title="Tracking" titleKey="vehicle.tracking.label" />
															
					                   	        <g:sortableColumn params="${(!sortableParams.isEmpty()?sortableParams:"")}" property="vinNumber" title="Vin Number" titleKey="vehicle.vinNumber.label" />
															
		                        </tr>
		                    </thead>
		                    <tbody> 
		                        <tr> 
		                        	<td>&nbsp;</td>
		                        	 
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Vehicle.executeQuery('select distinct a.registrationNumber from Vehicle as a where a.registrationNumber is not null and length(a.registrationNumber)>0 order by a.registrationNumber')}" name="filter.registrationNumber" value="${params.filter?.registrationNumber}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Vehicle.executeQuery('select distinct a.make from Vehicle as a where a.make is not null and length(a.make)>0 order by a.make')}" name="filter.make" value="${params.filter?.make}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Vehicle.executeQuery('select distinct a.model from Vehicle as a where a.model is not null and length(a.model)>0 order by a.model')}" name="filter.model" value="${params.filter?.model}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Vehicle.executeQuery('select distinct a.year from Vehicle as a where a.year is not null and length(a.year)>0 order by a.year')}" name="filter.year" value="${params.filter?.year}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="id" from="${fleetmanagement.Branch.executeQuery('select distinct a from fleetmanagement.Branch as a, Vehicle as b where a=b.branch').sort()}" name="filter.branch" value="${params.filter?.branch}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="id" from="${fleetmanagement.ServiceSchedule.executeQuery('select distinct a from fleetmanagement.ServiceSchedule as a, Vehicle as b where a=b.serviceSchedule').sort()}" name="filter.serviceSchedule" value="${params.filter?.serviceSchedule}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="id" from="${fleetmanagement.Driver.executeQuery('select distinct a from fleetmanagement.Driver as a, Vehicle as b where a=b.driver').sort()}" name="filter.driver" value="${params.filter?.driver}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="time" from="${Vehicle.executeQuery('select distinct a.licenseExpiryDate from Vehicle as a where a.licenseExpiryDate is not null and length(a.licenseExpiryDate)>0 order by a.licenseExpiryDate')}" name="filter.licenseExpiryDate" value="${params.filter?.licenseExpiryDate}" optionValue="${{formatDate(format:'dd.MM.yyyy',date:it)}}" valueMessagePrefix=""></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Vehicle.executeQuery('select distinct a.tracking from Vehicle as a where a.tracking is not null and length(a.tracking)>0 order by a.tracking')}" name="filter.tracking" value="${params.filter?.tracking}" optionValue="" valueMessagePrefix="default.boolean"></g:select>
										</td>
								
										<td>
											<g:select style="" onchange="submit();" noSelection="['-2147483648':message(code:'default.list.filter', default:'filter', encodeAs:'HTML')]" optionKey="" from="${Vehicle.executeQuery('select distinct a.vinNumber from Vehicle as a where a.vinNumber is not null and length(a.vinNumber)>0 order by a.vinNumber')}" name="filter.vinNumber" value="${params.filter?.vinNumber}" optionValue="" valueMessagePrefix=""></g:select>
										</td>
								</tr>
							
							
		                  
		                  
		                  	<g:each in="${vehicleInstanceList}" status="i" var="vehicleInstance">
		                      		<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
		                      
				                    <td>
				   						<g:if test="${params.callback}"> 
				   							<g:link action="choose" params="${params}" id="${vehicleInstance.compositeId}"><img src='<g:resource dir="images/skin" file="database_add.png"/>' alt="Associate"/></g:link>
										</g:if>  
										<g:if test="${params?.callback==null}"> 
											<g:link action="show"   id="${vehicleInstance.compositeId}"><img src='<g:resource dir="images/skin" file="information.png"/>' alt="Show"/></g:link>
											<g:link action="edit"   id="${vehicleInstance.compositeId}"><img src='<g:resource dir="images/skin" file="database_edit.png"/>' alt="Edit"/></g:link>
											<g:link action="delete" id="${vehicleInstance.compositeId}" onclick="return confirm('${message(code:'default.button.delete.confirm.message', default:'Are you sure?', encodeAs:'HTML')}');"><img src='<g:resource dir="images/skin" file="database_delete.png"/>' alt="Delete"/></g:link>
				                    	</g:if>  	
				                    </td>
					            
			                        <td class="value">${fieldValue(bean:vehicleInstance, field:"registrationNumber")}&nbsp;</td>
			                        		
			                        <td class="value">${fieldValue(bean:vehicleInstance, field:"make")}&nbsp;</td>
			                        		
			                        <td class="value">${fieldValue(bean:vehicleInstance, field:"model")}&nbsp;</td>
			                        		
			                        <td class="value">${fieldValue(bean:vehicleInstance, field:"year")}&nbsp;</td>
			                        		
									<td class="value"><g:link controller="branch" action="show" id="${vehicleInstance?.branch?.compositeId}">${fieldValue(bean:vehicleInstance, field:"branch")}</g:link>&nbsp;</td>
											 
									<td class="value"><g:link controller="serviceSchedule" action="show" id="${vehicleInstance?.serviceSchedule?.compositeId}">${fieldValue(bean:vehicleInstance, field:"serviceSchedule")}</g:link>&nbsp;</td>
											 
									<td class="value"><g:link controller="driver" action="show" id="${vehicleInstance?.driver?.compositeId}">${fieldValue(bean:vehicleInstance, field:"driver")}</g:link>&nbsp;</td>
											  
									<td class="date"><g:formatDate date="${vehicleInstance.licenseExpiryDate}" format="dd.MM.yyyy"/>&nbsp;</td>
											 
									<td class="checkbox"><g:checkBox class="checkbox" name="tracking${vehicleInstance.compositeId}" disabled="true" checked="${fieldValue(bean:vehicleInstance, field:'tracking').toString()}" value="${fieldValue(bean:vehicleInstance, field:'tracking')}"></g:checkBox></td>
											 
			                        <td class="value">${fieldValue(bean:vehicleInstance, field:"vinNumber")}&nbsp;</td>
			                        		
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
