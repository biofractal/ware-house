module.exports = (target)->
	output = {}
	output[target[key]] = target[key] for key in [0...target.length]
	value for key, value of output