import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'

import "../js/custom"
import "../js/footer"

// import "jquery";
require('jquery')
require("bootstrap")
import "popper.js";

import "@fortawesome/fontawesome-free/css/all"
import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()