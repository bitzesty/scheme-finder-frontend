allowAcceptanceOfTerms = false

setCookie = (cname, cvalue, exdays=180) ->
  d = new Date()
  d.setTime(d.getTime() + (exdays*24*60*1000))
  expires = "expires=#{d.toUTCString()}"
  document.cookie = "#{cname}=#{cvalue}; #{expires}"

getCookie = (cname) ->
  name = "#{cname}="
  ca = document.cookie.split(";")
  for c in ca
    while c.charAt(0) == " "
      c = c.substring(1)
    if c.indexOf(name) != -1
      return c.substring(name.length, c.length)
  return null

showCookiesAlert = ->
  $("#cookie-container").removeClass("hidden")

hideCookiesAlert = ->
  $("#cookie-container").addClass("hidden")
  setCookie "acceptedCookiesPolicy", true
  false

showTermsAlert = ->
  $("#terms-container").removeClass("hidden")

hideTermsAlert = ->
  return false unless allowAcceptanceOfTerms
  $("#terms-container").addClass("hidden")
  if $("body").hasClass("scheme-businesses")
    setCookie "acceptedTermsAndConditionsBusinesses", true
  else if $("body").hasClass("scheme-teachers")
    setCookie "acceptedTermsAndConditionsTeachers", true
  false

toggleAllowAcceptanceOfTerms = (e) ->
  allowAcceptanceOfTerms = e.target.checked
  $btn = $("#terms-accepted-btn")
  if allowAcceptanceOfTerms
    $btn.removeAttr("disabled")
  else
    $btn.attr "disabled", "disabled"

toggleAllowRegisterOfScheme = (e) ->
  allowRegisterOfScheme = e.target.checked
  $btn = $("#new-scheme-page #submit_btn")
  if allowRegisterOfScheme
    $btn.removeAttr("disabled")
  else
    $btn.attr "disabled", "disabled"

jQuery ->
  # cookies
  showCookiesAlert() unless getCookie("acceptedCookiesPolicy")
  $(document).on "click", "#cookie-close-btn", hideCookiesAlert

  # terms and conditions
  terms_cookie = ""
  if $("body").hasClass("scheme-businesses")
    terms_cookie = "acceptedTermsAndConditionsBusinesses"
  else if $("body").hasClass("scheme-teachers")
    terms_cookie = "acceptedTermsAndConditionsTeachers"
  if terms_cookie.length > 0
    showTermsAlert() unless getCookie(terms_cookie)
    $(document).on "click", "#terms-accepted-btn", hideTermsAlert

  # enable terms and conditions if user ticks checkbox
  $(document).on "ifChanged", "#terms-accept", toggleAllowAcceptanceOfTerms

  # enable terms and conditions if user ticks checkbox
  $(document).on "ifChanged", "#new-scheme-accept", toggleAllowRegisterOfScheme
