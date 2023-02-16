const mongoose = require("mongoose");

const accountSchema = new mongoose.Schema(
  {
    accountNumber: {
      type: String,
      required: true,
    },
    balance: {
      type: Number,
      default: 0,
    },
    idNumber: {
      type: String,
      required: true,
    },
  },
  {
    collection: "Account",
  }
);

module.exports = mongoose.model("Account", accountSchema);
