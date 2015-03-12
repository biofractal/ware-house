request = require 'request'

module.exports =

	update:(event, next)->
		item = event.params.item
		request.put
			url:"#{process.env.WARE_API}/product/#{item._id}", headers:'socket-id': event.socketId
			form:item,
			(err, response, data)->
				next data