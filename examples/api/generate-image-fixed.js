// Fixed version of generate-image endpoint
import { GoogleGenerativeAI } from ' @google/generative-ai';

export default async function handler(req, res) {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ 
      success: false,
      error: 'Method not allowed' 
    });
  }

  try {
    const { content, apiKey } = req.body;
    
    if (!content || !apiKey) {
      return res.status(400).json({ 
        success: false,
        error: 'Content and API key are required' 
      });
    }

    const genAI = new GoogleGenerativeAI(apiKey);
    const model = genAI.getGenerativeModel({ model: "gemini-pro" });

    const imagePrompt = `Based on this Myanmar content, create a detailed image description for a Facebook post:

Content: "${content}"

Generate a culturally appropriate image description that includes:
- Visual elements that complement the content
- Myanmar cultural context and aesthetics
- Appropriate colors, mood, and composition
- Social media friendly visual appeal

Respond with only the image description, no additional text.`;

    const result = await model.generateContent(imagePrompt);
    const response = await result.response;
    const imageDescription = response.text();

    return res.status(200).json({
      success: true,
      imagePrompt: imageDescription,
      message: 'Image prompt generated successfully'
    });

  } catch (error) {
    console.error('Error generating image prompt:', error);
    return res.status(500).json({ 
      success: false,
      error: 'Failed to generate image prompt',
      details: error.message 
    });
  }
}