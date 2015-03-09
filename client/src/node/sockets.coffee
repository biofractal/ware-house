http = require 'http'
io_browser = require 'socket.io'
io_api = require 'socket.io-client'
helper = require './helper'
model = require './model'

apiSocket = io_api.connect(process.env.WARE_API)

apiSocket.on 'POST', (item)->
	io_browser.emit 'model', action:'new', data:item

apiSocket.on 'PUT', (item)->
	io_browser.emit 'model', action:'update', data:item

apiSocket.on 'DELETE', (item)->
	io_browser.emit 'model', action:'remove', data:item

module.exports =
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



