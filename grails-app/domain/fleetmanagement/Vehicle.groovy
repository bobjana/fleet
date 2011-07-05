package fleetmanagement

class Vehicle {

    String make
    String model
    String year
    String registrationNumber
    String vinNumber
    Date licenseExpiryDate
    boolean tracking
    Branch branch
    Driver driver
    ServiceSchedule serviceSchedule

    static embedded = ['serviceSchedule']

    static hasMany = [odoReadings: OdoReading, reminders: Reminder]

    static constraints = {
        registrationNumber(blank: false, unique: true)
        make(size: 5..50, blank: false)
        model(size: 5..50, blank: false)
        year(size: 5..4, blank: false)
        branch(nullable: false)
        serviceSchedule(nullable: true)
        driver(nullable: true)
    }

    String toString() {
        return registrationNumber;
    }

    def OdoReading latestOdoReading() {
        OdoReading result = new OdoReading(distance: 0, date: new Date())
        for (o in odoReadings) {
            if (o.distance > result.distance) {
                result = o
            }
        }
        return result
    }

    def boolean hasActiveReminder(ReminderType reminderType) {
        for (reminder in reminders) {
            if (reminder.type.equals(reminderType) && reminder.active) {
                return true
            }
        }
        return false
    }

    def listActiveReminders() {
        def result = new ArrayList()
        for (reminder in reminders) {
            if (reminder.active()) {
                result.add(reminder)
            }
        }
        return result
    }

    def int serviceDue() {
        if (serviceSchedule == null) {
            log.info("Service schedule not defined for vehicle - " + toString() + " Unable to determine service due")
            return 100000
        }
        int nextService = serviceSchedule.nextService
        int latestOdoReading = latestOdoReading().distance
        return nextService - latestOdoReading
    }

}
