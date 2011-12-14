{EncryptMessageView} = require('views/encrypt_message')
{DecryptMessageView} = require('views/decrypt_message')

class exports.MainRouter extends Backbone.Router
    routes :
        '': 'init'
        'create-message': 'encryptMessage'
        'message/:hash': 'decryptMessage'


    init: ->
        @navigate('create-message', true if Backbone.history.getFragment() is '')


    encryptMessage: ->
        new EncryptMessageView()


    decryptMessage: (hash) ->
        new DecryptMessageView(hash: hash)
