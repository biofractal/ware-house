require('dotenv').load()
express = require 'express'
bodyParser = require 'body-parser'
winston = require 'winston'
errorService = require './service/error'

#app
app = express()
app.use bodyParser.urlencoded {extended: true}
app.use bodyParser.json()

#routes
app.use '/ware', [
	require './route/product'
]

#error handling
app.use errorService.log
app.use errorService.xhr
app.use errorService.default

#app start
port = process.env.PORT or 3000
app.listen port, ->
	winston.info "ware-house API [#{process.env.NODE_ENV}] is listening on port #{port}"