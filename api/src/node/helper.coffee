module.exports =

	deduplicate: (target)->
		output = {}
		output[target[key]] = target[key] for key in [0...target.length]
		value for key, value of output

	getId:(filePathName, req)->
		propertyname = "#{@getFileNoExt filePathName}Id"
		req.params[propertyname]

	getFileNoExt:(filePathName)->
		filePathName.split('\\').pop().split('.')[0]
