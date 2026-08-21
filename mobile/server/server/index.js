const express = require("express");
const cors = require("cors");
const http = require("http");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
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

const JWT_SECRET = "MANI_CHAT_SECRET_CHANGE_THIS";

const users = [];
const onlineUsers = new Map();


// -------------------------
// ثبت نام
// -------------------------

app.post("/register", async (req, res) => {

  const { phone, name, password } = req.body;

  if (!phone || !name || !password) {

    return res.status(400).json({
      message: "همه اطلاعات را وارد کنید"
    });

  }

  const existingUser =
    users.find(user => user.phone === phone);

  if (existingUser) {

    return res.status(409).json({
      message: "این شماره قبلاً ثبت شده است"
    });

  }

  const hashedPassword =
    await bcrypt.hash(password, 10);

  const user = {

    id: Date.now().toString(),

    phone,

    name,

    password: hashedPassword,

    avatar: null

  };

  users.push(user);

  const token = jwt.sign(
    {
      id: user.id,
      phone: user.phone
    },
    JWT_SECRET,
    {
      expiresIn: "7d"
    }
  );

  res.json({

    message: "ثبت نام موفق بود",

    token,

    user: {
      id: user.id,
      phone: user.phone,
      name: user.name,
      avatar: user.avatar
    }

  });

});


// -------------------------
// ورود
// -------------------------

app.post("/login", async (req, res) => {

  const { phone, password } = req.body;

  const user =
    users.find(user => user.phone === phone);

  if (!user) {

    return res.status(401).json({
      message: "کاربر پیدا نشد"
    });

  }

  const validPassword =
    await bcrypt.compare(
      password,
      user.password
    );

  if (!validPassword) {

    return res.status(401).json({
      message: "رمز عبور اشتباه است"
    });

  }

  const token = jwt.sign(

    {
      id: user.id,
      phone: user.phone
    },

    JWT_SECRET,

    {
      expiresIn: "7d"
    }

  );

  res.json({

    message: "ورود موفق بود",

    token,

    user: {
      id: user.id,
      phone: user.phone,
      name: user.name,
      avatar: user.avatar
    }

  });

});


// -------------------------
// اطلاعات پروفایل
// -------------------------

app.get("/profile/:id", (req, res) => {

  const user =
    users.find(
      user => user.id === req.params.id
    );

  if (!user) {

    return res.status(404).json({
      message: "کاربر پیدا نشد"
    });

  }

  res.json({

    id: user.id,
    phone: user.phone,
    name: user.name,
    avatar: user.avatar

  });

});


// -------------------------
// Socket.IO
// -------------------------

io.on("connection", (socket) => {

  console.log(
    "کاربر متصل شد:",
    socket.id
  );


  socket.on("user_online", (userId) => {

    onlineUsers.set(userId, socket.id);

    io.emit("user_status", {

      userId,

      online: true

    });

  });


  socket.on("send_message", (data) => {

    io.emit("receive_message", {

      senderId: data.senderId,

      receiverId: data.receiverId,

      message: data.message,

      time: new Date().toISOString()

    });

  });


  socket.on("disconnect", () => {

    console.log(
      "کاربر قطع شد:",
      socket.id
    );

  });

});


// -------------------------
// تست سرور
// -------------------------

app.get("/", (req, res) => {

  res.send(
    "Mani Chat Server Running 🚀"
  );

});


server.listen(3000, () => {

  console.log(
    "Mani Chat Server running on port 3000"
  );

});
