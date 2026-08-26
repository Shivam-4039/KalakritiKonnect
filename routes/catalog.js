const express = require('express');
const router = express.Router();
const { protect, restrictTo } = require('../middleware/auth');
const upload = require('../middleware/upload');
const { analyzeProductImage } = require('../services/aiService');
const { uploadProductImage } = require('../services/imageService');
const Product = require('../models/Product');

// Smart AI Catalog endpoint: Image -> Structured listing
router.post('/smart-catalog', protect, restrictTo('artisan'), upload.single('image'), async (req, res, next) => {
    try {
        if (!req.file) {
            return res.status(400).json({ success: false, message: 'Please upload an image file.' });
        }

        // 1. Upload to Cloudinary / storage
        const uploadedImage = await uploadProductImage(req.file.buffer, req.user._id);

        // 2. Pass to Gemini for analysis
        const aiData = await analyzeProductImage(req.file.buffer, req.file.mimetype);

        // 3. Return combined payload for review
        res.json({
            success: true,
            message: 'AI Smart Cataloging complete!',
            data: {
                image: uploadedImage,
                ...aiData,
                pricing: {
                    suggestedPrice: Math.round((aiData.estimatedPriceMin + aiData.estimatedPriceMax) / 2),
                    minPrice: aiData.estimatedPriceMin,
                    maxPrice: aiData.estimatedPriceMax,
                },
            },
        });
    } catch (err) {
        next(err);
    }
});

// Confirm & publish the product
router.post('/confirm', protect, restrictTo('artisan'), async (req, res, next) => {
    try {
        const { name, description, category, craftTechnique, materials, colors, region, giTag, images, sellingPrice, stock } = req.body;

        const product = await Product.create({
            artisan: req.user._id,
            name,
            description,
            category: category || 'Other',
            craftTechnique,
            materials: materials || [],
            colors: colors || [],
            region,
            giTag,
            images: images || [],
            pricing: { sellingPrice: Number(sellingPrice) || 500 },
            stock: Number(stock) || 1,
            status: 'active',
        });

        res.status(201).json({ success: true, message: 'Product listed successfully!', product });
    } catch (err) {
        next(err);
    }
});

module.exports = router;