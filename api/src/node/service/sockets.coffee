http = require 'http'
io = require 'socket.io'

module.exports =
	getServer: (app) ->
		server = http.createServer app
		io = io.listen server
		return server

	emit: (event, data)->
		io.emit event, data

