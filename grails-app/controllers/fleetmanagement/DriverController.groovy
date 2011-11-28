package fleetmanagement

import org.apache.commons.io.FileUtils
import org.springframework.core.io.Resource
import org.apache.commons.lang.time.DateUtils

class DriverController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [driverInstanceList: Driver.list(params), driverInstanceTotal: Driver.count()]
    }

    def create = {
        def driverInstance = new Driver()
        driverInstance.properties = params
        return [driverInstance: driverInstance]
    }

    def save = {
        if (params.ptcExpiryDate){
            params.ptcExpiryDate = DateUtils.parseDate(params.ptcExpiryDate,"dd MMM yyyy")
        }
        if (params.licenseExpiryDate){
            params.licenseExpiryDate = DateUtils.parseDate(params.licenseExpiryDate,"dd MMM yyyy")
        }
        def driverInstance = new Driver(params)
        println driverInstance.ptcExpiryDate
        if (driverInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'driver.label', default: 'Driver'), driverInstance.id])}"
            redirect(action: "show", id: driverInstance.id)
        }
        else {
            render(view: "create", model: [driverInstance: driverInstance])
        }
    }

    def show = {
        def driverInstance = Driver.get(params.id)
        if (!driverInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
            redirect(action: "list")
        }
        else {
            [driverInstance: driverInstance]
        }
    }

    def edit = {
        def driverInstance = Driver.get(params.id)
        if (!driverInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [driverInstance: driverInstance]
        }
    }

    def update = {
        if (params.ptcExpiryDate){
            params.ptcExpiryDate = DateUtils.parseDate(params.ptcExpiryDate,"dd MMM yyyy")
        }
        if (params.licenseExpiryDate){
            params.licenseExpiryDate = DateUtils.parseDate(params.licenseExpiryDate,"dd MMM yyyy")
        }
        def driverInstance = Driver.get(params.id)
        if (driverInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (driverInstance.version > version) {

                    driverInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'driver.label', default: 'Driver')] as Object[], "Another user has updated this Driver while you were editing")
                    render(view: "edit", model: [driverInstance: driverInstance])
                    return
                }
            }
            driverInstance.properties = params
            if (!driverInstance.hasErrors() && driverInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'driver.label', default: 'Driver'), driverInstance.id])}"
                redirect(action: "show", id: driverInstance.id)
            }
            else {
                render(view: "edit", model: [driverInstance: driverInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def driverInstance = Driver.get(params.id)
        if (driverInstance) {
            try {
                driverInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'driver.label', default: 'Driver'), params.id])}"
            redirect(action: "list")
        }
    }

    def displayLicenseCopy = {
        def driverInstance = Driver.get(params.id)
        response.contentType = "image/png"
        byte[] image
        if (!driverInstance?.licenseCopy) {
            image = getBlankImage()
        }
        else {
            image = driverInstance?.licenseCopy
        }
        response.contentLength = image.length
        response.outputStream.write(image)
    }

    def displayPtcCopy = {
        def driverInstance = Driver.get(params.id)
        response.contentType = "image/png"
        byte[] image
        if (!driverInstance?.ptcCopy) {
            image = getBlankImage()
        }
        else {
            image = driverInstance?.ptcCopy
        }
        response.contentLength = image.length
        response.outputStream.write(image)
    }

    def uploadLicenseCopy = {
        println "UPLOADING>......."
        def driverInstance = Driver.get(params.id)
        driverInstance.licenseCopy = params.licenseCopy
        driverInstance.save()
        displayPtcCopy()
    }

    private byte[] getBlankImage() {
        Resource blankCopy = grailsApplication.mainContext.getResource("/images/blank_copy.png")
        def image = FileUtils.readFileToByteArray(blankCopy.getFile())
        return image
    }

}
