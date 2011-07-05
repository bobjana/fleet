package fleetmanagement

class DriverController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [driverInstanceList: Driver.list(params), driverInstanceTotal: Driver.count()]
    }

    def create = {
        def driverInstance = new Driver()
        driverInstance.properties = params
        return [driverInstance: driverInstance]
    }

    def save = {
        def driverInstance = new Driver(params)
        if (driverInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'driver.label', default: 'Driver'), driverInstance.id])}"
            redirect(action: "show", id: driverInstance.id)
        }
        else {
            render(view: "create", model: [driverInstance: driverInstance])
        }
    }

    def show = {
        def driverInstance = Driver.get(params.id)
        if (!driverInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
            redirect(action: "list")
        }
        else {
            [driverInstance: driverInstance]
        }
    }

    def edit = {
        def driverInstance = Driver.get(params.id)
        if (!driverInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [driverInstance: driverInstance]
        }
    }

    def update = {
        def driverInstance = Driver.get(params.id)
        if (driverInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (driverInstance.version > version) {
                    
                    driverInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'driver.label', default: 'Driver')] as Object[], "Another user has updated this Driver while you were editing")
                    render(view: "edit", model: [driverInstance: driverInstance])
                    return
                }
            }
            driverInstance.properties = params
            if (!driverInstance.hasErrors() && driverInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'driver.label', default: 'Driver'), driverInstance.id])}"
                redirect(action: "show", id: driverInstance.id)
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
                driverInstance.delete(flush: true)
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
}
