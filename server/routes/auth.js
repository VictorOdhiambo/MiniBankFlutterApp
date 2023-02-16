const router = require("express").Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const dotEnv = require("dotenv");


dotEnv.config();


// import user model
const User = require("../model/User");
const Account = require("../model/Account");
const Transaction = require("../model/Transaction");


const {
  validateUserSignUp,
  validateUserLogon,
} = require("../validations/validate");


// create an account route
router.post("/create-account", async (req, res) => {
  console.log(req.body)
  // validate the payload
  const { error } = validateUserSignUp(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  const user = new User({
    name: req.body.name,
    email: req.body.email,
    idNumber: req.body.idNumber,
    password: req.body.password,
  });

  // create a hashed password
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(user.password, salt);

  // update user password
  user.password = hashedPassword;

  // check if the user already has an account
  User.findOne({ email: req.body.email })
    .then((data) => {
      if (data)
        return res
          .status(200)
          .send("A user with the given email already exists");

      // save user
      user
        .save()
        .then(
          createAccountNumber(res, user._id)
          //res.status(200).json({ message: "Account creation was successful" })
        )
        .catch((err) => res.status(400).send("Error saving user: " + err ));
    })
    .catch((err) => {
      res.status(400).send("Error saving user: " + err )
    });
});

const createAccountNumber = (res, userId) => {
  const account = new Account({
    accountNumber: Math.floor(Math.random() * 10000000000),
    balance: 500, // minumum balance.
    idNumber: userId,
  });

  account
    .save()
    .then((acc) => createUserTransactionalCount(res, userId))
    .catch((err) =>
      res
        .status(400)
        .send("Account creation failed. Contact system administrator")
    );
};

const createUserTransactionalCount = (res, _userId) => {
  const transaction = new Transaction({
    userId: _userId
  });

  transaction.save()
  .then(data => res.status(200).send("Account creation was successful"))
  .catch (err => res
    .status(400)
    .send("Account creation failed. Contact system administrator"))
}

// sign in route
router.post("/sign-in", (req, res) => {
  console.log(req.body);
  // validate the payload
  const { error } = validateUserLogon(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  const user = new User({
    email: req.body.email,
    password: req.body.password,
  });

  // validate user
  User.findOne({ email: user.email })
    .then((data) => {
      if (data) {
        // validate password
        console.log(data);
        bcrypt
          .compare(user.password, data.password)
          .then((match) => {
            if (!match)
              return res
                .status(400)
                .send("Login failed: Incorrect username or password");
            const token = jwt.sign({ id: data._id }, process.env.SERVER_SECRET_KEY);
            res.header("auth-token", token).send({ token: token, ID: data._id });
          })
          .catch((err) => res.status(400).send('Error signing in ' + err));
      } else {
        console.log('login failed')
        return res
          .status(400)
          .send(`Login failed: Incorrect username or password`);
      }
    })
    .catch((err) => {
      console.log(err)
      res.status(400).send(err);
    });
});

module.exports = router;
