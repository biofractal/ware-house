router = require('express').Router()
request = require 'request'

router.get '/product', (req, res, next)->
	res.json {id:1, name:'kay'}

module.exports = router