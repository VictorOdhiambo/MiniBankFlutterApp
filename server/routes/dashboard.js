const router = require('express').Router();
const Account = require('../model/Account')


// protected route for balance retrieval
router.get('/balance/:id', async (req, res) => {
    const {id} = req.params;
    const {balance} = await Account.findOne({idNumber: id});
    res.send({"balance": balance});
});

// withdraw cash route
router.put('/withdraw/:id', async (req, res, next) => {
    const {id} = req.params;
    const amount = parseInt(req.body.amount);
    if (amount > 20000){
        return res.status(400).send('Exceeded maximum withdrawal per transaction');
    }
   const account = await Account.findOne({idNumber: id});
   
   // check available balance 
   if (account.balance < amount){
    return res.status(400).send('You do not have sufficient balance for withdrawal');
   }

   // update balance
   account.balance -= amount;
   account.save().
   then(acc => res.status(200).send('Withdrawal successfully'))
   .catch(err => res.status(400).send('Withdrawal was unsuccessful'));

});

// deposit cash route
router.put('/deposit/:id', async (req, res, next) => {
    const {id} = req.params;
    const amount = parseInt(req.body.amount);
    if (amount > 40000){
        return res.status(400).send('Exceeded maximum deposit per transaction');
    }
   const account = await Account.findOne({idNumber: id});

   // update balance
   account.balance += amount;
   account.save().
   then(acc => res.status(200).send('Deposit successfully'))
   .catch(err => res.status(400).send('Deposit was unsuccessful'));
});

module.exports = router;