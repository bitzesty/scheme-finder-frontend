class sff.SchemeAnalyticsTracker extends sff.GoogleAnalyticsTracker
  @register_scheme_clicked: (e) =>
    $link = $(e.target)
    category = "Scheme clicked"
    action = "#{@agent_with_audience()} #{$link.attr('href')}"
    @send_event(category, action)

    @register_tool_completed e

  @register_tool_completed: (e) =>
    category = "Tool completed"
    action = "Via scheme click #{@agent_with_audience()}"
    @send_event(category, action)

  @register_scheme_searched: =>
    category = "Schemes searched"
    action = "Via scheme search #{@agent_with_audience()}"
    @send_event(category, action)

  @register_had_direct_interactions: =>
    category = "Had direct interactions"
    action = "Via checkbox on #{@agent_with_audience()}"
    @send_event(category, action)

  @register_company_size: (company_size) =>
    category = "Company size"
    action = "#{@agent_with_audience()} #{company_size} employees"
    @send_event(category, action)

  @agent_with_audience: =>
    "[#{sff.current_agent}] [#{sff.current_audience}]"
