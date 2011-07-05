package fleetmanagement

class SupervisorController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [supervisorInstanceList: Supervisor.list(params), supervisorInstanceTotal: Supervisor.count()]
    }

    def create = {
        def supervisorInstance = new Supervisor()
        supervisorInstance.properties = params
        return [supervisorInstance: supervisorInstance]
    }

    def save = {
        def supervisorInstance = new Supervisor(params)
        if (supervisorInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), supervisorInstance.id])}"
            redirect(action: "show", id: supervisorInstance.id)
        }
        else {
            render(view: "create", model: [supervisorInstance: supervisorInstance])
        }
    }

    def show = {
        def supervisorInstance = Supervisor.get(params.id)
        if (!supervisorInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), params.id])}"
            redirect(action: "list")
        }
        else {
            [supervisorInstance: supervisorInstance]
        }
    }

    def edit = {
        def supervisorInstance = Supervisor.get(params.id)
        if (!supervisorInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [supervisorInstance: supervisorInstance]
        }
    }

    def update = {
        def supervisorInstance = Supervisor.get(params.id)
        if (supervisorInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (supervisorInstance.version > version) {
                    
                    supervisorInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'supervisor.label', default: 'Supervisor')] as Object[], "Another user has updated this Supervisor while you were editing")
                    render(view: "edit", model: [supervisorInstance: supervisorInstance])
                    return
                }
            }
            supervisorInstance.properties = params
            if (!supervisorInstance.hasErrors() && supervisorInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), supervisorInstance.id])}"
                redirect(action: "show", id: supervisorInstance.id)
            }
            else {
                render(view: "edit", model: [supervisorInstance: supervisorInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def supervisorInstance = Supervisor.get(params.id)
        if (supervisorInstance) {
            try {
                supervisorInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supervisor.label', default: 'Supervisor'), params.id])}"
            redirect(action: "list")
        }
    }
}
