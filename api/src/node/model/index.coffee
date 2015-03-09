sockets = require '../sockets'
mongoose = require 'mongoose'
components = require('require-dir')()
model = {}

setDefaultOptions = (options)->
	console.log options
	options = {} unless options?
	options.afterPut=(req, res, next)->
		sockets.emit 'PUT', item:res.locals.item
		next()
	options.afterPost=(req, res, next)->
		sockets.emit 'POST', item:res.locals.item
		next()
	options.afterDelete=(req, res, next)->
		sockets.emit 'DELETE', item: res.locals.item
		next()
	console.log options
	return options

for name, component of components
	component.model = mongoose.model name, component.schema
	component.options = setDefaultOptions component.options
	model[name] = component


module.exports = model
