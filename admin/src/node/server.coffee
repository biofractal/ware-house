require('dotenv').load()
express = require 'express'
winston = require 'winston'
sockets = require './sockets'

#app
app = express()
app.use express.static 'lib/angular'
app.use express.static 'lib/public'
app.use express.static 'bower_components'

#socketed app start
sockets.apiConnect process.env.WARE_API if process.env.WARE_API?
sockets.getServer(app).listen process.env.NODE_PORT, ->
	winston.info "socketed node server listening on port #{process.env.NODE_PORT}"


