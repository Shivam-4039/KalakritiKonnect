const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const { protect } = require('../middleware/auth');

const signToken = (userId) => jwt.sign({ userId }, process.env.JWT_SECRET, { expiresIn: '30d' });

router.post('/register', async (req, res, next) => {
    try {
        const { name, phone, password, role, language } = req.body;
        const existing = await User.findOne({ phone });
        if (existing) return res.status(400).json({ success: false, message: 'Phone already registered.' });

        const user = await User.create({ name, phone, password, role: role || 'artisan', language: language || 'hi' });
        const token = signToken(user._id);

        res.status(201).json({ success: true, token, user });
    } catch (err) {
        next(err);
    }
});

router.post('/login', async (req, res, next) => {
    try {
        const { phone, password } = req.body;
        const user = await User.findOne({ phone }).select('+password');
        if (!user || !(await user.comparePassword(password))) {
            return res.status(401).json({ success: false, message: 'Invalid phone or password.' });
        }

        const token = signToken(user._id);
        user.password = undefined;
        res.json({ success: true, token, user });
    } catch (err) {
        next(err);
    }
});

router.post('/send-otp', async (req, res, next) => {
    try {
        const { phone, name, role } = req.body;
        let user = await User.findOne({ phone });

        if (!user) {
            user = await User.create({ name: name || 'Artisan', phone, role: role || 'artisan' });
        }

        const otp = user.generateOTP();
        await user.save();
        console.log(`📱 Generated OTP for ${phone}: ${otp}`);

        res.json({ success: true, message: 'OTP sent successfully', otp: process.env.NODE_ENV === 'development' ? otp : undefined });
    } catch (err) {
        next(err);
    }
});

router.post('/verify-otp', async (req, res, next) => {
    try {
        const { phone, otp } = req.body;
        const user = await User.findOne({ phone });
        if (!user || !user.verifyOTP(otp)) {
            return res.status(400).json({ success: false, message: 'Invalid or expired OTP.' });
        }

        user.otp = undefined;
        user.isVerified = true;
        await user.save();

        const token = signToken(user._id);
        res.json({ success: true, token, user });
    } catch (err) {
        next(err);
    }
});

router.get('/me', protect, (req, res) => {
    res.json({ success: true, user: req.user });
});

module.exports = router;