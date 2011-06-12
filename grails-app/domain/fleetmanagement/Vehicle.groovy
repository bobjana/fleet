package fleetmanagement

class Vehicle implements Comparable {

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

    static transients = ['compositeId']

    static hasMany = [odoReadings: OdoReading, reminders: Reminder]

//    static hasMany = [ driverHistories : DriverHistory ]

    static constraints = {
        registrationNumber(blank: false, unique: true)
        make(size: 5..50, blank: false)
        model(size: 5..50, blank: false)
        year(size: 5..4, blank: false)
        branch(nullable: false)
        serviceSchedule(nullable: true)
        id(display: false, attributes: [listable: false]) // do not show id anywhere
    }

    static Vehicle getComposite(String compositeId) {
        // change this only, if your domain class has a composite key
        return Vehicle.get(compositeId)
    }

    public String getCompositeId() {
        // change this only, if your domain class has a composite key
        return this.id
    }

    public void deleteAndClearReferences() {
        // and finally do what we really want
        this.delete(flush: true)
    }

    public int compareTo(Object o) {
        return (id.compareTo(o.id))
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

//    def assignDriver(Driver driver, Date effectiveFrom){
//        DriverHistory history = new DriverHistory()
//        history.effectiveFrom = effectiveFrom;
////        DriverHistory currentHistory = getCurrentDriverHistory()
////        if (currentHistory != null){
////            currentHistory.effectiveTo = DateUtils.addDays(effectiveFrom, -1)
////        }
//        driverHistories.add(history)
//    }

//    def getCurrentDriverHistory(){
//        if (driverHistories == null || driverHistories.size() == 0){
//            return null
//        }
//        Collections.sort(driverHistories, new Comparator<DriverHistory>(){
//            int compare(DriverHistory o1, DriverHistory o2) {
//                return o1.effectiveFrom.compareTo(o2.effectiveFrom)
//            }
//
//        });
//    }


}
