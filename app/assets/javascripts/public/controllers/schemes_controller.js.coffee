class Public.SchemesController
  constructor: () ->
    @form = ".scheme-finder-search form.scheme-search-form"
    @results_context = "#filtered-results"
    @error_message = "<p> Error while processing request </p>"

  index: () ->
    $("body").on "ajax:success", @form, (e, response) =>
      $(@results_context).html(sff.parse_text_response response)

    $("body").on "ajax:error", @form, (e, response) =>
      $(@results_context).html(@error_message)

    $(@form).on "change", "input, select", (e) =>
      $(@form).submit()
      sff.SchemeAnalyticsTracker.register_scheme_searched()

    # store had direct interactions click to google analytics
    $("body").on "click", "input[data-register='had-direct-interactions']", (e) =>
      sff.SchemeAnalyticsTracker.register_had_direct_interactions()

    $(".search_had_direct_interactions input[data-register='had-direct-interactions']").on 'ifChanged', ()->
      sff.SchemeAnalyticsTracker.register_had_direct_interactions()

    $("body").on "change", "#company-size-for-evaluation-purposes", ->
      if !!@value # do not register if user selects prompt
        sff.SchemeAnalyticsTracker.register_company_size @value

    if $("#ios-check").css("display") == "block"
      $("#terms-container .terms-body").css("max-height", ($(window).height() - 210))
    $(window).resize ->
      if $("#ios-check").css("display") == "block"
        $("#terms-container .terms-body").css("max-height", ($(window).height() - 210))
