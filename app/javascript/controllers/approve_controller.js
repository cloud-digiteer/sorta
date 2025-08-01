import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { id: Number }

  approveRow(event) {
    event.preventDefault();
    fetch(`/file_records/${this.idValue}/toggle_status`, {
      method: "PATCH",
      headers: {
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      }
    })
  }
}
