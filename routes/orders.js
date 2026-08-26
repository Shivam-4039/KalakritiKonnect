const express = require('express');
const router = express.Router();
const Order = require('../models/Order');
const Product = require('../models/Product');
const { protect, restrictTo } = require('../middleware/auth');

router.post('/', protect, restrictTo('buyer'), async (req, res, next) => {
    try {
        const { items, shippingAddress } = req.body;
        let subtotal = 0;
        const orderItems = [];

        for (const item of items) {
            const product = await Product.findById(item.productId);
            if (!product) return res.status(404).json({ success: false, message: `Product ${item.productId} not found` });

            subtotal += product.pricing.sellingPrice * item.quantity;
            orderItems.push({
                product: product._id,
                artisan: product.artisan,
                quantity: item.quantity,
                price: product.pricing.sellingPrice,
            });
        }

        const order = await Order.create({
            buyer: req.user._id,
            items: orderItems,
            subtotal,
            totalAmount: subtotal + 50, // 50 delivery fee
            shippingAddress,
        });

        res.status(201).json({ success: true, order });
    } catch (err) {
        next(err);
    }
});

router.get('/my-orders', protect, async (req, res, next) => {
    try {
        const filter = req.user.role === 'artisan' ? { 'items.artisan': req.user._id } : { buyer: req.user._id };
        const orders = await Order.find(filter).populate('items.product').populate('buyer', 'name phone').sort({ createdAt: -1 });
        res.json({ success: true, orders });
    } catch (err) {
        next(err);
    }
});

module.exports = router;