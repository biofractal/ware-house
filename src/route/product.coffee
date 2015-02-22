router = require('express').Router()
request = require 'request'

router.get '/product', (req, res, next)->
	app.json {id:1, name:'product-1'}

module.exports = router