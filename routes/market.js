const express = require('express');
const router = express.Router();
const Product = require('../models/Product');
const Order = require('../models/Order');
const { protect } = require('../middleware/auth');

router.get('/recommendations', async (req, res, next) => {
    try {
        const products = await Product.find({ status: 'active' }).populate('artisan', 'name artisanProfile').limit(10);
        res.json({ success: true, recommendations: products });
    } catch (err) {
        next(err);
    }
});

router.get('/artisan-dashboard', protect, async (req, res, next) => {
    try {
        const totalProducts = await Product.countDocuments({ artisan: req.user._id });
        const orders = await Order.find({ 'items.artisan': req.user._id });

        const totalRevenue = orders.reduce((sum, ord) => sum + ord.totalAmount, 0);

        res.json({
            success: true,
            stats: {
                totalProducts,
                totalOrders: orders.length,
                totalRevenue,
            },
        });
    } catch (err) {
        next(err);
    }
});

module.exports = router;