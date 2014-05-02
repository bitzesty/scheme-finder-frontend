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
      @hide_input(e.target)

  hide_input: (input) =>
    $(input).closest("[data-wraps='had-direct-interactions']").slideUp("slow")
