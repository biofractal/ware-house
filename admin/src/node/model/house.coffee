request = require 'request'

module.exports =

	getAll:(event, next)->
		request.get "#{process.env.WARE_API}/house", (err, response, data)->
			next data

	getById:(event, next)->
		request.get "#{process.env.WARE_API}/house/#{event.params.id}", (err, response, data)->
			next data

	update:(event, next)->
		item = event.params.item
		payload =
			client: item.client
			products: (p._id for p in item.products)
		console.log event.socketId
		request.put
			url:"#{process.env.WARE_API}/house/#{item._id}", headers:'socket-id': event.socketId
			form:payload,
			(err, response, data)->
				next data
