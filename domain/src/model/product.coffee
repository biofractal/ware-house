{Schema} = require 'mongoose'

module.exports =
	schema: new Schema
		name		: String
		price		: Number
		stock		: Number

	options:
		logger:true
		rest:[
			method : "INDEX"
			secure : false
		,
			method : "GET"
		,
			method : "PATCH"
			update : true
		]

