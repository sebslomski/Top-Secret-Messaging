config = require('config')

class exports.BaseView extends Backbone.View
    initialize: ->
        @render()

    render: ->
        $(@el).html(@template())
        $('#main-content').html(@el)


    validatePassword: (e) ->
        password = $('#password').val()
        rEmail = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/

        if not rEmail.test(password)
            $('#password').parents('.input').parent().removeClass('success').addClass('error')
            $('button.continue').attr('disabled', true)
        else
            $('#password').parents('.input').parent().removeClass('error').addClass('success')
            $('button.continue').attr('disabled', false)


    randomString: (length) ->
        chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz'.split('')

        length = Math.floor(Math.random() * chars.length) if not length

        str = (chars[Math.floor(Math.random() * chars.length)] for i in [0..length])
        return str.join('')
