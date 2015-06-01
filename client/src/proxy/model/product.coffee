{request} = require '@gp-technical/sapify-proxy'
api = process.env.WAREHOUSE_DOMAIN_API

module.exports =

	getAll:(event, next)->
		options =
			method: 'GET'
			uri:"#{api}/product"
		request options, event.headers, (err, response, data)->
			next data

	getById:(event, next)->
		options =
			method: 'GET'
			uri:"#{api}/product/#{encodeURIComponent event.params.id}"
		request options, event.headers, (err, response, data)->
			next data

	purchase:(event, next)->
		patch =[
			"op": "test", "path": "/stock", "value": event.params.stock
		,
			"op": "replace", "path": "/stock", "value": event.params.stock-1
		]
		options =
			method: 'PATCH'
			uri:"#{api}/product/#{encodeURIComponent event.params.id}"
			body:patch
			json:true
		request options, event.headers, (err, response, data)->
			next data