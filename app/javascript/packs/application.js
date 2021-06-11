// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


require('jquery')

import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'

import "../js/custom"
import "../js/footer"

// import "../ckeditor/config"

document.addEventListener("turbolinks:load", () => {
    $('[data-toggle="tooltip"]').tooltip()
    $('[data-toggle="popover"]').popover()
  })

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// require("bootstrap")
import "jquery";
import "popper.js";
import "bootstrap";

import "@fortawesome/fontawesome-free/css/all"
import "../stylesheets/application";


// const { JSDOM } = require( "jsdom" );
// const { window } = new JSDOM( "" );
// const $ = require( "jquery" )( window );