## The Goal

Fix the Vercel deployment 404 NOT_FOUND error for the Myanmar Content AI backend. The primary objective is to properly configure the Vercel serverless function so that the `/api/generate-image` endpoint is accessible and returns expected responses instead of 404 errors. Once complete, the API should be callable from the frontend and return proper JSON responses.

Example:  
> Fix Vercel deployment configuration so that POST requests to `/api/generate-image` return proper responses instead of 404 errors, ensuring the serverless function is correctly deployed and accessible.

---

## Inspiration & Examples

_List any files in the `examples/` directory that show patterns to follow. Explain why they are relevant._

- **File:** `examples/api/vercel-function-basic.js`  
  **Reason:** Shows correct export syntax and handler structure for Vercel serverless functions.

- **File:** `examples/config/vercel-deployment.json`  
  **Reason:** Demonstrates proper vercel.json configuration for API routes and function settings.

- **File:** `examples/api/test-endpoint.js`  
  **Reason:** Simple working endpoint to verify deployment configuration and routing.

- **File:** `examples/package/vercel-dependencies.json`  
  **Reason:** Shows correct package.json structure with dependencies for Vercel deployment.

---

## Required Knowledge

_Provide links to any external API documentation, libraries, or articles that are necessary to understand and build this feature._

- [Vercel Serverless Functions Documentation](https://vercel.com/docs/concepts/functions/serverless-functions)
- [Vercel API Routes Configuration](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes#node.js)
- [Vercel Deployment Troubleshooting](https://vercel.com/docs/concepts/deployments/troubleshooting)
- [Node.js ES Modules in Vercel](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes#node.js-version)

---

## ⚠️ Potential Pitfalls & Gotchas

_What are the common mistakes or tricky parts of this task? Mention anything the AI should be extra careful about._

- **File Structure:** API files must be in `/api/` directory, not `/api/endpoints/` or nested folders
- **Export Syntax:** Must use `export default` for ES modules or `module.exports` for CommonJS
- **File Naming:** API endpoint files should match the route name exactly (generate-image.js for /api/generate-image)
- **Dependencies:** @google/generative-ai must be in package.json dependencies, not devDependencies
- **Vercel Configuration:** vercel.json might conflict with automatic detection - sometimes removing it helps
- **Runtime Version:** Ensure Node.js version compatibility in vercel.json or package.json engines
- **Import/Export:** Mixed module systems can cause deployment failures
- **Function Timeout:** Default timeout might be too short for AI API calls

---