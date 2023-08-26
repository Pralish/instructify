import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="themes"
export default class extends Controller {
  static targets = [ "input", "icon" ];

  connect() {
    this.initTheme();
  }

  initTheme() {
    const darkThemeSelected = localStorage.getItem("theme") === "dark";
    this.inputTarget.checked = darkThemeSelected;
    this.switchTheme();
  }

  switchTheme() {
    if (this.inputTarget.checked) {
      this.iconTarget.classList.remove("bi-moon-stars")
      this.iconTarget.classList.add("bi-brightness-high")
      localStorage.setItem("theme", "dark")
      document.body.setAttribute("data-theme", "dark")
    } else {
      this.iconTarget.classList.remove("bi-brightness-high")
      this.iconTarget.classList.add("bi-moon-stars")
      localStorage.setItem("theme", "light")
      document.body.setAttribute("data-theme", "light")
    }
  }
}
