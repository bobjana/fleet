package fleetmanagement

class Supervisor extends Employee{

    String email

    static hasMany = [ vehicles : Vehicle ]

    static constraints = {
        email(email:true)
	}
}
