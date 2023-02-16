const express = require("express");
const mongoose = require("mongoose");
const cors = require('cors');

const auth = require('./routes/auth');
const dashboard = require('./routes/dashboard');

const dotEnv = require("dotenv");


dotEnv.config();

const PORT = process.env.SERVER_PORT || 6800;

const app = express();

// connect to mongo db (localhost)
mongoose.connect(process.env.DB_CONNECTION, { useNewUrlParser: true }, (err) => {
  if(err) console.log(err) 
  else console.log("mongdb is connected");
});

// middlewares
app.use(cors());
app.use(express.json()); // allows for requests and responses be passed as JSON


app.use('/api/auth', auth);
app.use('/api/dashboard', dashboard);


// start the server
app.listen(PORT, () =>
  console.log(`Server started and running on port: ${PORT}`)
);
