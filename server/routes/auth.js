const router = require("express").Router();
const bcrypt = require('bcryptjs');
const jwt = require("jsonwebtoken");

// import user model
const User = require("../model/User");
const { validateUserSignUp, validateUserLogon } = require("../validations/validate");

// create an account route
router.post("/create-account", async (req, res) => {
  // validate the payload
  const { error } = validateUserSignUp(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  const user = new User({
    name: req.body.name,
    email: req.body.email,
    ID: req.body.id,
    password: req.body.password
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
        user.save()
        .then(res.status(200).json({message: 'Account creation was successful'}))
        .catch(err => res.json({message: 'Error saving user: ' + err}))
        })
    .catch((err) => {});
});

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
       bycrypt
         .compare(user.password, data.password)
         .then((match) => {
           if (!match)
             return res.status(400).send("Login failed: Incorrect username or password");
             const token = jwt.sign({id: data._id}, process.env.SECRET_TOKEN);
           res.header('auth-token', token).send({token: token, ID: data.ID});
         })
         .catch((err) => res.status(400).send(err));
     } else {
       return res.status(400).send(`Login failed: Incorrect username or password`);
     }
   })
   .catch((err) => {
     res.send(err);
   });


});

module.exports = router;
