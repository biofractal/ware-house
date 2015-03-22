mongoose = require 'mongoose'
Schema = mongoose.Schema

module.exports =
	schema: new Schema
		name		: String
		price		: Number
		stock		: Number



