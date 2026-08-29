const mongoose = require('mongoose');

const connectDB = async () => {
    const uri = process.env.MONGODB_URI;

    if (!uri) {
        console.error('❌ MONGODB_URI missing in .env');
        process.exit(1);
    }

    try {
        const conn = await mongoose.connect(uri, {
            family: 4,
            serverSelectionTimeoutMS: 10000,
        });
        console.log(`✅ MongoDB Connected: ${conn.connection.host}`);
    } catch (error) {
        console.error(`❌ MongoDB Connection Error: ${error.message}`);
        console.error('Retrying in 5 seconds...');
        setTimeout(connectDB, 5000); // retry instead of hard crash loop
    }
};

module.exports = connectDB;