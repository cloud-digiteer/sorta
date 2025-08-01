import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

export default class extends Controller {
  connect() {
    this.modalelement = document.getElementById("addFileModal")    
    this.modal = bootstrap.Modal.getOrCreateInstance(this.modalelement)
  }

  handleSubmit(event) {
    console.log("Submit end triggered")
    console.log("Success?", event.detail.success)
    if (event.detail.success) {
      this.modal.hide()
    }
  }
}
