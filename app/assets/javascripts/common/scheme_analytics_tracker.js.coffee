class sff.SchemeAnalyticsTracker extends sff.GoogleAnalyticsTracker
  @register_scheme_clicked: (e) =>
    $link = $(e.target)
    category = "Scheme clicked"
    action = $link.attr("href")
    @send_event(category, action)

    @register_tool_completed e

  @register_tool_completed: (e) =>
    category = "Tool completed"
    action = "Via scheme click"
    @send_event(category, action)

  @register_scheme_searched: =>
    category = "Schemes searched"
    action = "Via scheme search"
    @send_event(category, action)
