const WebSocket = require('ws')

const wss = new WebSocket.Server({ port: 8080 })

wss.on('connection', ws => {

    ws.on('message', message => {

        let data = JSON.parse(message)
        
        console.log(data)

    })

    ws.send('ho!')
    
})