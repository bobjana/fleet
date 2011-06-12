package fleetmanagement

class VehicleService {

    static transactional = true

    def List<Vehicle> listAllVehiclesDueForService(int dueWithinKM) {
        def result = new ArrayList()
        def vehicles = Vehicle.findAll()
        for (vehicle in vehicles){
            int serviceDue = vehicle.serviceDue()
            if (serviceDue > 0 && serviceDue <= dueWithinKM){
                result.add(vehicle)
            }
        }
        return result
    }
}
