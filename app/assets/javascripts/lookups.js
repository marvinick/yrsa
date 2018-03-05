jQuery(document).on('turbolinks:load', function() {
  return $('#to').select2({
    ajax: {
      url: '/lookups',
      data: function(params) {
        return {
          term: params.term
        };
      },
      dataType: 'json',
      delay: 500,
      processResults: function(data, params) {
        return {
          results: _.map(data, function(el) {
            return {
              id: el.id,
              name: el.title + ", " + el.description
            };
          })
        };
      },
      cache: true
    },
    escapeMarkup: function(markup) {
      return markup;
    },
    minimumInputLength: 2,
    templateResult: function(item) {
      return item.title;
    },
    templateSelection: function(item) {
      return item.title;
    }
  });
});
