## The Goal

Build a Vercel serverless backend API that accepts POST requests to generate culturally appropriate image descriptions for Myanmar content using Gemini AI. The backend should receive user-generated Myanmar content text and the user's Gemini API key, then return a detailed image prompt that can be used for Facebook post visuals. This is a standalone backend service that will be consumed by the existing React frontend.

The API flow: Frontend sends POST request with content + API key → Backend uses Gemini to create Myanmar-appropriate image description → Returns structured JSON response with image prompt.

---

## Inspiration & Examples

_List any files in the `examples/` directory that show patterns to follow. Explain why they are relevant._

- **File:** `examples/api/gemini-content-generator.js`  
  **Reason:** Shows proper Gemini API integration with error handling and response formatting for content generation.

- **File:** `examples/api/cors-handler.js`  
  **Reason:** Demonstrates proper CORS setup for Vercel serverless functions with security considerations.

- **File:** `examples/api/image-prompt-generator.js`  
  **Reason:** Reference implementation for generating culturally appropriate image prompts using AI.

- **File:** `examples/config/vercel-config.json`  
  **Reason:** Shows proper Vercel configuration for serverless functions with timeout and environment settings.

---

## Required Knowledge

_Provide links to any external API documentation, libraries, or articles that are necessary to understand and build this feature._

- [Vercel Serverless Functions Documentation](https://vercel.com/docs/concepts/functions/serverless-functions)
- [Google Generative AI SDK](https://ai.google.dev/tutorials/node_quickstart)
- [Gemini API Documentation](https://ai.google.dev/docs)
- [Vercel CORS Handling](https://vercel.com/guides/how-to-enable-cors)
- [Myanmar Cultural Context for AI Prompts](https://en.wikipedia.org/wiki/Culture_of_Myanmar)

---

## ⚠️ Potential Pitfalls & Gotchas

_What are the common mistakes or tricky parts of this task? Mention anything the AI should be extra careful about._

- **API Key Security:** Never log or store user API keys - they should only be used for the single request and discarded.
- **CORS Configuration:** Ensure proper CORS headers for React frontend communication.
- **Gemini Rate Limits:** Handle API rate limiting gracefully with proper error messages.
- **Cultural Sensitivity:** Image prompts should be culturally appropriate for Myanmar context - avoid Western-centric visual descriptions.
- **Vercel Timeout:** Functions have 30-second execution limit - optimize for quick response times.
- **Error Handling:** Provide meaningful error messages for different failure scenarios (invalid API key, network issues, etc.).
- **Content Validation:** Sanitize input content to prevent prompt injection attacks.
- **Response Format:** Maintain consistent JSON response structure for easier frontend integration.

---