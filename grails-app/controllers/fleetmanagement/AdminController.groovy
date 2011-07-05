package fleetmanagement

class AdminController {

    static navigation = [
		group:'tabs',
		order:5,
		title:'Admin'
	]

    def index = { }

    def branch = {
        redirect(controller: "branch", action: "index")
    }

    def supervisor = {
        redirect(controller: "supervisor", action: "index")
    }
}
