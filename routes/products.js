const express = require('express');
const router = express.Router();
const Product = require('../models/Product');
const { protect, restrictTo } = require('../middleware/auth');

router.get('/', async (req, res, next) => {
    try {
        const { category, minPrice, maxPrice, search, page = 1, limit = 20 } = req.query;
        const filter = { status: 'active' };

        if (category) filter.category = category;
        if (search) filter.$text = { $search: search };
        if (minPrice || maxPrice) {
            filter['pricing.sellingPrice'] = {};
            if (minPrice) filter['pricing.sellingPrice'].$gte = Number(minPrice);
            if (maxPrice) filter['pricing.sellingPrice'].$lte = Number(maxPrice);
        }

        const products = await Product.find(filter)
            .populate('artisan', 'name phone artisanProfile')
            .skip((page - 1) * limit)
            .limit(Number(limit))
            .sort({ createdAt: -1 });

        const total = await Product.countDocuments(filter);

        res.json({ success: true, total, products });
    } catch (err) {
        next(err);
    }
});

router.get('/:id', async (req, res, next) => {
    try {
        const product = await Product.findById(req.params.id).populate('artisan', 'name phone artisanProfile');
        if (!product) return res.status(404).json({ success: false, message: 'Product not found.' });

        product.views += 1;
        await product.save();
        res.json({ success: true, product });
    } catch (err) {
        next(err);
    }
});

router.get('/artisan/my-products', protect, restrictTo('artisan'), async (req, res, next) => {
    try {
        const products = await Product.find({ artisan: req.user._id }).sort({ createdAt: -1 });
        res.json({ success: true, products });
    } catch (err) {
        next(err);
    }
});

module.exports = router;