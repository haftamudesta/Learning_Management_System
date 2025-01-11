import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  toggle() {
    const mobileLinks=document.getElementById('mobile_links')
    const barsEl=document.getElementById('bars')
    const closeEl=document.getElementById('close')
    console.log(closeEl)
    console.log(barsEl)
    mobile_links.classList.toggle('hidden')
    barsEl.classList.toggle('hidden')
    closeEl.classList.toggle('hidden')
  }
}
