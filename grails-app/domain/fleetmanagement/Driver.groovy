package fleetmanagement

class Driver extends Employee{
	
    Date licenseExpiryDate
    byte[] licenseCopy
    Date ptcExpiryDate
    byte[] ptcCopy
    boolean active = true

    static constraints = {
        licenseExpiryDate(nullable:false)
        ptcExpiryDate(nullable:false)
        licenseCopy(nullable: true)
        ptcCopy(nullable: true)
	}
	
	String toString() {
		return firstName + " " + surname;
	}
	
}
