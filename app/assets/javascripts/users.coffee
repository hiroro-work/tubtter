# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready turbolinks:load', ->

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
    $(id).modal({ keyboard: false })
    return

  closeModal = (id) ->
    $('body').removeClass('modal-open')
    $('.modal-backdrop').remove()
    $(id).modal('hide')
    return

  setCroppedData = (doc, data) ->
    elem_icon_x = doc.getElementById('registration-user-icon-x')
    elem_icon_y = doc.getElementById('registration-user-icon-y')
    elem_icon_width = doc.getElementById('registration-user-icon-width')
    elem_icon_height = doc.getElementById('registration-user-icon-height')
    $(elem_icon_x).val(data.x)
    $(elem_icon_y).val(data.y)
    $(elem_icon_width).val(data.width)
    $(elem_icon_height).val(data.height)
    return

  # inputForm = (name, value) ->
  #   console.log("name: #{name}")
  #   console.log("value: #{value}")
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

  replaceUserIcon = (doc, file) ->
    elem_icon = doc.getElementById('registration-user-icon')
    elem_icon_preview = doc.getElementById('registration-user-icon-preview')
    setFile(elem_icon, file)
    setFile(elem_icon_preview, file)
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

  $('#user-icon-modal').on 'shown.bs.modal', ->
    cropper = undefined
    elem_trimming_icon = document.getElementById('trimming-user-icon')
    options =
      aspectRatio: 1 / 1
      autoCropArea: 0.5
      zoomable: false

    cancelCrop = () ->
      cropper.destroy()
      $('input[type=file]').val('')
      return

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
      cancelCrop()
      return

    $('#user-icon-cancel-button').click ->
      cancelCrop()
      return

    return

  return
