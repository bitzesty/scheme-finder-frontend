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
  if selected > -1
    for s in [0..selected]
      $(".radio-collection span:eq("+s+") input").addClass("active")
  $(".radio-collection input").on("change", -> (
    selected = $(".radio-collection span").index($(this).closest("span"))
    $(".radio-collection .active").removeClass("active")
    for s in [0..selected]
      $(".radio-collection span:eq("+s+")").addClass("active")
  ))

  #########
  ## Select2
  for select in $context.find("select.js-select2")
    options = {
      width: '180',
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
    )).on("select2-open", -> (
      $(".select2-selected").addClass("select2-result-unselectable").removeClass("select2-result-selectable")
      $(".select2-drop").each( -> (
        if $(this).css("display") == "block"
          $(".select2-drop").removeClass("height-checked")
          $(this).attr( "data-height", $(this).find(".select2-results").height() )
          $(".select2-drop").addClass("height-checked")
      ))
    )).on("select2-close", -> (
      $(".scheme-finder-frontend").removeClass("select2-open")
    )).on("change", -> (
      $(this).select2("open")
      $(".select2-selected").addClass("select2-result-unselectable").removeClass("select2-result-selectable")
    ))
  $(".select2-container input").prop("readonly",true)

  $(".select2-container").css("width", "100%")
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
        target_height = 0
        $(".select2-drop").each( -> (
          if $(this).css("display") == "block"
            target_height = $(this).attr("data-height")
        ))
        alert 
        if yDirection > 0
          if target_drop.scrollTop() < 1
            e.preventDefault()
        else if yDirection < 0
          if target_drop.scrollTop() + 3 >= target_height - window.innerHeight
            e.preventDefault()
  ))
