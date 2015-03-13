http = require 'http'
io_browser = require 'socket.io'
io_api = require 'socket.io-client'
helper = require './helper'
model = require './model'

module.exports =

	apiConnect:(apiUrl)->
		apiSocket = io_api.connect apiUrl

		broadcast =(action, data)->
			payload=action:action, status:data.status, item:data.item
			sender = io_browser.sockets.connected[data.socket_id]
			return sender.broadcast.emit('model', payload) if sender?
			io_browser.emit 'model', payload

		apiSocket.on 'POST', (data)-> broadcast 'new', data
		apiSocket.on 'PUT', (data)-> broadcast 'update', data
		apiSocket.on 'PATCH', (data)-> broadcast 'update', data
		apiSocket.on 'DELETE', (data)-> broadcast 'remove', data

	getServer: (app) ->
		server = http.createServer app
		io_browser = io_browser.listen server
		io_browser.on 'connection', (browserSocket)->
			browserSocket.on '*', (event)->
				event.socketId = browserSocket.id
				model.process event, (data)->
					data = helper.safeParseJSON data
					return browserSocket.emit 'exception', data if data?.status?
					result=id:event.id, data:data
					browserSocket.emit 'success', result

			browserSocket.on 'error', (err)->
				browserSocket.emit 'exception', err.toString()

		return server