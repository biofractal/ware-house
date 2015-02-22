winston = require 'winston'

module.exports =

	log:(err, req, res, next)->
		err.location = err.stack.split('\n')[1]
		err.url = req.originalUrl
		winston.error JSON.stringify err, ['message', 'url', 'inner', 'location']
		next err

	xhr:(err, req, res, next) ->
		return res.status(500).send error: "Something blew up!" if req.xhr
		next err

	default:(err, req, res, next) ->
		res.status 500
		res.send "<h1>Oops!</h1><div>#{err.message}</div>"