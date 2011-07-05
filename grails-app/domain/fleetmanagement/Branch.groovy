package fleetmanagement

class Branch{

    String name

    static constraints = {
        name(size:5..15, blank:false, unique:true)
	}
	
	String toString() {
		return name;
	}
	
}
