import fleetmanagement.Branch
import fleetmanagement.Driver
import fleetmanagement.Vehicle
import fleetmanagement.OdoReading
import org.apache.commons.lang.time.DateUtils
import fleetmanagement.ServiceSchedule;

class BootStrap {

    def init = { servletContext ->

        def bloemBranch = new Branch(name: "Bloemfontein").save()
        new Branch(name: "Cape Town").save()
        new Branch(name: "Ellisras").save()
        new Branch(name: "Klerksdorp").save()
        new Branch(name: "Middelburg").save()
        new Branch(name: "Rustenburg").save()
        new Branch(name: "Secunda").save()
        new Branch(name: "Steelpoort").save()
        new Branch(name: "Wadeville").save()
        new Branch(name: "Welkom").save()


        def driver = new Driver(branch: bloemBranch, licenseExpiryDate: new Date(), ptcExpiryDate: new Date(),
                firstName: "Abraham", surname: "Tjokwe", cellPhoneNumber: "0833452283", idNumber: "", employeeCode: "",
                active: true)
        validateAndSave(driver)

        def serviceShedule = new ServiceSchedule(nextService: 60000, serviceInterval: 15000).save()

        def vehicle = new Vehicle(registrationNumber: "KLM345GP",make: "Isuzu", model: "KB200", year: "2004",
            branch: bloemBranch, serviceShedule: serviceShedule, driver: driver,
                licenseExpiryDate: DateUtils.addMonths(new Date(), 1), vinNumber: "1221344546546546")
        validateAndSave(vehicle)
        vehicle.addToOdoReadings(new OdoReading(distance: 55000, date: DateUtils.addMonths(new Date(), -2)))
        vehicle.addToOdoReadings(new OdoReading(distance: 57600, date: DateUtils.addMonths(new Date(), -1)))
        vehicle.addToOdoReadings(new OdoReading(distance: 59300, date: DateUtils.addWeeks(new Date(), -1)))
        validateAndSave(vehicle)
    }
    def destroy = {
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
