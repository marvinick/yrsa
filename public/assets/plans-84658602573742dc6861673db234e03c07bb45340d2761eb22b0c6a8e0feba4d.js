$(document).ready(function(){if("undefined"!=typeof StripeCheckout){var e=StripeCheckout.configure({key:"pk_test_tAEnFwxD4zPf5HKhTHfb17dC",locale:"auto",token:function(e){$("form").append("<input type='hidden' name='token' value='"+e.id+"' / >"),$("form").submit()}});$("#checkout-btn").on("click",function(n){selectedPlan=$(n.target).siblings("input:checked"),e.open({name:"Yrsa",description:selectedPlan.data("name")+" Plan",description:"Oleole",currency:"usd",amount:selectedPlan.data("amount")}),n.preventDefault()}),$(window).on("popstate",function(){e.close()})}});