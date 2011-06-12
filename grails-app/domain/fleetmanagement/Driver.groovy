package fleetmanagement

class Driver extends Employee implements Comparable {
	
	static transients = ['compositeId']
    Date licenseExpiryDate
    byte[] licenseCopy
    Date ptcExpiryDate
    byte[] ptcCopy
    boolean active = true

    static constraints = {
        licenseExpiryDate(nullable:false)
        ptcExpiryDate(nullable:false)
        licenseCopy(nullable: true)
        ptcCopy(nullable: true)
		id(display:false, attributes:[listable:false])
		active(display:false, attributes:[listable:false])
	}
	
	static Driver getComposite(String compositeId) {
		// change this only, if your domain class has a composite key
		return Driver.get(compositeId)
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
