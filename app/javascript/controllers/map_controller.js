import { Controller } from "@hotwired/stimulus"
import ol from "openlayers"

// location-dot icon by Free Icons (https://free-icons.github.io/free-icons/)
const mapPin = `
<svg xmlns="http://www.w3.org/2000/svg" fill="white" height="1em" viewBox="0 0 512 512">
  <path d="M 256 512 Q 258 511 286 478 L 286 478 L 286 478 Q 315 445 352 394 L 352 394 L 352 394 Q 390 343 418 289 L 418 289 L 418 289 Q 447 235 448 192 Q 446 110 392 56 Q 338 2 256 0 Q 174 2 120 56 Q 66 110 64 192 Q 66 235 94 289 Q 123 343 160 394 Q 198 445 226 478 Q 255 511 256 512 L 256 512 Z M 256 128 Q 292 129 311 160 Q 329 192 311 224 Q 292 255 256 256 Q 220 255 201 224 Q 183 192 201 160 Q 220 129 256 128 L 256 128 Z" />
</svg>
`

export default class extends Controller {
  static targets = ["map"]
  static values = {
    center: Object
  }
  #map

  connect() {
    const centerProj = ol.proj.transform([this.centerValue.lon, this.centerValue.lat], 'EPSG:4326', 'EPSG:3857')
    const feature = new ol.Feature(new ol.geom.Point(centerProj));
    const pinLayer = new ol.layer.Vector({
      source: new ol.source.Vector({
        features: [feature]
      }),
      style: new ol.style.Style({
        image: new ol.style.Icon({
          opacity: 1,
          src: 'data:image/svg+xml;utf8,' + encodeURIComponent(mapPin),
          scale: 1.5,
          color: ol.color.asString("#ec453f")
        })
      })
    });
    window.map = this.map = this.map = new ol.Map({
      target: this.mapTarget,
      layers: [
        new ol.layer.Tile({
          source: new ol.source.OSM()
        }),
        pinLayer,
      ],
      view: new ol.View({
        center: centerProj,
        zoom: 16
      })
    });
  }
}
