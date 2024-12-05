
const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');


require('dotenv').config();

// register route
router.post("/register", async (req, res) => {
    const { username, email, password } = req.body;
  
    if (!username || !email || !password) {
      return res.status(400).json({ msg: "Please enter all fields" });
    }
  
    try {
        const existingUser = await User.findOne({ email });
      if (existingUser)
        return res.status(400).json({ msg: "User already exists" });
  
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(password, salt);
  
      const newUser = new User({
        username,
        email,
        password: hashedPassword,
      });
  
      const savedUser = await newUser.save();
  
      const token = jwt.sign({ id: savedUser._id }, process.env.JWT_SECRET, {
        expiresIn: "1h",
      });
  
      res.json({
        token,
        user: {
          id: savedUser._id,
          username: savedUser.username,
          email: savedUser.email,
        },
      });
    } catch (err) {
      res.status(500).json({ msg: "Server error" });
    }
  });

// login route

router.post("/login", async(req, res)=>{

    const {email, password} = req.body;
    if(!email || !password){
        return res.status(400).json({msg: "please enter all the fields"});
    }
    try{

        const user = await User.findOne({email});
        if(!user) {
            return res.status(400).json({msg:"user does not exist"});
        } 
        const isMatch =  await bcrypt.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg:"invalid password"});
        }

        const token = jwt.sign({id: user._id},process.env.JWT_SECRET,{
            expiresIn:"1h",
        });

        res.json({
            token,
            user: {
              id: user._id,
              username: user.username,
              email: user.email,
            },
            message: "Login successful",
          });

    } catch {
        return res.status(500).json({msg:"server error"});
    }
});

module.exports = router;