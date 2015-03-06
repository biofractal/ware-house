winston = require 'winston'

module.exports =

	log:(err, req, res, next)->
		err.location = err.stack?.split('\n')[1]
		err.url = req.originalUrl
		winston.error JSON.stringify err, ['message', 'url', 'inner', 'location']
		next err

	handle:(err, req, res, next) ->
		res.status 500
		return res.json error: err.message if req.xhr or req.accepts 'json'
		return res.send "<h1>Oops!</h1><div>#{err.message}</div>" if req.accepts 'html'
		res.type='text'
		res.send "error: #{err.message}"
