import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'


import "bootstrap";


import "../stylesheets/application";
import "@fortawesome/fontawesome-free/css/all"

import "../js/custom"

import "../js/add_fields"
import "../js/remove_fields"


Rails.start()
Turbolinks.start()
ActiveStorage.start()