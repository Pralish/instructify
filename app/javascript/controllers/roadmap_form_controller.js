
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static outlets = [ "modal" ]
  createNode(event) {
    event.preventDefault();
    const customEvent = new CustomEvent('modalFormSubmitted', { detail: { event: event, modalOutlet: this.modalOutlet} });
    document.dispatchEvent(customEvent);
  }
}