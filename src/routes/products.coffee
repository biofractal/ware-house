router = require('express').Router()
request = require 'request'
dedupe = require './deduplicate'

router.get '/synonym', (req, res, next)->
	url = "#{process.env.SYNONYM_API_URL}/?word=#{req.query.word}&language=en_US&output=json&key=#{process.env.SYNONYM_API_KEY}"
	request.get url, (err, response, json)->
		return next err if err?
		response = JSON.parse(json).response
		synonyms=[]
		for item in response
			for synonym in item.list.synonyms.split('|') when synonym.indexOf('(antonym)') is -1
				synonym = synonym.replace('(related term)', '').replace('(similar term)', '').trim()
				synonyms.push synonym
		res.json dedupe synonyms.sort()

module.exports = router