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

// routes-js
import routes from '../routes'
global.routes = routes

// jQuery
import $ from 'jquery';
global.$ = jQuery;

// Flatpickr
import flatpickr from "flatpickr"
require("flatpickr/dist/flatpickr.css")

// Actiontext/trix
require("trix")
require("@rails/actiontext")
import "./trix_editor_overrides"

document.addEventListener("turbolinks:load", () => {
	// Activates all tooltips
  $('[data-toggle="tooltip"]').tooltip()
})