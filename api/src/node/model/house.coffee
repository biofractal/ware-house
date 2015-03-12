mongoose = require 'mongoose'
helper = require '../helper'
Schema = mongoose.Schema

module.exports =

	schema: new Schema
		client		: String
		products	: [
			type: Schema.ObjectId
			ref: 'product'
		]

	options:
		beforeGet:(req, res, next)->
			req.modelQuery = @model.where().populate 'products'
			next()
		beforePut:(req, res, next)->
			req.modelQuery = @model.where().populate 'products'
			next()