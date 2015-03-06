require('dotenv').load()
express = require 'express'
winston = require 'winston'
sockets = require './service/sockets'

#app
app = express()
app.use express.static 'lib/angular'
app.use express.static 'lib/public'
app.use express.static 'bower_components'

#socketed app start
port = process.env.NODE_PORT
sockets
.getServer app
.listen port, ->
	winston.info "socketed node server listening on port #{port}"

