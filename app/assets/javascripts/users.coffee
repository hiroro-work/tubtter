# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  reloadUserIconPreview = (input) ->
    if input.files and input.files[0]
      reader = new FileReader

      reader.onload = (e) ->
        $('#registration-user-icon-preview').attr 'src', e.currentTarget.result
        return

      reader.readAsDataURL input.files[0]
    return

  $('#registration-user-icon').change ->
    reloadUserIconPreview this
    return

  return
