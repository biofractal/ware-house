mongoose = require 'mongoose'
Schema = mongoose.Schema

module.exports =

	schema: new Schema
		client		: String
		products	: [
			type: Schema.ObjectId
			ref: 'product'
		]

	setup:(resource)->
		options =
			beforeGet:(req, res, next)->
				req.modelQuery = @model.where().populate 'products'
				next()
			beforePut:(req, res, next)->
				req.modelQuery = @model.where().populate 'products'
				next()

		resource.rest options
