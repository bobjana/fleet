package fleetmanagement

class BranchController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [branchInstanceList: Branch.list(params), branchInstanceTotal: Branch.count()]
    }

    def create = {
        def branchInstance = new Branch()
        branchInstance.properties = params
        return [branchInstance: branchInstance]
    }

    def save = {
        def branchInstance = new Branch(params)
        if (branchInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'branch.label', default: 'Branch'), branchInstance.id])}"
            redirect(action: "show", id: branchInstance.id)
        }
        else {
            render(view: "create", model: [branchInstance: branchInstance])
        }
    }

    def show = {
        def branchInstance = Branch.get(params.id)
        if (!branchInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])}"
            redirect(action: "list")
        }
        else {
            [branchInstance: branchInstance]
        }
    }

    def edit = {
        def branchInstance = Branch.get(params.id)
        if (!branchInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [branchInstance: branchInstance]
        }
    }

    def update = {
        def branchInstance = Branch.get(params.id)
        if (branchInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (branchInstance.version > version) {
                    
                    branchInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'branch.label', default: 'Branch')] as Object[], "Another user has updated this Branch while you were editing")
                    render(view: "edit", model: [branchInstance: branchInstance])
                    return
                }
            }
            branchInstance.properties = params
            if (!branchInstance.hasErrors() && branchInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'branch.label', default: 'Branch'), branchInstance.id])}"
                redirect(action: "show", id: branchInstance.id)
            }
            else {
                render(view: "edit", model: [branchInstance: branchInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def branchInstance = Branch.get(params.id)
        if (branchInstance) {
            try {
                branchInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'branch.label', default: 'Branch'), params.id])}"
            redirect(action: "list")
        }
    }
}
