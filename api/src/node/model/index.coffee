mongoose = require 'mongoose'
components = require('require-dir')()
model = {}

for name, component of components
	component.model = mongoose.model name, component.schema
	model[name] = component

module.exports = model
