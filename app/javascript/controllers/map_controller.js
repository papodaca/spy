import { Controller } from "@hotwired/stimulus"
import L from "leaflet"

export default class extends Controller {
  #mapEl;
  #map;

  connect() {
    this.mapEl = this.element.querySelectorAll(".map")[0]
    this.map = L.map(this.mapEl).setView([51.505, -0.09], 13)
  }
}
