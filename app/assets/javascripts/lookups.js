var app = window.app = {};

app.Lookups = function() {
  this._input = $('#lookups-search-txt');
  this._initAutocomplete();
};

app.lookups.prototype = {
  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: '/lookups',
        appendTo: '#lookups-search-results',
        select: $.proxy(this._select, this)
      })
      .autocomplete('instance')._renderItem = $.proxy(this._render, this);
  },

  _render: function(ul, item) {
    var markup = [
      '<span class="title">' +  pg_search_document.searchable.title + '</span>',
      '<span class="title">' +  pg_search_document.searchable.name + '</span>'
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  },

  _select: function(e, ui) {
    this._input.val(ui.pg_search_document.searchable.title);
    return false;
  }
};
