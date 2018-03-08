
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

      '<span class="title">' + item.name + '</a></span>',
      '<span class="title">' + item.content + '</a></span>',
      '<span class="title">' + item.title + '</a></span>',
      '<span class="title">' + item.description + '</a></span>',

    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  },

  _select: function(e, ui) {
    this._input.val(ui.item.name);
    return false;
  }
};
