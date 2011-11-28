package fleetmanagement

import org.apache.commons.lang.time.DateUtils

class Driver extends Employee{
	
    Date licenseExpiryDate
    byte[] licenseCopy
    Date ptcExpiryDate
    byte[] ptcCopy
    boolean active = true

    static constraints = {
        licenseExpiryDate(nullable:false,  validator: { val, obj ->
			val.before(DateUtils.addDays(new Date(),1)) ? 'error.driver.expiry.date.in.past' : true
		})
        ptcExpiryDate(nullable:false)
        licenseCopy(nullable: true)
        ptcCopy(nullable: true)
	}
	
	String toString() {
		return firstName + " " + surname;
	}
	
}
