MainRouter = require('routers/main').MainRouter
HomeView = require('views/home').HomeView

# app bootstrapping on document ready
$(document).ready ->
    new MainRouter()
    new HomeView()
    Backbone.history.start()
