http = require 'http'
io = require 'socket.io'
model = require '../model'

module.exports =
	getServer: (app) ->
		server = http.createServer app
		io = io.listen server
		io.on 'connection', (socket)->
			socket.on '*', (event)->
				model.process event, (data)->
					data = JSON.parse data
					return socket.emit 'exception', data if data.status?
					result=id:event.id, data:data
					socket.emit 'success', result

			socket.on 'error', (err)->
				socket.emit 'exception', err.toString()

		return server


