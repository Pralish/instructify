
import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static outlets = [ "offcanvas" ]
  createNode(event) {
    event.preventDefault();
    const customEvent = new CustomEvent('modalFormSubmitted', { detail: { event: event, offcanvasOutlet: this.offcanvasOutlet} });
    document.dispatchEvent(customEvent);
  }
}