{Schema} = require 'mongoose'

populate = (req, res, next)->
	req.modelQuery = @model.where().populate 'products'
	next()

module.exports =
	schema: new Schema
		client		: String
		products	: [
			type: Schema.ObjectId
			ref: 'product'
		]

	options:
		secure : true
		rest:[
			method : "INDEX"
		,
			method : "GET"
			before : populate
		,
			method : "PUT"
			update : true
			before : populate
		]


