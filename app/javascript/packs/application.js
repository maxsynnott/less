// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// Self-added below:
import "./stimulus"
import '../stylesheets/application'
// Previously import "@fortawesome/fontawesome-free/js/all";
// Changing prevented from converting <i>s to <svg>s which was needed for tooltip reasons
import "@fortawesome/fontawesome-free/css/all.css";
import './bootstrap_custom.js'
import 'cocoon-js';

// Swiper.js
import Swiper from 'swiper';
global.Swiper = Swiper

// Algolia places
import places from "places.js"
global.places = places

// routes-js
import routes from '../routes'
global.routes = routes

// jQuery
import $ from 'jquery';
global.$ = jQuery;

// Flatpickr
import flatpickr from "flatpickr"
require("flatpickr/dist/flatpickr.css")

// Mapbox
import mapboxgl from 'mapbox-gl';
global.mapboxgl = mapboxgl

// Select2
import Select2 from 'select2';
global.Select2 = Select2

// Actiontext/trix
require("trix")
require("@rails/actiontext")
import "./trix_editor_overrides"

document.addEventListener("turbolinks:load", () => {
	// Activates all tooltips
  $('[data-toggle="tooltip"]').tooltip()
})

document.addEventListener('turbolinks:before-cache', () => {
  // Prevent's modals being stuck open on back button
  // https://www.honeybadger.io/blog/turbolinks/
  if (document.body.classList.contains('modal-open')) {
    $('.modal')
      .hide()
      .removeAttr('aria-modal')
      .attr('aria-hidden', 'true');
    $('.modal-backdrop').remove();
    $('body').removeClass('modal-open');
  }

  // Prevents select2 duplication on back button
  $('.select2-input').select2('destroy');
  $('.select2-container').remove();
});