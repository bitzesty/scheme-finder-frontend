jQuery ->
  # disable submit button by default
  # enable it if the user ticks checkbox
  $btn = $("#terms-accepted")
  $btn.attr "disabled", "disabled"
  $("#terms-accept").on "ifChanged", (e) ->
    if e.target.checked
      $btn.removeAttr "disabled"
    else
      $btn.attr "disabled", "disabled"
