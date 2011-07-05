package fleetmanagement

class ServiceAppointment{
	
    Vehicle vehicle
    Date date

	static constraints = {
	    vehicle(nullable: false)
    }

}
