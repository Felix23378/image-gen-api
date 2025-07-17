Loaded cached credentials.
```markdown
# Product Requirements Prompt (PRP)

---

## 1. Overview

- **Feature Name:** Fix Vercel Deployment 404 Error

- **Objective:** Properly configure the Vercel serverless function so that the `/api/generate-image` endpoint is accessible and returns expected responses instead of 404 errors.

- **Why:** To ensure the API is callable from the frontend and returns proper JSON responses, resolving the 404 NOT_FOUND error for the Myanmar Content AI backend.

---

## 2. Success Criteria

_This feature will be considered complete when the following conditions are met:_

- [ ] The code runs without errors.

- [ ] All new unit tests pass (or manual test steps succeed).

- [ ] The feature meets all functional requirements described below.

- [ ] The code adheres to the project standards defined in `GEMINI.md`.

- [ ] The `/api/generate-image` endpoint returns a 200 OK status with a valid JSON response.

- [ ] The API is accessible from the frontend without 404 errors.

---

## 3. Context & Resources

### External Documentation

_List any URLs for libraries, APIs, or tutorials._

- **Resource:** [https://vercel.com/docs/concepts/functions/serverless-functions](https://vercel.com/docs/concepts/functions/serverless-functions)  
  - **Purpose:** Understanding how Vercel serverless functions work.

- **Resource:** [https://vercel.com/docs/concepts/functions/serverless-functions/runtimes#node.js](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes#node.js)  
  - **Purpose:** Details on configuring API routes and Node.js runtimes.

- **Resource:** [https://vercel.com/docs/concepts/deployments/troubleshooting](https://vercel.com/docs/concepts/deployments/troubleshooting)  
  - **Purpose:** Guidance on resolving common deployment issues.

- **Resource:** [https://vercel.com/docs/concepts/functions/serverless-functions/runtimes#node.js-version](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes#node.js-version)  
  - **Purpose:** Information on using ES Modules with Vercel.

---

### Internal Codebase Patterns

_List any files in `examples/` or existing project files that show a pattern to follow._

- **File:** `examples/api/vercel-function-basic.js`  
  - **Reason:** Shows correct export syntax and handler structure for Vercel serverless functions.

- **File:** `examples/config/vercel-deployment.json`  
  - **Reason:** Demonstrates proper `vercel.json` configuration for API routes and function settings.

- **File:** `examples/api/test-endpoint.js`  
  - **Reason:** Simple working endpoint to verify deployment configuration and routing.

- **File:** `examples/package/vercel-dependencies.json`  
  - **Reason:** Shows correct `package.json` structure with dependencies for Vercel deployment.

---

### ⚠️ Known Pitfalls

_List critical warnings, rate limits, or tricky logic to be aware of._

- API files must be in `/api/` directory, not `/api/endpoints/` or nested folders.
- Must use `export default` for ES modules or `module.exports` for CommonJS.
- API endpoint files should match the route name exactly (`generate-image.js` for `/api/generate-image`).
- `@google/generative-ai` must be in `package.json` dependencies, not `devDependencies`.
- `vercel.json` might conflict with automatic detection - sometimes removing it helps.
- Ensure Node.js version compatibility in `vercel.json` or `package.json` engines.
- Mixed module systems can cause deployment failures.
- Default timeout might be too short for AI API calls.

---

## 4. Implementation Blueprint

### Proposed File Structure

_Show the desired directory tree. Include new or modified files._

```
.
├── vercel.json             (potentially new/modified)
└── src/
    └── api/
        └── generate-image.js (new/modified)
```

---

### ✅ Task Breakdown

**Task 1: Verify Vercel Configuration**

- Check `vercel.json` for correct routing and function settings.
- Ensure Node.js runtime compatibility.

**Task 2: Review API Endpoint File**

- Confirm file naming (`generate-image.js`).
- Verify `export default` syntax for the handler.
- Check for correct module system usage (ESM vs CommonJS).
- Ensure `@google/generative-ai` is a dependency.

**Task 3: Debug and Test Deployment**

- Deploy changes to Vercel.
- Manually test the `/api/generate-image` endpoint.

```js
// Pseudocode for generate-image.js handler:
// This is a simplified example, actual logic will be more complex.
export default async function handler(req, res) {
  if (req.method === 'POST') {
    try {
      // Simulate AI API call or actual call
      const responseData = { message: "Image generated successfully!", data: req.body };
      res.status(200).json(responseData);
    } catch (error) {
      console.error("API Error:", error);
      res.status(500).json({ error: "Internal Server Error", details: error.message });
    }
  } else {
    res.status(405).json({ error: "Method Not Allowed" });
  }
}
```

---

## 5. Validation Plan

### Unit Tests / Manual Validation

- Verify that `POST` requests to `/api/generate-image` no longer return 404 errors.
- Confirm that the endpoint returns a 200 OK status for valid requests.
- Check that the response body is valid JSON.
- Test with various inputs (if applicable to the API's logic) to ensure correct processing.
- Verify that the API is callable from the frontend application.

---

### ‍ Manual Test Command

Provide a simple command or interaction to verify visually or through the console.

```bash
curl -X POST -H "Content-Type: application/json" -d '{"prompt": "a cat"}' https://YOUR_VERCEL_DEPLOYMENT_URL/api/generate-image
```

### Expected Output (Console or UI):

```json
{
  "message": "Image generated successfully!",
  "data": {
    "prompt": "a cat"
  }
}
```
(Or similar JSON response indicating success, not a 404 or 500 error related to deployment/configuration)
```
