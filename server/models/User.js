
const mongoose = require('mongoose');


const UserSchema = new mongoose.Schema({
    username: {type:String, required: true},
    email: {type:String, required: true},
    password:{type:String, required: true},
    favourites : [{
        id:String,
        url:String,
        description:String,
        photographer:String,
    },
  ],
});

module.exports = mongoose.model("User", UserSchema)