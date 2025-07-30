import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

export default class extends Controller {

  connect() {
    this.modalTarget = document.querySelector('#addFileModal')
    if (!this.modalTarget) {
      console.error("Missing target element 'modal' for 'add-modal' controller")
      return
    }

    this.bsModal = new bootstrap.Modal(this.modalTarget, { keyboard: false })
  }

  open(event) {
    event.preventDefault()
    if (this.bsModal) {
      this.bsModal.show()
    } else {
      console.error("Bootstrap modal instance not initialized")
    }
  }
}
