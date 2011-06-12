package fleetmanagement

class DriverController {

    static allowedMethods = [save: "POST", update: "POST", delete: ['POST', 'GET']]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        // pre process the input params and set defaults
        if (!params.max) params.max = 20
        if (!params.offset) params.offset = 0

        // sort may stay null, if Domain does not support sorting

        if (!params.sort) params.sort = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(Driver.class, 'mapping')?.getMapping()?.getSort()
        if (!params.order) params.order = org.codehaus.groovy.grails.commons.GrailsClassUtils.getStaticPropertyValue(Driver.class, 'mapping')?.getMapping()?.getOrder()
        if (!params.order) params.order = "asc"

        // parameters for hsql query
        Hashtable namedParams = new Hashtable();

        // parameters for sortableColumn in list view, they have a prefix "filter."
        Hashtable sortableParams = new Hashtable();

        // separated parts of the hsql query
        def querySql = "FROM Driver driver WHERE 1=1"
        def whereSql = ""
        def orderBySql = ""

        // create query for filter and sort
        whereSql = applyFilters(params, namedParams, sortableParams, whereSql)

        // restrict resultset according to callback params
        // when user is (de-)associating objects
        whereSql = applyCallbackParams(params, namedParams, sortableParams, whereSql)

        // create the order by clause
        orderBySql = applySortCriterias(params)

        // last but not least get the result list...
        def result = Driver.findAll(querySql + whereSql + orderBySql, namedParams, [max: params.max.toInteger(), offset: params.offset.toInteger()])

        /// ...and the total number of records
        def countResult = Driver.executeQuery("select count(*) " + querySql + whereSql, namedParams)
        def paginateTotal = countResult[0]

        // use "show" view instead of list, if there is only one record in result
        // as long as there is no (de-)associating on the way
        if ((paginateTotal == 1) && (result.size == 1) && (!params.callback)) {
            redirect(action: "show", id: result.get(0).compositeId)
            return
        }

        return [driverInstanceList: result, paginateTotal: paginateTotal, sortableParams: sortableParams]
    }


    def create = {
        def driverInstance = new Driver()
        driverInstance.properties = params
        return [driverInstance: driverInstance]
    }


    def save = {
        def driverInstance = new Driver(params)
        if (driverInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'driver.label', default: 'Driver'), driverInstance])}"

            // during association, the callback must be executed
            if (params.source != null && params.source != "") {
                def linkClass = grailsApplication.getClassForName(params.class)
                def theLink = linkClass.getComposite(params.source_id)
                def d = params.dest
                theLink."addTo${d[0].toUpperCase() + d.substring(1)}"(driverInstance);

                def rd = params.refDest
                // set just if not unidirectional
                if (rd && rd != "") {
                    if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(Driver.class, rd))) {
                        driverInstance."addTo${rd[0].toUpperCase() + rd.substring(1)}"(theLink);
                    }
                }
                theLink.save()

                // and back to edit page of associated object
                redirect(controller: params.source, action: "edit", id: params.source_id)
            } else {
                // HK go to list instead of show
                //redirect(action: "show", id: driverInstance.id)
                redirect(action: list)
            }
        }
        else {
            render(view: "create", model: [driverInstance: driverInstance])
        }
    }


    def show = {
        def driverInstance = Driver.getComposite(params.id)
        if (!driverInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
            redirect(action: "list")
        }
        else {
            [driverInstance: driverInstance]
        }
    }


    def edit = {
        def driverInstance = Driver.getComposite(params.id)
        if (!driverInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [driverInstance: driverInstance]
        }
    }


    def update = {
        def driverInstance = Driver.getComposite(params.id)
        if (driverInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (driverInstance.version > version) {

                    driverInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'driver.label', default: 'Driver')] as Object[], "Another user has updated this Driver while you were editing.")
                    render(view: "edit", model: [driverInstance: driverInstance])
                    return
                }
            }
            driverInstance.properties = params
            if (!driverInstance.hasErrors() && driverInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'driver.label', default: 'Driver'), driverInstance])}"
                // go to list instead of show
                //redirect(action: "show", id: driverInstance.id)
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [driverInstance: driverInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
            redirect(action: "list")
        }
    }


    def delete = {
        def driverInstance = Driver.get(params.id)
        if (driverInstance) {
            try {
                driverInstance.active = false
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
            redirect(action: "list")
        }
    }

    def displayLicense = {
        def driverInstance = Driver.get(params.id)
        response.contentType = "image/jpeg"
        response.contentLength = driverInstance?.licenseCopy.length
        response.outputStream.write(driverInstance?.licenseCopy)
    }

    def displayPtc = {
        def driverInstance = Driver.get(params.id)
        response.contentType = "image/jpeg"
        response.contentLength = driverInstance?.ptcCopy.length
        response.outputStream.write(driverInstance?.ptcCopy)
    }


    def choose = {
        // redirect to (de-)associating
        params.class = "fleetmanagement.Driver"
        redirect(controller: params.source, action: params.callback, params: params)
    }


    def link = {
        // establish the association
        def driverInstance = Driver.getComposite(params.source_id)
        def linkClass = grailsApplication.getClassForName(params.class)
        def theLink = linkClass.getComposite(params.id)
        def d = params.dest

        driverInstance."addTo${d[0].toUpperCase() + d.substring(1)}"(theLink);
        driverInstance.validate() // will mark any errors in edit view

        def rd = params.refDest
        // set other side just if not unidirectional
        if (rd && rd != "") {
            if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(linkClass, rd))) {
                // n:m
                theLink."addTo${rd[0].toUpperCase() + rd.substring(1)}"(driverInstance)

                try {
                    theLink.save(flush: true)
                } catch (org.springframework.dao.DataIntegrityViolationException e) {
                    log.error("Link Exception: " + e)
                    driverInstance.errors.reject("driverInstance.${d}.associate.failed", [params.id] as Object[], "Unable to associate " + linkClass + " with id ${params.id}")
                }
            }
        }
        // use render instead of redirect to get validation errors
        render(view: 'edit', model: [driverInstance: driverInstance])
    }


    def unlink = {
        // remove the association, without deleting any object
        def driverInstance = Driver.getComposite(params.source_id)
        def linkClass = grailsApplication.getClassForName(params.class)
        def theLink = linkClass.getComposite(params.id)
        def d = params.dest
        driverInstance."removeFrom${d[0].toUpperCase() + d.substring(1)}"(theLink);

        driverInstance.validate() // will mark any errors in edit view

        def rd = params.refDest
        // set other side just if not unidirectional
        if (rd && rd != "") {
            if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(linkClass, rd))) {
                // n:m
                theLink."removeFrom${rd[0].toUpperCase() + rd.substring(1)}"(driverInstance)

                try {
                    theLink.save(flush: true)
                } catch (org.springframework.dao.DataIntegrityViolationException e) {
                    log.error("Unlink Exception: " + e)
                    driverInstance.errors.reject("driverInstance.${d}.deassociate.failed", [params.id] as Object[], "Unable to deassociate " + linkClass + " with id ${params.id}")
                }
            }
        }

        // use render instead of redirect to get validation errors
        render(view: 'edit', model: [driverInstance: driverInstance])
    }


    private void deleteReferencesInController(x) {
        // would be better to place this code in domain or service
        // but that's not possible due to generation limitations

    }

    // internal helper methods

    def applyFilters(params, namedParams, sortableParams, whereSql) {

        // start with filter attributes...
        whereSql += " AND driver.active=:active"
        namedParams.put("active", true)

        if (params.filter?.firstName && params.filter?.firstName != Integer.MIN_VALUE.toString()) {
            whereSql += " AND driver.firstName=:firstName"
            namedParams.put("firstName", params.filter.firstName)
            sortableParams.put("filter.firstName", params.filter.firstName)
        }

        if (params.filter?.surname && params.filter?.surname != Integer.MIN_VALUE.toString()) {
            whereSql += " AND driver.surname=:surname"
            namedParams.put("surname", params.filter.surname)
            sortableParams.put("filter.surname", params.filter.surname)
        }

        if (params.filter?.branch && params.filter?.branch != Integer.MIN_VALUE.toString()) {
            whereSql += " AND driver.branch.id=:branch"
            namedParams.put("branch", new Long(params.filter.branch))
            sortableParams.put("filter.branch", params.filter.branch)
        }

        if (params.filter?.cellPhoneNumber && params.filter?.cellPhoneNumber != Integer.MIN_VALUE.toString()) {
            whereSql += " AND driver.cellPhoneNumber=:cellPhoneNumber"
            namedParams.put("cellPhoneNumber", params.filter.cellPhoneNumber)
            sortableParams.put("filter.cellPhoneNumber", params.filter.cellPhoneNumber)
        }

        if (params.filter?.licenseExpiryDate && params.filter?.licenseExpiryDate != Integer.MIN_VALUE.toString()) {
            whereSql += " AND driver.licenseExpiryDate=:licenseExpiryDate"
            namedParams.put("licenseExpiryDate", new Date(new Long(params.filter.licenseExpiryDate)))
            sortableParams.put("filter.licenseExpiryDate", params.filter.licenseExpiryDate)
        }

        if (params.filter?.ptcExpiryDate && params.filter?.ptcExpiryDate != Integer.MIN_VALUE.toString()) {
            whereSql += " AND driver.ptcExpiryDate=:ptcExpiryDate"
            namedParams.put("ptcExpiryDate", new Date(new Long(params.filter.ptcExpiryDate)))
            sortableParams.put("filter.ptcExpiryDate", params.filter.ptcExpiryDate)
        }

        if (params.filter?.licenseCopy && params.filter?.licenseCopy != Integer.MIN_VALUE.toString()) {
            whereSql += " AND driver.licenseCopy=:licenseCopy"
            namedParams.put("licenseCopy", params.filter.licenseCopy)
            sortableParams.put("filter.licenseCopy", params.filter.licenseCopy)
        }

        if (params.filter?.ptcCopy && params.filter?.ptcCopy != Integer.MIN_VALUE.toString()) {
            whereSql += " AND driver.ptcCopy=:ptcCopy"
            namedParams.put("ptcCopy", params.filter.ptcCopy)
            sortableParams.put("filter.ptcCopy", params.filter.ptcCopy)
        }

        if (params.filter?.employeeCode && params.filter?.employeeCode != Integer.MIN_VALUE.toString()) {
            whereSql += " AND driver.employeeCode=:employeeCode"
            namedParams.put("employeeCode", params.filter.employeeCode)
            sortableParams.put("filter.employeeCode", params.filter.employeeCode)
        }

        if (params.filter?.idNumber && params.filter?.idNumber != Integer.MIN_VALUE.toString()) {
            whereSql += " AND driver.idNumber=:idNumber"
            namedParams.put("idNumber", params.filter.idNumber)
            sortableParams.put("filter.idNumber", params.filter.idNumber)
        }

        return whereSql
    }


    def applyCallbackParams(params, namedParams, sortableParams, whereSql) {

        // if list is shown to associate or deassociate objects,
        // the filter must show only not already associated objects or only the associated objects
        if (params.callback && params.callback != "") {
            def notOperator = ""
            def neOperator = "="
            if (params.callback == "link") {
                notOperator = "not"
                neOperator = "<>"
            }

            def rd = params.refDest
            // restrict list only if not unidirectional
            if (rd && rd != "") {
                if (java.util.Set.isAssignableFrom(org.codehaus.groovy.grails.commons.GrailsClassUtils.getPropertyType(Driver.class, rd))) {
                    // n:m
                    whereSql += " AND :xxx " + notOperator + " in elements(driver.${rd})"
                    namedParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
                    sortableParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
                } else {
                    // 1:n
                    whereSql += " AND driver.${rd} " + neOperator + " :xxx"
                    namedParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
                    sortableParams.put("xxx", grailsApplication.getClassForName(params.class).getComposite(params.source_id))
                }
            }
        }
        return whereSql
    }


    def applySortCriterias(params) {

        // now start with sorting criterias...
        String sql = ""
        if (params.sort) {
            def sortProperties = params.sort.split(",")

            for (String p: sortProperties) {
                p = p.trim()
                sql += p + " " + (params.order ? params.order : "") + ", "
            }

            // ...and finally add the order by
            if (sql.length() > 1) {
                sql = " order by " + sql.substring(0, sql.length() - 2)
            }
        }
        return sql
    }

}
