const express = require("express");
const cors = require("cors");
const http = require("http");
const { Server } = require("socket.io");

const app = express();

app.use(cors());
app.use(express.json());

const server = http.createServer(app);

const io = new Server(server, {
  cors: {
    origin: "*"
  }
});

io.on("connection", (socket) => {

  console.log("کاربر وصل شد");

  socket.on("send_message", (data) => {

    io.emit("receive_message", data);

  });

  socket.on("disconnect", () => {
    console.log("کاربر خارج شد");
  });

});


app.get("/", (req, res) => {
  res.send("سرور پیام‌رسان فارسی فعال است");
});


server.listen(3000, () => {
  console.log("Server running on port 3000");
});
