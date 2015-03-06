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
		before:(req, res, next)->
			req.modelQuery = @model.where().populate 'products'
			next()