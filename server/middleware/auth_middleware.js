
const jwt = require('jsonwebtoken');



const authMiddleware = (req, res, next) => {

    const token = req.header("x-auth-token");

    // check if token is provide
    if(!token){
        return res.status(401).json({msg:"No token, authorization denied"});
    } 
    console.log(token);

    try{
        // verfify token;
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded;
        next();

    } catch(err){
        // console.err("Token verification error",err.message);

        if(err.name === "jwt expired"){
            return res.status(401).json({msg:"Token has expired"});
        }
        return res.status(400).json({msg:"Token is not valid"});
    }
};

module.exports = authMiddleware

