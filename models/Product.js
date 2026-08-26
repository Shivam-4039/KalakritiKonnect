const mongoose = require('mongoose');

const productSchema = new mongoose.Schema(
    {
        artisan: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
        name: { type: String, required: true, trim: true },
        nameLocal: { type: String, default: '' },
        description: { type: String, required: true },
        category: {
            type: String,
            required: true,
            enum: [
                'Textiles', 'Pottery', 'Woodwork', 'Metalwork',
                'Jewelry', 'Paintings', 'Basketry', 'Leather',
                'Stone Craft', 'Bamboo Craft', 'Other'
            ],
        },
        subCategory: { type: String, default: '' },
        craftTechnique: { type: String, default: '' },
        images: [{ url: { type: String, required: true }, publicId: String }],
        materials: { type: [String], default: [] },
        dimensions: {
            length: { type: Number, default: 0 },
            width: { type: Number, default: 0 },
            height: { type: Number, default: 0 },
            weight: { type: Number, default: 0 },
            unit: { type: String, default: 'cm' },
        },
        colors: { type: [String], default: [] },
        pricing: {
            costPrice: { type: Number, default: 0 },
            aiSuggestedPrice: { type: Number, default: 0 },
            sellingPrice: { type: Number, required: true },
            currency: { type: String, default: 'INR' },
        },
        stock: { type: Number, default: 1 },
        madeToOrder: { type: Boolean, default: false },
        productionTime: { type: Number, default: 1 },
        tags: { type: [String], default: [] },
        giTag: { type: String, default: '' },
        region: { type: String, default: '' },
        qualityScore: { type: Number, default: 5 },
        status: {
            type: String,
            enum: ['draft', 'active', 'sold', 'inactive'],
            default: 'active',
        },
        views: { type: Number, default: 0 },
        wishlistCount: { type: Number, default: 0 },
        reviews: [
            {
                buyer: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
                rating: { type: Number, min: 1, max: 5 },
                comment: String,
                createdAt: { type: Date, default: Date.now },
            },
        ],
        averageRating: { type: Number, default: 0 },
    },
    { timestamps: true }
);

productSchema.index({ name: 'text', description: 'text', tags: 'text' });
productSchema.index({ category: 1, status: 1 });

module.exports = mongoose.model('Product', productSchema);