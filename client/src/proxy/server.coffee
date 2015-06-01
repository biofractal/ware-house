require('dotenv').load()
express = require 'express'
winston = require 'winston'
{server} = require '@gp-technical/sapify-proxy'
env = process.env

#setup app
app = express()
app.use express.static 'lib/angular'
app.use express.static 'lib/public'


#setup secure proxy
options=
	app:app
	modelPath:'./lib/proxy/model'
	socketApis:env.WAREHOUSE_DOMAIN_API
	sso:
		url:env.SSO_GATEWAY
		key:env.SSO_KEY
		secret:env.SSO_SECRET
		token:env.SSO_TOKEN

server.listen env.NODE_PORT, options, (err)->
	return winston.error if err?
	winston.info "ware-house proxy server listening on port #{env.NODE_PORT}"

