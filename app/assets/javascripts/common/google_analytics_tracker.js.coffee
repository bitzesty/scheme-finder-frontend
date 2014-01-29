class sff.GoogleAnalyticsTracker
  @track_clicked_links: (context = "body",
                         data_attribute = "ga_track_link",
                         send_event_function = @track_outbound_link
  ) =>
    $(context).on "click", @finder_by_data_attribute(data_attribute), (e) =>
      e.preventDefault()
      send_event_function(e)

      @follow_the_link $(e.target)

  @finder_by_data_attribute: (attribute) =>
    "*[data-#{attribute.replace(/\_/g, "-")}='true']"

  @follow_the_link: ($link) =>
    # from https://support.google.com/analytics/answer/1136920?hl=en
    # need small delay for google analytics to get sent
    setTimeout(
      ->
        if href = $link.attr("href")
          # it's a link
          document.location.href = href
        else
          # it's a form
          $link.closest("form").submit()
      , 100)


  @track_outbound_link: (e) =>
    $link = $(e.target)
    category = "Link clicked"
    action = $link.attr("href")
    @send_event(category, action)

  @send_event: (category, action) =>
    try
      ga("send", "event", category, action)
