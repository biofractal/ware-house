http = require 'http'
io_browser = require 'socket.io'
io_api = require 'socket.io-client'
helper = require './helper'
model = require './model'

module.exports =

	apiConnect:(apiUrl)->
		apiSocket = io_api.connect apiUrl
		apiSocket.on 'POST', (data)->
			io_browser.emit 'model', action:'new', status:data.status, item:data.item
		apiSocket.on 'PUT', (data)->
			io_browser.emit 'model', action:'update', status:data.status, item:data.item
		apiSocket.on 'PATCH', (data)->
			io_browser.emit 'model', action:'update', status:data.status, item:data.item
		apiSocket.on 'DELETE', (data)->
			io_browser.emit 'model', action:'remove', status:data.status, item:data.item

	getServer: (app) ->
		server = http.createServer app
		io_browser = io_browser.listen server
		io_browser.on 'connection', (browserSocket)->
			browserSocket.on '*', (event)->
				model.process event, (data)->
					data = helper.safeParseJSON data
					return browserSocket.emit 'exception', data if data.status?
					result=id:event.id, data:data
					browserSocket.emit 'success', result

			browserSocket.on 'error', (err)->
				browserSocket.emit 'exception', err.toString()

		return server