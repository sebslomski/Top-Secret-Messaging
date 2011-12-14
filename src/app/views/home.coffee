homeTemplate = require('templates/home')

class exports.HomeView extends Backbone.View
    id: 'home-view'
    tagName: 'section'

    initialize: ->
        @render()

    render: ->
        $(@el).html(homeTemplate())
        $('#main').html(@el)
