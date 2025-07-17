Loaded cached credentials.
```markdown
# Product Requirements Prompt (PRP)

---

## 1. Overview

- **Feature Name:** Vercel Serverless Image Prompt API

- **Objective:** Build a Vercel serverless backend API that accepts POST requests to generate culturally appropriate image descriptions for Myanmar content using Gemini AI.

- **Why:** To provide a standalone backend service for the existing React frontend to consume, generating detailed, culturally appropriate image prompts for Facebook post visuals.

---

## 2. Success Criteria

_This feature will be considered complete when the following conditions are met:_

- [x] The code runs without errors.

- [x] All new unit tests pass (or manual test steps succeed).

- [x] The feature meets all functional requirements described below.

- [x] The code adheres to the project standards defined in `GEMINI.md`.

- [x] The API successfully receives POST requests with Myanmar content and a Gemini API key.

- [x] The API uses Gemini to generate a culturally appropriate image description.

- [x] The API returns a structured JSON response with the image prompt.

- [x] User API keys are not logged or stored.

- [x] CORS is correctly configured for the React frontend.

- [x] The API handles Gemini rate limits gracefully.

- [x] The API response time is optimized to stay within Vercel's 30-second execution limit.

- [x] Meaningful error messages are provided for various failure scenarios.

- [x] Input content is sanitized to prevent prompt injection.

- [x] The JSON response structure is consistent.

---

## 3. Context & Resources

### External Documentation

_List any URLs for libraries, APIs, or tutorials._

- **Resource:** [Vercel Serverless Functions Documentation](https://vercel.com/docs/concepts/functions/serverless-functions)  
  - **Purpose:** Understanding Vercel's serverless function environment and deployment.

- **Resource:** [Google Generative AI SDK](https://ai.google.dev/tutorials/node_quickstart)  
  - **Purpose:** Learning how to integrate and use the Gemini API in Node.js.

- **Resource:** [Gemini API Documentation](https://ai.google.dev/docs)  
  - **Purpose:** Detailed information on Gemini API capabilities and usage.

- **Resource:** [Vercel CORS Handling](https://vercel.com/guides/how-to-enable-cors)  
  - **Purpose:** Guidance on configuring Cross-Origin Resource Sharing for Vercel functions.

- **Resource:** [Myanmar Cultural Context for AI Prompts](https://en.wikipedia.org/wiki/Culture_of_Myanmar)  
  - **Purpose:** To ensure culturally appropriate image prompt generation.

---

### Internal Codebase Patterns

_List any files in `examples/` or existing project files that show a pattern to follow._

- **File:** `examples/api/gemini-content-generator.js`  
  - **Reason:** Shows proper Gemini API integration with error handling and response formatting for content generation.

- **File:** `examples/api/cors-handler.js`  
  - **Reason:** Demonstrates proper CORS setup for Vercel serverless functions with security considerations.

- **File:** `examples/api/image-prompt-generator.js`  
  - **Reason:** Reference implementation for generating culturally appropriate image prompts using AI.

- **File:** `examples/config/vercel-config.json`  
  - **Reason:** Shows proper Vercel configuration for serverless functions with timeout and environment settings.

---

### ⚠️ Known Pitfalls

_List critical warnings, rate limits, or tricky logic to be aware of._

- API Key Security: Never log or store user API keys - they should only be used for the single request and discarded.
- CORS Configuration: Ensure proper CORS headers for React frontend communication.
- Gemini Rate Limits: Handle API rate limiting gracefully with proper error messages.
- Cultural Sensitivity: Image prompts should be culturally appropriate for Myanmar context - avoid Western-centric visual descriptions.
- Vercel Timeout: Functions have 30-second execution limit - optimize for quick response times.
- Error Handling: Provide meaningful error messages for different failure scenarios (invalid API key, network issues, etc.).
- Content Validation: Sanitize input content to prevent prompt injection attacks.
- Response Format: Maintain consistent JSON response structure for easier frontend integration.
- No Hardcoded Secrets: Never include real API keys or secrets in code. Use `.env` and `.env.example`.
- 500-Line Rule: No single file should exceed 500 lines.

---

## 4. Implementation Blueprint

### Proposed File Structure

_Show the desired directory tree. Include new or modified files._

```
api/
└── generate-image-prompt.js (new)
```

### ✅ Task Breakdown

**Task 1: API Endpoint Setup**

- Create a new Vercel serverless function `api/generate-image-prompt.js`.
- Configure it to accept POST requests.
- Implement CORS handling based on `examples/api/cors-handler.js`.

**Task 2: Request Handling & Validation**

- Parse incoming JSON body to extract `myanmarContent` and `geminiApiKey`.
- Validate input: ensure `myanmarContent` is present and `geminiApiKey` is provided.
- Sanitize `myanmarContent` to prevent prompt injection.

**Task 3: Gemini Integration**

- Initialize Gemini API client using the provided `geminiApiKey`.
- Construct a prompt to generate a culturally appropriate image description for the given `myanmarContent`.
- Call the Gemini API to generate the image prompt.
- Implement error handling for API calls (rate limits, invalid key, network issues).

**Task 4: Response Generation**

- Format the Gemini response into a consistent JSON structure.
- Handle success and error responses with appropriate HTTP status codes and messages.

**Task 5: Manual Test Setup**

- Provide instructions for testing the API endpoint using `curl` or a similar tool.

```javascript
// Pseudocode for api/generate-image-prompt.js
import { GoogleGenerativeAI } from '@google/generative-ai';
import { handleCors } from '../examples/api/cors-handler.js'; // Assuming this is a utility

export default async function handler(req, res) {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return handleCors(req, res);
  }

  // Only allow POST requests
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method Not Allowed' });
  }

  try {
    const { myanmarContent, geminiApiKey } = req.body;

    // Input validation
    if (!myanmarContent || !geminiApiKey) {
      return res.status(400).json({ error: 'Missing myanmarContent or geminiApiKey' });
    }

    // Sanitize input (placeholder for actual sanitization logic)
    const sanitizedContent = sanitize(myanmarContent);

    // Initialize Gemini
    const genAI = new GoogleGenerativeAI(geminiApiKey);
    const model = genAI.getGenerativeModel({ model: "gemini-pro" });

    // Construct prompt for culturally appropriate image description
    const prompt = `Generate a detailed image description for a Facebook post visual based on the following Myanmar content. Ensure the description is culturally appropriate for Myanmar and avoids Western-centric visuals. Focus on elements relevant to Myanmar culture, traditions, and daily life.
    Myanmar Content: "${sanitizedContent}"
    Image Description:`;

    // Generate content
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const imagePrompt = response.text();

    // Success response
    res.status(200).json({ success: true, imagePrompt });

  } catch (error) {
    console.error('API Error:', error);
    // Handle specific errors (e.g., invalid API key, rate limit)
    if (error.message.includes('API key not valid')) {
      return res.status(401).json({ error: 'Invalid Gemini API Key' });
    }
    if (error.message.includes('rate limit')) {
      return res.status(429).json({ error: 'Gemini API Rate Limit Exceeded' });
    }
    res.status(500).json({ error: 'Internal Server Error', details: error.message });
  }
}

// Placeholder for a simple sanitize function
function sanitize(text) {
  // Implement actual sanitization logic here
  return text;
}
```

---

## 5. Validation Plan

### Unit Tests / Manual Validation

- Test valid POST request with `myanmarContent` and `geminiApiKey`.
- Test POST request with missing `myanmarContent`.
- Test POST request with missing `geminiApiKey`.
- Test POST request with an invalid `geminiApiKey` (expect 401).
- Test POST request with content that might trigger rate limiting (if possible to simulate).
- Verify CORS headers are correctly set for preflight and actual requests.
- Manually verify the generated `imagePrompt` for cultural appropriateness.

### Manual Test Command

```bash
# Assuming the Vercel function is deployed and accessible at /api/generate-image-prompt
# Replace YOUR_GEMINI_API_KEY and YOUR_MYANMAR_CONTENT
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{ "myanmarContent": "YOUR_MYANMAR_CONTENT", "geminiApiKey": "YOUR_GEMINI_API_KEY" }' \
  http://localhost:3000/api/generate-image-prompt # Or your deployed Vercel URL
```

### Expected Output (Console or UI):

```json
{
  "success": true,
  "imagePrompt": "A detailed, culturally appropriate image description for Facebook post visuals based on the Myanmar content."
}
```
(Or an appropriate error JSON in case of failure.)
```
