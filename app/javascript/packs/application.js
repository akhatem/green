import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'

import "../js/custom"
import "../js/footer"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


require("bootstrap")
import "popper.js";
import "jquery";

import "../stylesheets/application";
import "@fortawesome/fontawesome-free/css/all"