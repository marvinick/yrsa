
var app = window.app = {};

app.Lookups = function() {
  this._input = $('#books-search-txt');
  this._initAutocomplete();
};

app.Lookups.prototype = {
  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: '/lookups',
        appendTo: '#books-search-results',
        select: $.proxy(this._select, this)
      })
      .autocomplete('instance')._renderItem = $.proxy(this._render, this);
  },

  _render: function(ul, item) {
    var markup = [

      '<span class="title">' + item.title + '</span>',
      '<span class="author">' + item.description + '</span>',
      '<span class="price">' + item.updated_at + '</span>'
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  },

  _select: function(e, ui) {
    this._input.val(ui.item.title);
    return false;
  }
};
