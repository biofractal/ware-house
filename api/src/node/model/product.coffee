sockets = require '../sockets'
mongoose = require 'mongoose'
Schema = mongoose.Schema

module.exports =
	schema: new Schema
		name		: String
		price		: Number
		stock		: Number

	options:
		afterPut:(req, res, next)->
			sockets.emit 'PUT', type:'product', item:res.locals.item
			next()

		afterPost:(req, res, next)->
			sockets.emit 'POST', type:'product', item:res.locals.item
			next()

		afterDelete:(req, res, next)->
			sockets.emit 'DELETE', type:'product', item: res.locals.item
			next()


