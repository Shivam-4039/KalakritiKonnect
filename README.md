# 🎨 KalakritiKonnect — AI-Driven Market Linkage & Smart Cataloging for Artisans

> **Smart India Hackathon (SIH) Solution** | Complete Monorepo (Backend API & Flutter Frontend)

An enterprise-grade AI solution designed to empower traditional Indian artisans by converting voice descriptions and craft photos into structured marketplace listings, protecting artisans with cryptographic Fair Price Shields, providing seasonal Demand Radar analytics, and authenticating heritage craft items.

---

## 📁 Repository Structure

This repository is organized as a monorepo containing both the backend service and the mobile client application:
- **Backend API**: Node.js & Express application powered by Google Gemini AI, MongoDB, Socket.io, Cloudinary, and Razorpay.
- **Frontend App**: Flutter mobile/desktop application for artisans and buyers.

---

## 📱 Frontend Application (Flutter)

A Flutter-based frontend client for artisans and buyers to interact with the KalakritiKonnect ecosystem.

### Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

## ⚙️ Backend Service (Express.js & Node.js)

The backend service coordinates AI processing, database management, real-time analytics, and payments.

### 🌟 5 Core Innovation Features

#### 1. 🎙️ AI Voice / Transcript Cataloging
- Converts spoken transcripts in **Hindi**, **Hinglish**, or **English** into structured marketplace catalogs using Google Gemini AI (`gemini-1.5-flash`).
- Automatically extracts product names (in English & Hindi), categories, craft techniques, raw materials, estimated production cost, production timeline, region, and fair minimum price.
- Issues a tamper-proof, **HMAC-signed catalog draft token** (`catalogDraftToken`) to prevent client-side tampering before confirmation.

#### 2. 🛡️ Fair Price Protection Shield & Draft Confirmation
- Protects artisans from underpricing exploitation.
- Server validates the signed `catalogDraftToken` to verify the original AI-evaluated fair minimum price (`aiMinPrice`).
- If an artisan attempts to list an item below fair value, the API flags `isUnderpriced: true`, computes `fairPriceGap`, and issues a protective warning alert.

#### 3. 📡 Demand Radar Engine & Seasonal Insights
- Aggregates 30-day time-series product views, wishlist additions, search trends, and completed sales.
- Incorporates real-time **Indian festive & seasonal multipliers** (Diwali, Holi, Rakhi, Wedding/Winter season).
- Generates actionable category demand scores, top rising search tags, recommended crafts to make, and localized Hindi insights (`insightSummaryHindi`).

#### 4. 🏛️ Heritage Authenticity Score & Badging
- Computes an automated 0–100 **Authenticity Score** for every craft product dynamically.
- Automatically assigns verified credibility badges:
  - `GI Verified` / `GI Tag Declared` (+30 pts)
  - `Direct Artisan` (+25 pts)
  - `SHG Member` (Self-Help Group) (+20 pts)
  - `Handmade Technique Identified` (+25 pts)
  - `Fair Price Verified`

#### 5. 💬 WhatsApp Bot Multimodal Craft Cataloging
- Enables marginalized artisans without smartphones or complex apps to list items via WhatsApp.
- Features **SSRF-protected safe image ingestion** (blocks private networks, enforces 8 MB size limits, validates MIME types).
- Processes craft photos using Gemini multimodal vision and generates instant localized WhatsApp confirmation messages with suggested price ranges and confirmation tokens.

---

### 🛠️ Backend Tech Stack

- **Runtime**: Node.js (v18+)
- **Framework**: Express.js
- **Database**: MongoDB (Mongoose ODM) with time-series daily analytics
- **AI Engine**: Google Gemini API (`@google/generative-ai`)
- **Security & Integrity**: Crypto HMAC-SHA256 draft signatures, SSRF-safe URL validation, Helmet, Rate Limiting, JWT
- **Real-Time Communication**: Socket.io
- **Media & Payments**: Cloudinary SDK & Razorpay SDK

---

### ⚙️ Environment Configuration (`.env`)

Create a `.env` file in the root folder with the following variables:

```env
# Server
PORT=5000
NODE_ENV=development
JWT_SECRET=your_super_secret_jwt_key

# Database
MONGODB_URI=mongodb+srv://<username>:<password>@cluster0.mongodb.net/artisan-market?appName=Cluster0

# Google Gemini AI
GEMINI_API_KEY=your_google_gemini_api_key
GEMINI_MODEL=gemini-1.5-flash

# Cryptographic Draft & Bot Secrets
CATALOG_DRAFT_SECRET=your_random_64_char_hex_secret_here
WHATSAPP_BOT_SECRET=your_whatsapp_webhook_secret_here

# Cloudinary Storage
CLOUDINARY_CLOUD_NAME=your_cloudinary_name
CLOUDINARY_API_KEY=your_cloudinary_key
CLOUDINARY_API_SECRET=your_cloudinary_secret

# Razorpay Payments
RAZORPAY_KEY_ID=rzp_test_your_key_id
RAZORPAY_KEY_SECRET=your_razorpay_secret
```

---

### 🚀 Quick Start Guide

#### 1. Install Dependencies
```bash
npm install
```

#### 2. Run the Development Server
```bash
npm run dev
```

#### 3. Run in Production Mode
```bash
npm start
```

The API will be available at: `http://localhost:5000`

---

### 📚 API Reference & Endpoints

#### 1. Voice Cataloging
- **Endpoint**: `POST /api/catalog/voice-catalog`
- **Auth**: `Bearer <artisan_jwt>` (Role: `artisan`)
- **Body**:
```json
{
  "transcript": "Main Rajasthan se hoon. Maine mitti ka handmade terracotta diya banaya hai. Ek diya banane mein 40 rupaye lagte hain aur 2 din lagte hain.",
  "language": "hi"
}
```
- **Response**:
```json
{
  "success": true,
  "message": "Catalog draft generated successfully.",
  "draftProductData": {
    "productName": "Handcrafted Terracotta Diya",
    "productNameHindi": "हस्तनिर्मित मिट्टी का दीया",
    "category": "Pottery",
    "craftTechnique": "Terracotta Pottery",
    "materials": ["Clay", "Natural Colors"],
    "estimatedCost": 40,
    "sellingPrice": 150,
    "productionDays": 2,
    "region": "Rajasthan",
    "aiMinPrice": 120
  },
  "catalogDraftToken": "eyJhbGciOiJIUzI1NiIs..."
}
```

#### 2. Confirm Product Listing (with Fair Price Shield)
- **Endpoint**: `POST /api/catalog/confirm`
- **Auth**: `Bearer <artisan_jwt>` (Role: `artisan`)
- **Body**:
```json
{
  "catalogDraftToken": "eyJhbGciOiJIUzI1NiIs...",
  "sellingPrice": 90,
  "underpriceWarningDismissed": false,
  "images": ["https://res.cloudinary.com/demo/image/upload/diya.jpg"],
  "giTag": {
    "name": "Rajasthan Terracotta",
    "code": "GI-RAJ-01"
  }
}
```
- **Response**:
```json
{
  "success": true,
  "message": "Product listing confirmed successfully.",
  "product": { ... },
  "priceProtection": {
    "aiMinPrice": 120,
    "isUnderpriced": true,
    "fairPriceGap": 30,
    "underpriceWarningDismissed": false,
    "warning": "Price is below fair market value of ₹120. Potential earnings loss."
  }
}
```

#### 3. Demand Radar & Seasonal Insights
- **Endpoint**: `GET /api/market/demand-insights`
- **Auth**: Public
- **Response**:
```json
{
  "success": true,
  "trendingCategories": [
    {
      "category": "Pottery",
      "demandScore": 450,
      "avgSellingPrice": 350,
      "searchGrowth": 45,
      "views": 220,
      "wishlistCount": 38,
      "unitsSold": 24,
      "seasonalMultiplier": 1.4
    }
  ],
  "trendingSearchTags": [
    { "tag": "diya", "count": 120, "growth": 65 },
    { "tag": "terracotta", "count": 85, "growth": 30 }
  ],
  "recommendedCraftsToMake": [
    "Terracotta Diyas",
    "Handcrafted Terracotta Planters"
  ],
  "insightSummaryHindi": "Is mahine Pottery items ki maang 45% badhi hai. Diwali Season ke karan seasonal demand bhi badh rahi hai.",
  "seasonalContext": {
    "name": "Diwali Season",
    "multiplier": 1.4
  }
}
```

#### 4. Product Details with Heritage Authenticity Score
- **Endpoint**: `GET /api/products/:id`
- **Auth**: Public
- **Response**:
```json
{
  "success": true,
  "product": {
    "_id": "65f123...",
    "name": "Handcrafted Terracotta Diya",
    "sellingPrice": 150,
    "authenticityScore": 100,
    "authenticityBadges": [
      "GI Tag Declared",
      "Direct Artisan",
      "SHG Member",
      "Handmade Technique Identified",
      "Fair Price Verified"
    ],
    "artisan": {
      "name": "Ramesh Kumar",
      "phone": "+919876543210",
      "artisanProfile": {
        "story": "Generational potter practicing terracotta clay art.",
        "location": { "district": "Jaipur", "state": "Rajasthan", "isVerified": true },
        "isSHGMember": true
      }
    }
  }
}
```

#### 5. WhatsApp Bot Craft Image Ingestion
- **Endpoint**: `POST /api/catalog/whatsapp-bot`
- **Headers**: `x-whatsapp-bot-secret: your_whatsapp_webhook_secret_here`
- **Body**:
```json
{
  "phone": "+919876543210",
  "imageUrl": "https://res.cloudinary.com/demo/image/upload/terracotta-pot.jpg",
  "userLanguage": "hi"
}
```
- **Response**:
```json
{
  "success": true,
  "artisanFound": true,
  "whatsappReplyText": "*Artisan AI Assistant*\n\nNamaskar! Humne aapke utpad ko pehchan liya hai:\n\n*Naam:* Handcrafted Terracotta Pot\n*Uchit Mulya:* ₹450 - ₹600\n\nKya aap ise bazaar me bechna chahte hain? Confirm karne ke liye *HAAN* reply karein.",
  "draftProductData": {
    "productName": "Handcrafted Terracotta Pot",
    "aiMinPrice": 450,
    "suggestedPriceMin": 450,
    "suggestedPriceMax": 600
  },
  "catalogDraftToken": "eyJhbGciOiJIUzI1NiIs..."
}
```

---

### 🔒 Security & Architecture Highlights

1. **HMAC-SHA256 Signed Draft Tokens**: Fair price values cannot be altered on the client side; the server validates draft tokens using timing-safe cryptographic comparisons.
2. **SSRF Protection**: Image URLs for the WhatsApp bot are strictly validated to block private IPv4/IPv6 ranges (e.g. `127.0.0.1`, `10.0.0.0/8`, `192.168.0.0/16`, `169.254.0.0/16`).
3. **Public DNS SRV Fallback**: Configured with Google & Cloudflare DNS (`8.8.8.8`, `1.1.1.1`) to resolve MongoDB Atlas connections on Windows networks.
4. **Time-Series Analytics Retention**: Daily demand analytics automatically prune records older than 90 days.

---

## 👨‍💻 Author & Maintainer

- **Developer**: [Sidhant Gautam](https://github.com/Sidhant-Gautam-25)
- **Repository**: [https://github.com/Sidhant-Gautam-25/kalakriti](https://github.com/Sidhant-Gautam-25/kalakriti)
