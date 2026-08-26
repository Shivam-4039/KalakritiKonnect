# 🎨 AI-Driven Market Linkage & Smart Cataloging Mobile Application for Marginalized Artisans

> **Smart India Hackathon (SIH) Solution** | Backend API & AI Engine

An AI-powered backend service designed to empower traditional Indian artisans by converting product photos into structured marketplace listings, suggesting fair market prices, and linking artisans directly with buyers.

---

## 🚀 Features

- **📸 AI Smart Cataloging**: Automatically extracts product category, craft technique, materials, region, and tags from a single image using Google Gemini AI.
- **💰 Fair Price Suggestion**: Recommends minimum, maximum, and suggested retail prices to prevent artisan exploitation.
- **🔐 Multi-Authentication**: Phone OTP authentication for artisans and email/password login for buyers.
- **🛒 Order & Payment System**: Integrated Razorpay checkout flow and order management.
- **📊 Artisan Dashboard**: Real-time sales analytics and product performance stats.
- **💬 Real-Time Chat**: Socket.io integration for buyer-artisan communication.

---

## 🛠️ Tech Stack

- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: MongoDB (Mongoose ODM)
- **AI Engine**: Google Gemini API (`@google/generative-ai`)
- **Image Storage**: Cloudinary
- **Authentication**: JWT + Custom OTP Logic
- **Payments**: Razorpay Node.js SDK
- **Real-Time**: Socket.io

---

## ⚡ Quick Setup for Teammates

### 1. Clone the repository
```bash
git clone https://github.com/Shivam-4039/KalakritiKonnect.git
cd KalakritiKonnect