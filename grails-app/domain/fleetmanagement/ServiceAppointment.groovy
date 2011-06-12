package fleetmanagement

class ServiceAppointment implements Comparable {
	
	static transients = ['compositeId']

    Vehicle vehicle
    Date date

	static constraints = {
		id(display:false, attributes:[listable:false]) // do not show id anywhere
	    vehicle(nullable: false)
    }
	
	static ServiceAppointment getComposite(String compositeId) {
		// change this only, if your domain class has a composite key
		return ServiceAppointment.get(compositeId)
	}
	
	public String getCompositeId() {
		// change this only, if your domain class has a composite key
		return this.id
	}
	
	public void deleteAndClearReferences() {
		
		// OPTIONAL TODO: add code if needed, to break references before deletion	
		
		// and finally do what we really want
		this.delete(flush:true)
	}
	
	public int compareTo(Object o) {
		
		// TODO: change id to fitting order property
		return (id.compareTo(o.id))
	}
	
	String toString() {
		
		// TODO: change id to human readable identity string
		// this output will be used in many places as a default
		// so it should really be a little bit more than just the id
		return id;
	}
	
}
