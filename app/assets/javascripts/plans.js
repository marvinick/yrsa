$(document).ready(function () {
  if (typeof(StripeCheckout) == 'undefined') { return }

  var handler = StripeCheckout.configure({
    key: 'pk_test_tAEnFwxD4zPf5HKhTHfb17dC',
    locale: 'auto',
    token: function(token) {
      $('form').append("<input type="hidden" name="token" value='" + token.id + "' /\>")
      $('form').submit();
    }
  });

  $('#checkout-btn').on('click', function(e) {
    selectedPlan = $(e.target).siblings('input:checked');
    handler.open({
      name: 'Yrsa',
      description: selectedPlan.data('name') + ' Plan',
      description: 'Oleole',
      currency: 'usd',
      amount: selectedPlan.data('amount')
    });
    e.preventDefault();
  });

  //close window on page navigation
  $(window).on('popstate', function() {
    handler.close();
  });
});
