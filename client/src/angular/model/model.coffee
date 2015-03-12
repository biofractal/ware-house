angular
.module 'client'
.factory 'model', ->
	model={}

	model =

		product:
			getAll:->
			getById:(id)->
			purchase:(id, stock)->
		,

		house:
			getAll:->
			getById:(id)->

	return model