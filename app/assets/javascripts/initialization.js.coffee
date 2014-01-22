# scheme-finder-frontend namespace
window.sff ||= {}

sff.parse_text_response = (response) ->
  if response.responseText?
    response.responseText
  else
    response

sff.apply_content_load_js = ($context) ->
  $context ||= $("body")

  $(".alert").delay(5000).fadeOut("slow")

  selected = $(".radio-collection span").index($(".radio-collection input:checked").closest("span"))
  for s in [0..selected]
    $(".radio-collection span:eq("+s+") input").addClass("active")
  $(".radio-collection input").on("change", -> (
    selected = $(".radio-collection span").index($(this).closest("span"))
    $(".radio-collection input.active").removeClass("active")
    for s in [0..selected]
      $(".radio-collection span:eq("+s+") input").addClass("active")
  ))

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
    body_scroll = 0
    $(select).on("select2-opening", -> (
      $(".scheme-finder-frontend").addClass("select2-open")
      $("html, body").addClass("no-scroll")
      body_scroll = $("body").scrollTop()
      $("body").animate {
        scrollTop: 0
      }, 0
      $(".scheme-finder-frontend").css("top", -(body_scroll))
    )).on("select2-close", -> (
      $(".scheme-finder-frontend").removeClass("select2-open")
      $("html, body").removeClass("no-scroll")
      $("body").animate {
        scrollTop: body_scroll
      }, 0
      $(".scheme-finder-frontend").css("top", 0)
    )).on("change", -> (
      $(this).select2("open")
      $(".select2-selected").addClass("select2-result-unselectable").removeClass("select2-result-selectable")
    ))
  $(".select2-container input").prop("readonly",true);
  ## [END] Select2
  #########

  xStart = 0
  yStart = 0
   
  document.addEventListener('touchstart', (e) -> (
    xStart = e.touches[0].screenX
    yStart = e.touches[0].screenY
  ))
   
  document.addEventListener('touchmove', (e) -> (
    if $(".scheme-finder-frontend").hasClass("select2-open")
      xMovement = Math.abs(e.touches[0].screenX - xStart)
      yMovement = Math.abs(e.touches[0].screenY - yStart)
      yDirection = e.touches[0].screenY - yStart
      if (yMovement * 3) > xMovement
        target_drop = $(e.target).closest(".select2-results")
        if yDirection > 0
          if target_drop.scrollTop() < 1
            e.preventDefault()
  ))
