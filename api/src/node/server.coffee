require('dotenv').load()
express = require 'express'
mongoose = require 'mongoose'
bodyParser = require 'body-parser'
winston = require 'winston'
errorService = require './error'
sockets = require 'socket-sauce-rest-api'


#app
app = express()
app.use bodyParser.urlencoded {extended: true}
app.use bodyParser.json()

#mongoose
mongoose.connect process.env.MONGO_URL

#model routes
sockets.rest app, './lib/node/model'

#app routes
app.get '/', (req, res, next)->
	res.send 'ware-house API is up and running'

#error handling
app.use errorService.log
app.use errorService.handle

#socketed app start
port = process.env.NODE_PORT
sockets
.getServer app
.listen port, ->
	winston.info "node server listening on port #{port}"

