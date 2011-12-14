encryptMessageTemplate = require('templates/encrypt_message')
{BaseView} = require('views/base')
config = require('config')

class exports.EncryptMessageView extends BaseView
    id: 'encrypt-message-view'


    template: encryptMessageTemplate


    events:
        'click #encrypt': 'encryptMessage'
        'change #password': 'validatePassword'
        'keyup #password': 'validatePassword'


    encryptMessage: (e) ->
        e.preventDefault()

        $('.loader-overlay').show()
        $('#encrypt').button('loading')

        message = $('#message').val()
        password = $('#password').val()

        encryptedMessage = Aes.Ctr.encrypt(message, password, config.keySize)
        hash = @randomString(config.hashSize)

        error = ->
            alert("I'm sorry, an error occured :(")
            $('#encrypt').button('complete')
            $('.loader-overlay').hide()

        success = (res) ->
            error() if not res.saved

            _.delay(( ->
                $('#encrypt').button('complete')
                $('.loader-overlay').hide()
                window.message =
                    encryptedMessage: encryptedMessage
                    hash: hash
                window.location.hash = "message/#{hash}"
            ), 2000)

        $.ajax(
            type: 'POST'
            url: '/api/add'
            data:
                hash: hash
                message: encryptedMessage
            success: success
            error: error
        )
