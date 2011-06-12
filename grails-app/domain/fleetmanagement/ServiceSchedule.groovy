package fleetmanagement

class ServiceSchedule implements Comparable {

    Integer nextService
    Integer serviceInterval
	
	static transients = ['compositeId']
	
	static constraints = {
		id(display:false, attributes:[listable:false]) // do not show id anywhere
        nextService(nullable: false)
        serviceInterval(nullable: true)
	}
	
	static ServiceSchedule getComposite(String compositeId) {
		return ServiceSchedule.get(compositeId)
	}
	
	public String getCompositeId() {
		return this.id
	}
	
	public void deleteAndClearReferences() {
		// OPTIONAL TODO: add code if needed, to break references before deletion
		
		// and finally do what we really want
		this.delete(flush:true)
	}
	
	public int compareTo(Object o) {
		return (id.compareTo(o.id))
	}
	
	String toString() {
		return "" + nextService + " " + nextService!=null?" km's":""
//            " " + serviceInterval>0?"(every " + serviceInterval.toString() + " km's)":"";
	}
	
}
