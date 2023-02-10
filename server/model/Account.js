const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const accountSchema = new Schema(
  {
    accountNumber: {
      type: String,
      required: true,
    },
    balance: {
      type: mongoose.Types.Decimal128,
      default: 0,
    },
    ID: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
  },
  {
    collection: "Account",
  }
);

module.exports = mongoose.model("Account", accountSchema);
