angular
.module 'client'
.factory 'socket', (socketFactory)->
	socket = socketFactory()
	socket.forward 'success'
	socket.forward 'exception'
	return socket




