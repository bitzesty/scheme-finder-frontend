# scheme-finder-frontend namespace
window.sff ||= {}

sff.parse_text_response = (response) ->
  if response.responseText?
    response.responseText
  else
    response

sff.apply_content_load_js = ($context) ->
  $context ||= $("body")

  #########
  ## Select2
  for select in $context.find("select.js-select2")
    options = {
      width: 'resolve',
    }
    # has placeholder and empty option
    if $(select).filter("[placeholder]").find("option[value='']").length
      allow_clear_options =
        placeholder: "",
        allowClear: true,
      $.extend(options, allow_clear_options)

    $(select).select2 options
  ## [END] Select2
  #########
