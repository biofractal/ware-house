mongoose = require 'mongoose'
Schema = mongoose.Schema

log= (message)->
	(req, res, next) ->
		console.log message
		next()

module.exports =

	schema: new Schema
		name		: String
		price		: Number
		stock		: Number

	options:[
		method : "INDEX"
		secure : false
		before : [
			log "1 product before INDEX"
			log "2 product before INDEX"
		]
		after : [
			log "1 product after INDEX"
			log "2 product after INDEX"
		]
	,
		method : "GET"
		secure : false
	,
		method : "PATCH"
		secure : false
		update : true
	]

