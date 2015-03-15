sockets = require '../sockets'
mongoose = require 'mongoose'
components = require('require-dir')()
model = {}

setDefaultOptions = (options)->
	emit = (method, next)->
		(req, res, next) ->
			data = socket_id:req.headers['socket-id'], status:res.resource.status, item:res.resource.item
			data.name = res.resource.name if res.resource.name?
			data.message = res.resource.message if res.resource.message?
			sockets.emit method, data
			next()

	options = {} unless options?
	options.afterPut = emit 'PUT' unless options.afterPut?
	options.afterPost = emit 'POST' unless options.afterPost?
	options.afterPatch = emit 'PATCH' unless options.afterPatch?
	options.afterDelete = emit 'DELETE' unless options.afterDelete?
	return options

for name, component of components
	component.model = mongoose.model name, component.schema
	component.options = setDefaultOptions component.options
	model[name] = component

module.exports = model