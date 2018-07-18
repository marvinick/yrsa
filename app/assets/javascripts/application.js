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


//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require growlyflash
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


//dialog

function dialog() {

  // Declare variables
  var dialogBox = $('.dialog'),
  		dialogTrigger = $('.dialog__trigger'),
  		dialogClose = $('.dialog__close'),
  		dialogTitle = $('.dialog__title'),
  		dialogContent = $('.dialog__content'),
  		dialogAction = $('.dialog__action');

  // Open the dialog
  dialogTrigger.on('click', function(e) {
  	dialogBox.toggleClass('dialog--active');
  	e.stopPropagation();
  });

  // Close the dialog - click close button
  dialogClose.on('click', function() {
  	dialogBox.removeClass('dialog--active');
  });

  // Close the dialog - press escape key // key#27
  $(document).keyup(function(e) {
  	if (e.keyCode === 27) {
  		dialogBox.removeClass('dialog--active');
  	}
  });

  // Close the dialog - click outside
  $(document).on('click', function(e) {
  	if ($(e.target).is(dialogBox) === false &&
  			$(e.target).is(dialogTitle) === false &&
  			$(e.target).is(dialogContent) === false &&
  			$(e.target).is(dialogAction) === false) {
  		dialogBox.removeClass('dialog--active');
  	}
  });

}

// Run function
$(dialog);


//= require serviceworker-companion
