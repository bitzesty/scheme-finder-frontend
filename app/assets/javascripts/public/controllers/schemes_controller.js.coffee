class Public.SchemesController
  constructor: () ->
    @form = "form.scheme-search-form"
    @results_context = "#filtered-results"
    @error_message = "<p> Error while processing request </p>"

  index: () ->
    $("body").on "ajax:success", @form, (e, response) =>
      $(@results_context).html(sff.parse_text_response response)

    $("body").on "ajax:error", @form, (e, response) =>
      $(@results_context).html(@error_message)

    $(@form).on "change", "input, select", (e) =>
      $(@form).submit()
