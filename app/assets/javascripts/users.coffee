# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
getFile = (elem) ->
  if elem.files then $(elem).prop('files')[0] else null

setFile = (elem, file) ->
  reader = new FileReader
  reader.onload = (e) ->
    elem.setAttribute 'src', e.currentTarget.result
    return
  reader.readAsDataURL file
  return

setValue = (elem, value) ->
  $(elem).val(value)
  return

openModal = (id) ->
  $(id).modal({ backdrop: 'static', keyboard: false })
  return

closeModal = (id) ->
  $('body').removeClass('modal-open')
  $('.modal-backdrop').remove()
  $(id).modal('hide')

  $(id).on 'hidden.bs.modal', ->
    $(this).removeData('bs.modal')
    return
  return

cancelCrop = (cropper) ->
  cropper.destroy()
  $('input[type=file]').val('')
  return

# inputForm = (name, value) ->
#   form_data = new FormData()
#   form_data.append(name, value)
#   $.ajax location.pathname,
#     method: 'GET'
#     data: form_data
#     processData: false
#     contentType: false
#     success: ->
#       console.log 'Upload success'
#       return
#     error: ->
#       console.log 'Upload error'
#       return

ready = ->
  doc = window.document
  elem_icon = doc.getElementById('registration-user-icon')
  elem_icon_preview = doc.getElementById('registration-user-icon-preview')
  elem_icon_x = doc.getElementById('registration-user-icon-x')
  elem_icon_y = doc.getElementById('registration-user-icon-y')
  elem_icon_width = doc.getElementById('registration-user-icon-width')
  elem_icon_height = doc.getElementById('registration-user-icon-height')
  elem_trimming_icon = doc.getElementById('trimming-user-icon')

  setCroppedData = (doc, data) ->
    setValue(elem_icon_x, data.x)
    setValue(elem_icon_y, data.y)
    setValue(elem_icon_width, data.width)
    setValue(elem_icon_height, data.height)
    return

  replaceUserIcon = (doc, file) ->
    setFile(elem_icon, file)
    setFile(elem_icon_preview, file)
    return

  reloadUserIconPreview = (doc) ->
    icon_file = getFile(elem_icon)
    return unless icon_file
    setFile(elem_icon_preview, icon_file)
    return

  $('#registration-user-icon').change ->
    input_file = getFile(this)
    return unless input_file
    setFile(elem_trimming_icon, input_file)
    openModal '#user-icon-modal'
    return

  $('#user-icon-modal').one 'shown.bs.modal', ->
    cropper = undefined
    options =
      aspectRatio: 1 / 1
      autoCropArea: 0.5
      zoomable: false
      modal: false

    cropper = new Cropper(elem_trimming_icon, options)
    $('#user-icon-save-button').click ->
      setCroppedData(window.parent.document, cropper.getData())
      cropper.getCroppedCanvas({ width: 100, height: 100 }).toBlob (blob) ->
        replaceUserIcon(window.parent.document, blob)
        return
      cropper.destroy()
      closeModal '#user-icon-modal'
      return

    $('#user-icon-close-button').click ->
      cancelCrop(cropper)
      return

    $('#user-icon-cancel-button').click ->
      cancelCrop(cropper)
      return

    return

  return

$(document).on 'ready turbolinks:load', ready
