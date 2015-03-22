require 'shelljs/global'

rm '-rf', 'lib'
mkdir '-p', 'lib'

cp '-r', 'src/public/*', 'lib/public' if test '-e', 'src/public'
cp '.env', 'lib'

exec 'coffee --watch -o lib/ -c src/', async: true
child = exec 'nodemon ./lib/server.js', async: true

isOpen = false
child.stdout.on 'data', (data)->
	if data.indexOf('on port') > -1 and not isOpen
		isOpen = true
		exec 'opener http://localhost:3000/product', async: true
