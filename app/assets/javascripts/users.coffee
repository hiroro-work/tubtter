# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  getFile = (elem) ->
    if elem.files then $(elem).prop('files')[0] else null

  setFile = (elem, file) ->
    reader = new FileReader
    reader.onload = (e) ->
      elem.setAttribute 'src', e.currentTarget.result
      return
    reader.readAsDataURL file
    return

  openModal = (id) ->
    $("#{id}").modal('show')
    return

  closeModal = (id) ->
    $('body').removeClass('modal-open')
    $('.modal-backdrop').remove()
    $("#{id}").modal('hide')
    return

  reloadUserIconPreview = (doc) ->
    elem_icon = doc.getElementById('registration-user-icon')
    elem_icon_preview = doc.getElementById('registration-user-icon-preview')

    icon_file = getFile(elem_icon)
    return unless icon_file
    setFile(elem_icon_preview, icon_file)
    return

  $('#registration-user-icon').change ->
    input_file = getFile(this)
    return unless input_file
    elem_trimming_icon = window.document.getElementById('trimming-user-icon')
    setFile(elem_trimming_icon, input_file)
    openModal '#user-icon-modal'
    return

  $('#user-icon-save-button').click ->
    reloadUserIconPreview window.parent.document
    closeModal '#user-icon-modal'
    return

  $('#user-icon-cancel-button').click ->
    $('input[type=file]').val('')
    return

  return
