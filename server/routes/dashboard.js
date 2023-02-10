const router = require('express').Router();
const verifyToken = require('./verifyToken');


const Account = require('../model/Account')


// protected route for balance retrieval
router.get('/balance', verifyToken, async (req, res, next) => {
    const {ID} = verifyToken;
    const { balance } = await Account.findOne({ID: ID});
    res.json({message: balance});
});

// withdraw cash route
router.post('/withdraw', verifyToken, (req, res, next) => {
   const account = new Account({
    
   });

   res.send(verifyToken);

});

// deposit cash route
router.post('/deposit', verifyToken, (req, res, next) => {
    res.send(verifyToken);
});

module.exports = router;