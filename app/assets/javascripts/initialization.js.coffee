# scheme-finder-frontend namespace
window.sff ||= {}

sff.parse_text_response = (response) ->
  if response.responseText?
    response.responseText
  else
    response

sff.current_agent = $('meta[name=current_agent]').attr("content")
sff.current_audience = $('meta[name=current_audience]').attr("content")

sff.apply_content_load_js = ($context) ->
  $context ||= $("body")

  $(".alert").delay(5000).fadeOut("slow")

  selected = $(".radio-collection span").index($(".radio-collection input:checked").closest("span"))
  if selected > -1
    for s in [0..selected]
      $(".radio-collection span:eq("+s+")").addClass("active")
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
  $(".select2-container input").prop("readonly",true)

  $(".select2-container").css("width", "100%")
  ## [END] Select2
  #########

  if $("#ipad-check").css('display') == "none"
    if (document.addEventListener)
      xStart = 0
      yStart = 0
      xMovement = 0
      yMovement = 0
      movementLimit = 10

      document.addEventListener('touchstart', (e) -> (
        xStart = e.touches[0].screenX
        yStart = e.touches[0].screenY
        xMovement = 0
        yMovement = 0
      ))

      document.addEventListener('touchmove', (e) -> (
        xMovement = Math.abs(e.touches[0].screenX - xStart)
        yMovement = Math.abs(e.touches[0].screenY - yStart)
        yDirection = e.touches[0].screenY - yStart
        if $(".scheme-finder-frontend").hasClass("select2-open")
          if (yMovement * 3) > xMovement
            target_drop = $(e.target).closest(".select2-results")
            target_height = 0
            $(".select2-drop").each( -> (
              if $(this).css("display") == "block"
                target_height = $(this).attr("data-height")
            ))
            # alert
            if yDirection > 0
              if target_drop.scrollTop() < 1
                e.preventDefault()
            else if yDirection < 0
              if target_drop.scrollTop() + 3 >= target_height - window.innerHeight
                e.preventDefault()
      ))

      document.addEventListener('touchend', (e) -> (
        if xMovement < movementLimit && yMovement < movementLimit
          if $(".scheme-finder-frontend").hasClass("select2-open")
            if $(e.target).attr("class") == "select2-result-label"
              select2_selected = $(e.target).closest(".select2-drop").find("li").index($(e.target).closest("li"))
              if select2_selected != -1
                clicked_select = $(".select2-dropdown-open").closest(".input").find("select")
                select_values = $(".select2-dropdown-open").attr("data-value").split(",")
                clicked_value = clicked_select.find("option:eq("+(select2_selected-1)+")").val()
                if $(e.target).text() != clicked_select.find("option:eq("+(select2_selected-1)+")").text()
                  for option in [0..clicked_select.find("option").size()]
                    if $(e.target).text() == clicked_select.find("option:eq("+option+")").text()
                      clicked_value = clicked_select.find("option:eq("+option+")").val()
                if $(e.target).closest(".select2-drop").find("li:eq("+select2_selected+")").hasClass("select2-selected")
                  if select_values.indexOf(clicked_value) != -1
                    select_values.splice(select_values.indexOf(clicked_value), 1)
                    clicked_select.select2("close").select2("val", select_values).select2("open")
                    e.preventDefault()
              drop_scrolled = $(e.target).closest(".select2-drop").find(".select2-results").scrollTop()
              if drop_scrolled
                $(".select2-dropdown-open").closest(".input").attr("data-scroll", drop_scrolled)
      ))

# Registered on page load only once
$ ->
  #########
  ## google analytics
  sff.GoogleAnalyticsTracker.track_clicked_links(
    "body",
    "ga_scheme_click",
    sff.SchemeAnalyticsTracker.register_scheme_clicked
  )

  sff.GoogleAnalyticsTracker.track_clicked_links(
    "body",
    "ga_search_scheme_click",
    sff.SchemeAnalyticsTracker.register_scheme_searched
  )
  ## [END] google analytics
  #########

# Fix select2 width
select2CheckWidth = () ->
  if $('.filter-block form fieldset .filter').width() != $('.filter-block form').width()
    $('.filter-block form fieldset .filter').width($('.filter-block form').width())

$(window).resize ->
  if $('.filter-block form fieldset .filter').size() > 0
    select2CheckWidth()
