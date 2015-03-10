
model = require('require-dir')()

model.process=(msg, next)->
	call=msg.method.split('.')
	model[call[0]][call[1]] msg, next

module.exports = model