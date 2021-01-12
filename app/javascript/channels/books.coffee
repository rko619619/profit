$(document).on "turbolinks:load", ->
  if $('.pagination').length > 0
    $(window).data('ajaxready', true).on 'scroll', ->
      if $(window).data('ajaxready') == false
        return

    more_books_url = $('.pagination a.next_page').attr('href')
    if more_books_url && $(window).scrollTop() + $(window).height() == $(document).height()
      $('#books').append('<div class="spinner"><img src="/images/ajax-loader.gif" alt="Loading..." title="Loading..." /></div>')
      $(window).data('ajaxready', false)
      $.getScript more_books_url