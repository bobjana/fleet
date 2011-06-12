package fleetmanagement

class Employee {

    String firstName
    String surname
    String idNumber
    String cellPhoneNumber
    String employeeCode
    Branch branch

    static constraints = {
        firstName(blank: false, size:3..50)
        surname(blank: false, size:3..50)
        branch(nullable:false)
//        idNumber(blank:false, unique:true)
        cellPhoneNumber(blank: false, unique: true)
    }
}
