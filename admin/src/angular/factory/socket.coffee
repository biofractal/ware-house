angular
.module 'admin'
.factory 'socket', (socketFactory)->
	socket = socketFactory()
	socket.forward 'success'
	socket.forward 'model'
	socket.forward 'exception'
	return socket

