// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery

//= require rails-ujs
//= require growlyflash
//= require twitter/bootstrap
//= require turbolinks
//= require jquery-ui
//= require trix
//= require lookups
//= require notifications
//= require dropzone
//= require subscriptions
//= require_tree .


Growlyflash.defaults = $.extend(true, Growlyflash.defaults, {
  align:   'left',  // horizontal aligning (left, right or center)
  delay:   3000,     // auto-dismiss timeout (0 to disable auto-dismiss)
  dismiss: true,      // allow to show close button
  spacing: 5,       // spacing between alerts
  target:  'html',   // selector to target element where to place alerts
  title:   false,       // switch for adding a title
  type:    "success ",     // bootstrap alert class by default
  class:   ['alert', 'growlyflash', 'fade']
});

window.sweetAlertConfirmConfig = {
  title: 'Are you sure?',
  type: 'info',
  showCancelButton: true,
  confirmButtonColor: '#DD6B55',
  confirmButtonText: 'yes I am',
  cancelButtonText: "cancel"
};
//= require serviceworker-companion
