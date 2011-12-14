decryptMessageTemplate = require('templates/decrypt_message')
{BaseView} = require('views/base')
config = require('config')

class exports.DecryptMessageView extends BaseView
    id: 'decrypt-message-view'

    template: decryptMessageTemplate

    events:
        'click #decrypt': 'decryptMessage'
        'change #password': 'validatePassword'
        'keyup #password': 'validatePassword'


    render: ->
        $(@el).html(@template(hash: @options.hash))
        $('#main-content').html(@el)


        if window.message and window.message.hash == @options.hash
            $('#message').val(window.message.encryptedMessage)
            delete window.message
        else
            $('.loader-overlay').show()

            error = ->
                alert("I'm sorry, an error occured :(")
                $('.loader-overlay').hide()

            $.ajax(
                type: 'POST'
                url: '/api/get'
                data:
                    hash: @options.hash
                success: (res) ->
                    error() if not res.message
                    $('#message').val(res.message)
                    $('.loader-overlay').hide()
                error: error
            )


    decryptMessage: (e) ->
        e.preventDefault()
        self = @

        $('.loader-overlay').show()
        $('#encrypt').button('loading')

        message = $('#message').val()
        password = $('#password').val()

        decryptedMessage = Aes.Ctr.decrypt(message, password, config.keySize)

        _.delay(( ->
            $('#decrypt').button('complete')
            $('.loader-overlay').hide()
            self.$('form').replaceWith("<p>#{decryptedMessage}</p>")
        ), 2000)
