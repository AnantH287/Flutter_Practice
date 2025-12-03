const { db2 } = require("../db");
const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
require("dotenv").config();

router.post("/logins", (req, res) => {
    const { email, password } = req.body;
    console.log("Received login:", email, password);

    if (!email || !password) {
        return res.status(400).send({ message: "Email & Password required" });
    }

    const selectQuery = `SELECT id, email, userpassword, username
                         FROM usercreation WHERE email = ?`;

    db2.query(selectQuery, [email], (err, result) => {
        if (err) {
            console.log("Query error:", err);
            return res.status(500).send({ message: `Query failed: ${err}` });
        }

        if (result.length === 0) {
              console.log("second if condition");
            return res.status(400).send({ message: "Invalid Email or Password" });
        }

        const user = result[0];

        if (user.userpassword !== password) {
              console.log("third if condition");
            return res.status(400).send({ message: "Invalid Email or Password" });
        }


        const token = jwt.sign(
            { id: user.id, email: user.email },
           process.env.SECRET_KEY,
            { expiresIn: "1d" }
        );

        console.log("vvvvvvvvvvvvvv : ",token,);

        return res.status(200).send({
            success: true,
            token: token,
            user: {
                id: user.id,
                email: user.email,
                name: user.username
            }
        });
    });
});

module.exports = router;
