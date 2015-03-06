request = require 'request'

module.exports =

	getAll:(event, next)->
		request.get "#{process.env.WARE_API}/house", (err, response, data)->
			next data

	getById:(event, next)->
		request.get "#{process.env.WARE_API}/house/#{event.params.id}", (err, response, data)->
			next data
