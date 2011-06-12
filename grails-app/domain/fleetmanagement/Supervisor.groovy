package fleetmanagement

class Supervisor extends Employee implements Comparable {

    String email

	static transients = ['compositeId']

    static hasMany = [ vehicles : Vehicle ]

    static constraints = {
        email(email:true)
		id(display:false, attributes:[listable:false]) // do not show id anywhere
	}
	
	static Supervisor getComposite(String compositeId) {
		// change this only, if your domain class has a composite key
		return Supervisor.get(compositeId)
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
		return firstName + " " + surname;
	}
	
}
