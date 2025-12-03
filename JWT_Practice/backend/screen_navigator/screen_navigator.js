const express = require("express");
const router = express.Router();
const {verifyToken,tokenVerify} = require("../../verifyToken");


router.get("/indoor",tokenVerify,(req,res)=>{
    res.status(200).send({ message : `${req.user.email}, this is Indoor data`, status : true})
})

router.get("/outdoor",verifyToken,(req,res)=>{
    res.send({ message :`${req.user.email}, this is Outdoor data`, status : true})
})

module.exports = router;
