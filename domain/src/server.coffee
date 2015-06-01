require('dotenv').load()
env = process.env
express = require 'express'
bodyParser = require 'body-parser'
winston = require 'winston'
{server} = require '@gp-technical/sapify-domain'

#app
app = express()
app.use bodyParser.urlencoded {extended: true}
app.use bodyParser.json()

#app routes
app.get '/', (req, res, next)->
	res.send 'warehouse domain api is up and running'


#setup api
options=
	app:app
	modelPath:'./lib/model'
	mongo:
		url:env.MONGO_URL
		secret:env.MONGO_SECRET
	sso:
		url:env.SSO_DOMAIN

server.listen env.NODE_PORT, options, (err)->
	return winston.error if err?
	winston.info "warehouse-domain api listening on port #{env.NODE_PORT}"

