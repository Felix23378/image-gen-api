import { GoogleGenerativeAI } from ' @google/generative-ai';

export default async function handler(req, res) {
  // Image prompt generation pattern
  const { content, apiKey } = req.body;
  
  const genAI = new GoogleGenerativeAI(apiKey);
  const model = genAI.getGenerativeModel({ model: "gemini-pro" });

  const imagePrompt = `
Create a detailed image description for this content:
"${content}"

Include:
- Visual composition
- Color palette
- Cultural context
- Mood and atmosphere

Respond with only the image description.
  `;

  try {
    const result = await model.generateContent(imagePrompt);
    const response = await result.response;
    const imageDescription = response.text();

    return res.status(200).json({
      success: true,
      imagePrompt: imageDescription
    });

  } catch (error) {
    return res.status(500).json({ 
      success: false,
      error: 'Failed to generate image prompt' 
    });
  }
}