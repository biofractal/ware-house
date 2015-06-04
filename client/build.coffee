require 'shelljs/global'

require 'shelljs/global'

rm '-rf', 'lib'
mkdir '-p', 'lib'

cp '-r', 'src/public/*', 'lib/public' if test '-e', 'src/public'
cp '.env', 'lib'

exec 'coffee --watch -j app.js -o lib/angular -c src/angular', async: true
exec 'jade --watch --pretty --out ./lib/angular src/angular/', async: true
exec 'coffee --watch -o lib/proxy -c src/proxy', async: true
child = exec 'nodemon ./lib/proxy/server.js', async: true

isOpen = false
child.stdout.on 'data', (data)->
	if data.indexOf('on port') > -1 and not isOpen
		isOpen = true
		exec 'opener http://localhost:3001/#/products', async: true
