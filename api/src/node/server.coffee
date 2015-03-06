require('dotenv').load()
express = require 'express'
mongoose = require 'mongoose'
bodyParser = require 'body-parser'
winston = require 'winston'
errorService = require './service/error'
sockets = require './service/sockets'
resource = require 'resourcejs'


#app
app = express()
app.use bodyParser.urlencoded {extended: true}
app.use bodyParser.json()

#mongoose
mongoose.connect process.env.MONGO_URL

#model routes
resource(app, '', name, component.model).rest(component.options) for name, component of require './model'

#app routes
app.use '/api', [
	require './route/root'
]

#error handling
app.use errorService.log
app.use errorService.handle

#socketed app start
port = process.env.NODE_PORT
sockets
.getServer app
.listen port, ->
	winston.info "node server listening on port #{port}"

