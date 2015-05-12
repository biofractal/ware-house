mongoose = require 'mongoose'
Schema = mongoose.Schema

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

	options:[
		method : "INDEX"
		secure : true
	,
		method : "GET"
		secure : true
		before : populate
	,
		method : "PUT"
		secure : true
		update : true
		before : populate
	]


