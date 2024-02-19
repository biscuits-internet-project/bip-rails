import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    if (localStorage.getItem("darkMode") === "true") {
      document.body.classList.add("dark");
    }
  }

  toggle() {
    document.body.classList.toggle("dark");
    localStorage.setItem("darkMode", document.body.classList.contains("dark"));
  }
}
