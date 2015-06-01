{request, error} = require '@gp-technical/sapify-proxy'
api = process.env.SSO_GATEWAY

module.exports =

	authenticate:(event, next)->
		options =
			method: 'GET'
			uri:"#{api}/user/authenticated/#{encodeURIComponent event.params.email}/#{encodeURIComponent event.params.secret}"
		request options, event.headers, (err, response, data)->
			return console.log 'user authenticate err', err if err?
			return error event, 'An unexplained server error has occurred' if response?.statusCode is 500
			return error event, 'The email address cannot be found' if response?.statusCode is 404
			return error event, 'The secret does not match' if response?.statusCode is 401
			next data

	verify:(event, next)->
		options =
			method: 'GET'
			uri:"#{api}/user/verified/#{encodeURIComponent event.params.vid}/#{encodeURIComponent event.params.code}"
		request options, event.headers, (err, response, data)->
			return error event, 'An unexplained server error has occurred' if response?.statusCode is 500
			return error event, 'The verification code has expired' if response?.statusCode is 404
			return error event, 'The verification code does not match' if response?.statusCode is 401
			next data