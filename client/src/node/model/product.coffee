request = require 'request'

module.exports =

	getAll:(event, next)->
		request.get "#{process.env.WARE_API}/product", (err, response, data)->
			next data

	getById:(event, next)->
		request.get "#{process.env.WARE_API}/product/#{event.params.id}", (err, response, data)->
			next data

	purchase:(event, next)->
		url = "#{process.env.WARE_API}/product/#{event.params.id}"
		patch =[
			"op": "replace"
			"path": "/stock"
			"value": event.params.stock-1
		]
		request.patch {url:url, json:true, body:patch}, (err, response, data)->
			next data