import org.apache.commons.lang.time.DateUtils
import fleetmanagement.*

class BootStrap {

    def springSecurityService
    def fixtureLoader

    def init = { servletContext ->

        def fixture = fixtureLoader.load("Branches")

        def driver = new Driver(branch: fixture.bloemBranch, licenseExpiryDate: DateUtils.addDays(new Date(),2),
                ptcExpiryDate: DateUtils.addDays(new Date(),2),
                firstName: "Abraham", surname: "Tjokwe", cellPhoneNumber: "0833452283", idNumber: "",
                active: true)
        validateAndSave(driver)

        def driver2 = new Driver(branch: fixture.bloemBranch, licenseExpiryDate: DateUtils.addDays(new Date(),2), ptcExpiryDate: DateUtils.addDays(new Date(),2),
                firstName: "Solomon", surname: "Baana", cellPhoneNumber: "0823452283", idNumber: "",
                active: true)
        validateAndSave(driver2)

        def serviceShedule = new ServiceSchedule(nextService: 60000, serviceInterval: 15000).save()

        def vehicle = new Vehicle(registrationNumber: "KLM345GP",make: "Isuzu", model: "KB200", year: "2004",
            branch: fixture.bloemBranch, serviceShedule: serviceShedule, driver: driver,
                licenseExpiryDate: DateUtils.addMonths(new Date(), 1), vinNumber: "1221344546546546")
        validateAndSave(vehicle)
        vehicle.addToOdoReadings(new OdoReading(distance: 55000, date: DateUtils.addMonths(new Date(), -2)))
        vehicle.addToOdoReadings(new OdoReading(distance: 57600, date: DateUtils.addMonths(new Date(), -1)))
        vehicle.addToOdoReadings(new OdoReading(distance: 59300, date: DateUtils.addWeeks(new Date(), -1)))
        validateAndSave(vehicle)

        initSecurity()
    }

    def destroy = {
    }

    private def initSecurity() {
        def userRole = Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(failOnError: true)
        def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(failOnError: true)

        def adminUser = User.findByUsername('admin') ?: new User(username: 'admin',
                password: springSecurityService.encodePassword('admin'),accountExpired: false,
                accountLocked: false,passwordExpired: false,enabled: true).save(failOnError: true)

        if (!adminUser.authorities.contains(adminRole)) {
            UserRole.create adminUser, adminRole
            UserRole.create adminUser, userRole
        }
    }

    def validateAndSave(def thingToSave) {
        if (!thingToSave.validate()) {
            println "Could not validate " + thingToSave.class.name
            thingToSave.errors.each() { println it }
            return false;
        }

        if (!thingToSave.save(flush: true)) {
            println "Failed to save " + thingToSave.class.name
            return false;
        }

        return true;
    }
}
