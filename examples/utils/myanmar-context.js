// Myanmar cultural context utilities
export const getMyanmarImageContext = (content) => {
  const contextualPrompt = `
Generate an image description that incorporates Myanmar cultural elements:

Content: "${content}"

Consider:
- Traditional Myanmar aesthetics
- Buddhist cultural references where appropriate
- Local architectural elements (pagodas, traditional buildings)
- Myanmar color preferences (gold, red, saffron)
- Natural elements common in Myanmar (lotus, bamboo, teak)
- Social media friendly composition

Provide a detailed visual description that would resonate with Myanmar audience.
  `;
  
  return contextualPrompt;
};

export const validateMyanmarContent = (content) => {
  // Basic content validation for Myanmar context
  if (!content || content.length < 10) {
    return false;
  }
  
  // Add more Myanmar-specific validation logic
  return true;
};
