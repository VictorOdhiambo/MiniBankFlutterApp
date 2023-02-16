const Joi = require('joi');

const validateUserSignUp = (data) => {
    const schema = Joi.object({
        name: Joi.string().min(6).max(100).required(),
        email: Joi.string().min(6).max(100).required().email(),
        idNumber: Joi.string().min(6).max(20).required(),
        password: Joi.string().min(6).max(20).required()
    });

    return schema.validate(data);
}


const validateUserLogon = (data) => {
    const schema = Joi.object({
        email: Joi.string().min(6).max(100).required().email(),
        password: Joi.string().min(6).max(20).required(),
        idNumber: Joi.string().allow(null).optional(),
        name: Joi.string().allow(null).optional()
    });

    return schema.validate(data);
}


const validateAccount = (data) => {
    const schema = Joi.object({
        accountNumber: Joi.string().min(6).max(100).required(),
        balance: Joi.number().min(1).max(20).required(),
        ID: Joi.string().min(6).max(20).required()
    });

    return schema.validate(data);
}

module.exports.validateUserSignUp = validateUserSignUp;
module.exports.validateUserLogon = validateUserLogon;
module.exports.validateAccount = validateAccount;