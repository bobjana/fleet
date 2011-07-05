package fleetmanagement

class VehicleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [vehicleInstanceList: Vehicle.list(params), vehicleInstanceTotal: Vehicle.count()]
    }

    def create = {
        def vehicleInstance = new Vehicle()
        vehicleInstance.properties = params
        return [vehicleInstance: vehicleInstance]
    }

    def save = {
        def vehicleInstance = new Vehicle(params)
        if (vehicleInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), vehicleInstance.id])}"
            redirect(action: "show", id: vehicleInstance.id)
        }
        else {
            render(view: "create", model: [vehicleInstance: vehicleInstance])
        }
    }

    def show = {
        def vehicleInstance = Vehicle.get(params.id)
        if (!vehicleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), params.id])}"
            redirect(action: "list")
        }
        else {
            [vehicleInstance: vehicleInstance]
        }
    }

    def edit = {
        def vehicleInstance = Vehicle.get(params.id)
        if (!vehicleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [vehicleInstance: vehicleInstance]
        }
    }

    def update = {
        def vehicleInstance = Vehicle.get(params.id)
        if (vehicleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (vehicleInstance.version > version) {
                    
                    vehicleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'vehicle.label', default: 'Vehicle')] as Object[], "Another user has updated this Vehicle while you were editing")
                    render(view: "edit", model: [vehicleInstance: vehicleInstance])
                    return
                }
            }
            vehicleInstance.properties = params
            if (!vehicleInstance.hasErrors() && vehicleInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), vehicleInstance.id])}"
                redirect(action: "show", id: vehicleInstance.id)
            }
            else {
                render(view: "edit", model: [vehicleInstance: vehicleInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def vehicleInstance = Vehicle.get(params.id)
        if (vehicleInstance) {
            try {
                vehicleInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vehicle.label', default: 'Vehicle'), params.id])}"
            redirect(action: "list")
        }
    }
}
