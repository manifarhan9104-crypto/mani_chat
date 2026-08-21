const express = require("express");
const cors = require("cors");
const http = require("http");
const { Server } = require("socket.io");


const app = express();

app.use(cors());
app.use(express.json());


const server = http.createServer(app);


const io = new Server(server, {

  cors:{
    origin:"*"
  }

});



let users = [];



io.on("connection",(socket)=>{


 console.log("کاربر وصل شد:", socket.id);



 users.push(socket);



 socket.on("send_message",(data)=>{


    console.log(data);



    io.emit("receive_message",{

      message:data.message,

      sender:socket.id

    });


 });



 socket.on("disconnect",()=>{


    users = users.filter(
      user=>user!==socket
    );


    console.log("کاربر قطع شد");


 });



});



app.get("/",(req,res)=>{

 res.send("Mani Chat Server Running");

});



server.listen(3000,()=>{

 console.log(
 "Server started on port 3000"
 );

});
