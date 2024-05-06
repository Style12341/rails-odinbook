import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="alter-button-counter"
export default class extends Controller {
  static targets = ["counter", "state"];
  connect() {}
  toggle() {
    console.log(this.stateTarget);
    if (this.stateTarget.classList.contains("on")) {
      this.counterTarget.innerText = parseInt(this.counterTarget.innerText) - 1;
      this.stateTarget.classList.remove("on");
    } else {
      this.counterTarget.innerText = parseInt(this.counterTarget.innerText) + 1;
      this.stateTarget.classList.add("on");
    }
  }
}
