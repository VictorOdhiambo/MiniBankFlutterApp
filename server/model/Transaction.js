const mongoose = require('mongoose');


const transactionSchema = new mongoose.Schema({
    userId: {
        type: String,
        required: true
    },
    withdrawalCount: {
        type: Number,
        default: 0
    },
    depositCount: {
        type: Number,
        default: 0
    }
}, {collection: "Transactions"}
);

module.exports = mongoose.model("Transaction", transactionSchema);