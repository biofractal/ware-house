http = require 'http'
io = require 'socket.io'

module.exports =
	getServer: (app) ->
		server = http.createServer app
		io = io.listen server
		return server

	emit: (event, data)->
		console.log 'event: ', event
		console.log 'data : ', data.item
		io.emit event, data.item

