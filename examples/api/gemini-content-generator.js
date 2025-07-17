import { GoogleGenerativeAI } from ' @google/generative-ai';

export default async function handler(req, res) {
  // Basic Gemini API integration pattern
  try {
    const { content, apiKey } = req.body;
    
    const genAI = new GoogleGenerativeAI(apiKey);
    const model = genAI.getGenerativeModel({ model: "gemini-pro" });

    const result = await model.generateContent(content);
    const response = await result.response;
    const text = response.text();

    return res.status(200).json({
      success: true,
      generatedContent: text
    });

  } catch (error) {
    return res.status(500).json({ 
      success: false,
      error: error.message 
    });
  }
}