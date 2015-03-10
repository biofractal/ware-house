request = require 'request'

module.exports =

	getAll:(event, next)->
		request.get "#{process.env.WARE_API}/house", (err, response, data)->
			next data

	getById:(event, next)->
		console.log event.params
		request.get "#{process.env.WARE_API}/house/#{event.params.id}", (err, response, data)->
			next data

	update:(event, next)->
		payload =
			client:event.params.client
			products:event.params.products
		request.put "#{process.env.WARE_API}/house/#{event.params.id}", payload, (err, response, data)->
			next data