import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="turbo-stream-get"
export default class extends Controller {
  static targets = ["frame"];
  connect() {}
  async fetch(event) {
    event.preventDefault();
    const id = this.frameTarget.id;
    const form = event.target.form;

    try {
      const response = await fetch(form.action, {
        method: "GET",
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "Turbo-Frame": id,
          Accept: "text/vnd.turbo-stream.html",
        },
      });

      if (!response.ok) {
        throw new Error("Network response was not ok");
      }

      const html = await response.text();
      this.frameTarget.innerHTML = html;
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }
}
