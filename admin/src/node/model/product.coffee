request = require 'request'

module.exports =

	update:(event, next)->
		item = event.params.item
		request.put "#{process.env.WARE_API}/product/#{item._id}", form:item, (err, response, data)->
			next data