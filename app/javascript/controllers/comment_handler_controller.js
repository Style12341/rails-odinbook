import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="comment-handler"
export default class extends Controller {
  static targets = ["open", "close", "frame", "counter", "commentSection"];
  connect() {}
  toggle() {
    this.openTarget.classList.toggle("hidden");
    this.closeTarget.classList.toggle("hidden");
  }

  hideCommentSection(event) {
    event.preventDefault();
    this.commentSectionTarget.innerHTML = "";
  }
  async addComment(event) {
    const id = this.frameTarget.id;
    event.preventDefault();
    const form = event.target.form;
    // Perform form submission via AJAX or Turbo
    // Assuming you're using Turbo, you might have something like:
    try {
      const response = await fetch(form.action, {
        method: "POST",
        body: new FormData(form),
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "Turbo-Frame": id, // Assuming your Turbo frame has an ID of "comments-frame"
          Accept: "text/vnd.turbo-stream.html", // Specify the Turbo Stream format
        },
      });

      if (response.ok) {
        const html = await response.text();
        const frame = this.frameTarget;
        frame.innerHTML = html;
        this.counterTarget.innerHTML = parseInt(this.counterTarget.innerText) + 1;
      } else {
        console.error("Failed to submit form");
      }
    } catch (error) {
      console.error("Error:", error);
    }
  }
  removeComment() {
    this.counterTarget.innerHTML = parseInt(this.counterTarget.innerText) - 1;
  }
}
