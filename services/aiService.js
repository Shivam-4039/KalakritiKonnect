const { GoogleGenerativeAI } = require('@google/generative-ai');

const getAIClient = () => {
    if (!process.env.GEMINI_API_KEY || process.env.GEMINI_API_KEY.includes('your_gemini')) {
        throw new Error('Valid GEMINI_API_KEY is missing in your .env file');
    }
    return new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
};

const analyzeProductImage = async (imageBuffer, mimeType) => {
    const genAI = getAIClient();
    const model = genAI.getGenerativeModel({ model: 'gemini-1.5-flash' });

    const imagePart = {
        inlineData: {
            data: imageBuffer.toString('base64'),
            mimeType: mimeType || 'image/jpeg',
        },
    };

    const prompt = `
    You are an AI expert in Indian traditional handicrafts and artisan items.
    Analyze this product photo and return ONLY a valid JSON object:
    {
      "productName": "Concise English Name",
      "productNameHindi": "Hindi Name",
      "category": "Pick exactly one: Textiles, Pottery, Woodwork, Metalwork, Jewelry, Paintings, Basketry, Leather, Stone Craft, Bamboo Craft, Other",
      "subCategory": "Specific type e.g. Terracotta Vase, Silk Saree",
      "description": "2-3 sentences description highlighting craftsmanship",
      "craftTechnique": "Technique name e.g. Dhokra, Madhubani, Block Print",
      "materials": ["Material 1", "Material 2"],
      "colors": ["Color 1", "Color 2"],
      "region": "State or Region of origin in India",
      "giTag": "Name of GI Tag if applicable or empty string",
      "estimatedPriceMin": 300,
      "estimatedPriceMax": 800,
      "tags": ["handmade", "authentic", "craft"],
      "qualityScore": 8
    }
  `;

    const result = await model.generateContent([prompt, imagePart]);
    const text = result.response.text();
    const jsonMatch = text.match(/\{[\s\S]*\}/);
    if (!jsonMatch) throw new Error('Failed to extract JSON from AI response');
    return JSON.parse(jsonMatch[0]);
};

module.exports = { analyzeProductImage };