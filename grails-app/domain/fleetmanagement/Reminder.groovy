package fleetmanagement

class Reminder {
	
    enum SeverityType {
        LOW, MEDIUM, HIGH
    }

    boolean active = true
    String message
    String code
    SeverityType severity = SeverityType.LOW
    ReminderType type

	static constraints = {
        message(nullable: false)
	}

	String toString() {
		return code;
	}
	
}
