angular
.module 'ware-house-client'
.factory 'model', ->
	model =
		user:
			authenticate:(email, secret)->
			verify:(vid, code)->
		,
		product:
			getAll:->
			getById:(id)->
			purchase:(id, stock)->
		,
		house:
			getAll:->
			getById:(id)->

	return model

