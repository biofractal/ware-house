module.exports =

	deduplicate: (target)->
		output = {}
		output[target[key]] = target[key] for key in [0...target.length]
		value for key, value of output

	getCalleeFileNoExt:->
		module.parent?.filename?.split('\\')?.pop()?.split('.')?[0]

	safeParseJSON:(candidate)->
		try
			obj = JSON.parse candidate
			return obj if obj? && typeof obj is "object"
		catch exception

		console.log "cannot JSON parse: ", candidate
		return candidate
