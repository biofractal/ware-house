sockets = require '../sockets'
mongoose = require 'mongoose'
components = require('require-dir')()
model = {}

setDefaultOptions = (options)->

	options = {} unless options?
	emit = (method, next)->
		(req, res, next)->
			sockets.emit method, item:res.locals.item
			next()

	options.afterPut = emit 'PUT' unless options.afterPut?
	options.afterPost = emit 'POST' unless options.afterPost?
	options.afterDelete = emit 'DELETE' unless options.afterDelete?

	return options

for name, component of components
	component.model = mongoose.model name, component.schema
	component.options = setDefaultOptions component.options
	model[name] = component


module.exports = model
