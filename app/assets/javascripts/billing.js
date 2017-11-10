$(document).ready(function () {
  var handler = StripeCheckout.configure({
    key: 'pk_test_tAEnFwxD4zPf5HKhTHfb17dC',
    image: 'https://stripe.com/img/documentation/checkout/marketplace.png',
    locale: 'auto',
    token: function(token) {
      $('form').append("<input type='hidden' name='token' value='" + token.id + "' />")
      $('form').submit();
    }
  });

  $('#payment-btn').on('click', function(e) {
    handler.open({
      name: 'Twist Books',
      currency: "aud",
      email: $('#email').val(),
      panelLabel: "Update payment details"
    });
    e.preventDefault();
  });

  // Close Checkout on page navigation
  $(window).on('popstate', function() {
    handler.close();
  });
});
