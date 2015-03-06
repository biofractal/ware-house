router = require('express').Router()
winston = require 'winston'

router.get '/', (req, res, next)->
	res.send 'api is up and running'


module.exports = router