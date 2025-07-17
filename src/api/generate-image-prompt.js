// src/api/generate-image-prompt.js - Main endpoint
import { GoogleGenerativeAI } from '@google/generative-ai';
import { getMyanmarImageContext, validateMyanmarContent } from '../../examples/utils/myanmar-context.js';

// Placeholder for a simple sanitize function
function sanitize(text) {
  // Implement actual sanitization logic here
  // For now, a basic escape to prevent simple injections
  return text.replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

export default async function handler(req, res) {
  // CORS headers - based on examples/api/cors-handler.js
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  
  // Handle preflight requests
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  // Only allow POST requests
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method Not Allowed' });
  }

  try {
    const { myanmarContent, geminiApiKey } = req.body;
    
    // Input validation
    if (!myanmarContent || !geminiApiKey) {
      return res.status(400).json({ 
        success: false,
        error: 'Missing myanmarContent or geminiApiKey' 
      });
    }

    // Validate Myanmar content using the utility function
    if (!validateMyanmarContent(myanmarContent)) {
      return res.status(400).json({
        success: false,
        error: 'Invalid content format or too short for Myanmar context'
      });
    }

    // Sanitize input
    const sanitizedContent = sanitize(myanmarContent);

    // Initialize Gemini
    const genAI = new GoogleGenerativeAI(geminiApiKey);
    const model = genAI.getGenerativeModel({ model: "gemini-pro" });

    // Generate Myanmar-appropriate image prompt
    const prompt = getMyanmarImageContext(sanitizedContent);
    
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const imageDescription = response.text();

    return res.status(200).json({
      success: true,
      imagePrompt: imageDescription,
      message: 'Image prompt generated successfully'
    });

  } catch (error) {
    console.error('API Error:', error);
    // Handle specific errors (e.g., invalid API key, rate limit)
    if (error.message.includes('API key not valid') || error.message.includes('invalid API key')) {
      return res.status(401).json({ 
        success: false,
        error: 'Invalid Gemini API Key',
        details: error.message 
      });
    }
    if (error.message.includes('rate limit') || error.message.includes('RESOURCE_EXHAUSTED')) {
      return res.status(429).json({ 
        success: false,
        error: 'Gemini API Rate Limit Exceeded',
        details: error.message 
      });
    }
    // Generic error for other issues
    return res.status(500).json({ 
      success: false,
      error: 'Failed to generate image prompt',
      details: error.message 
    });
  }
}
