{request} = require '@gp-technical/sapify-proxy'
api = process.env.WAREHOUSE_DOMAIN_API

module.exports =

	getAll:(event, next)->
		options =
			method: 'GET'
			uri:"#{api}/house"
		request options, event.headers, (err, response, data)->
			next data

	getById:(event, next)->
		options =
			method: 'GET'
			uri:"#{api}/house/#{encodeURIComponent event.params.id}"
		request options, event.headers, (err, response, data)->
			next data
