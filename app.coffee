require 'coffee-script'
express = require 'express', http = require 'http'
engines = require 'consolidate'

app = express()

server = http.createServer app

app.configure ->
	app.set "views", __dirname+"/views"
	app.use express.static __dirname+"/public"
	app.engine 'eco', engines.eco

app.get "/", (req,res)->
	res.render "index.eco", user: "otro" 
	console.log "Peticion solicitada"
server.listen 8080, ->
	console.log "Servidor se ha iniciado"

io = require('socket.io').listen server

io.sockets.on 'connection', (socket)->
	console.log "Socket conectada"
	socket.on 'moveForward', ->
		console.log "Hacia adelante"
		io.sockets.emit 'moveF_client'
	socket.on 'moveBackward', ->
		io.sockets.emit 'moveB_client'
