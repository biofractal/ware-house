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

	populate =(req, next)->
			req.modelQuery = @model.where().populate 'products'
			next()

	options:
		beforeGet:(req, res, next)->
			populate(req, next)
		beforePut:(req, res, next)->
			populate(req, next)