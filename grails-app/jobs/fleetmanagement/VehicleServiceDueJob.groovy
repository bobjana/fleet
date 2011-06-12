package fleetmanagement

import fleetmanagement.Reminder.SeverityType


class VehicleServiceDueJob {

    def vehicleService

    static triggers = {
        simple name: 'vehicleServiceDueTrigger', startDelay: 60000, repeatInterval: 10000
    }

    def group = "Default"

    def execute() {
        def vehicles = vehicleService.listAllVehiclesDueForService(1000)
        for (vehicle in vehicles){
            System.err.println(vehicle.registrationNumber + "  " + vehicle.hasActiveReminder(ReminderType.VEHICLE_LICENSE_DUE));

            if (!vehicle.hasActiveReminder(ReminderType.VEHICLE_LICENSE_DUE)){
                vehicle.addToReminders(new Reminder(type: ReminderType.VEHICLE_LICENSE_DUE,
                    message: "Service due in less than 1000Km", severity: SeverityType.MEDIUM))
                vehicle.save()
                log.debug("Created a service due reminder for vehicle - " + vehicle)
            }
        }
    }
}
