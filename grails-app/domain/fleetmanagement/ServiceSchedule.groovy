package fleetmanagement

class ServiceSchedule {

    Integer nextService
    Integer serviceInterval

	static constraints = {
        nextService(nullable: false)
        serviceInterval(nullable: true)
	}

	String toString() {
        if (nextService == null || nextService == 0){
            return "Undefined"
        }
		return "" + nextService + " " + nextService!=null?" km's":""
	}
	
}
