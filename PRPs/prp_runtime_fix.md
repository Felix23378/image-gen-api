Loaded cached credentials.
```markdown
# Product Requirements Prompt (PRP)

---

## 1. Overview

- **Feature Name:** Vercel Node.js Runtime Configuration Fix

- **Objective:** Resolve the Vercel build error `Error: Function Runtimes must have a valid version` by correctly configuring the Node.js runtime for the deployment.

- **Why:** To ensure Vercel uses Node.js 18.x for the serverless functions, allowing the build to succeed and the `/api/generate-image` endpoint to be deployed correctly.

---

## 2. Success Criteria

_This feature will be considered complete when the following conditions are met:_

- [ ] The code runs without errors.

- [ ] All new unit tests pass (or manual test steps succeed).

- [ ] The feature meets all functional requirements described below.

- [ ] The code adheres to the project standards defined in `GEMINI.md`.

- [ ] The Vercel deployment succeeds without runtime errors.

- [ ] The `/api/generate-image` endpoint is accessible and functional.

---

## 3. Context & Resources

### External Documentation

_List any URLs for libraries, APIs, or tutorials._

- **Resource:** [https://vercel.com/docs/projects/project-configuration/project-settings#functions](https://vercel.com/docs/projects/project-configuration/project-settings#functions)
  - **Purpose:** Vercel `vercel.json` Configuration documentation.

- **Resource:** [https://vercel.com/docs/functions/serverless-functions/runtimes/node.js](https://vercel.com/docs/functions/serverless-functions/runtimes/node.js)
  - **Purpose:** Vercel Function Runtimes and Node.js documentation.

- **Resource:** [https://vercel.com/docs/functions/serverless-functions/runtimes#node.js-version](https://vercel.com/docs/functions/serverless-functions/runtimes#node.js-version)
  - **Purpose:** Node.js version management for deployments on Vercel.

### Internal Codebase Patterns

_List any files in `examples/` or existing project files that show a pattern to follow._

- **File:** `examples/config/vercel-with-runtime.json`
  - **Reason:** Shows how to explicitly set the Node.js runtime in `vercel.json` to override any inference issues.

- **File:** `examples/package/package-with-engines.json`
  - **Reason:** Reinforces the correct structure for `package.json` with `engines` and `"type": "module"`.

- **File:** `examples/api/runtime-check.js`
  - **Reason:** A simple API to verify the Node.js runtime that Vercel is actually using for the function.

### ⚠️ Known Pitfalls

_List critical warnings, rate limits, or tricky logic to be aware of._

- **`engines` vs Vercel Config:** Sometimes Vercel might ignore `engines` in `package.json` if not explicitly configured.
- **Conflicting Runtimes:** If both `package.json` and `vercel.json` specify runtimes, ensure they match.
- **Cache Issues:** Vercel's build cache can sometimes be stubborn; a cache reset might be needed.
- **Node.js Version Specifics:** While `18.x` is good, some environments might prefer a specific minor version like `18.17.0`.
- **Manual Testing:** Since development is on mobile (Termux), manual testing in-browser will be required.

---

## 4. Implementation Blueprint

### Proposed File Structure

_Show the desired directory tree. Include new or modified files._

```
.
├── vercel.json         (modified)
├── package.json        (modified)
└── api/
    └── generate-image.js
```

### ✅ Task Breakdown

**Task 1: Configure `vercel.json` for Node.js 18.x**

- Modify `vercel.json` to explicitly set the Node.js runtime for serverless functions to `18.x`.

**Task 2: Verify `package.json` `engines` and `type`**

- Ensure `package.json` includes `"engines": { "node": "18.x" }` and `"type": "module"` if not already present, aligning with Vercel's recommendations.

**Task 3: Deploy and Manual Test Setup**

- Deploy the updated project to Vercel.
- Use the `examples/api/runtime-check.js` pattern to create a temporary endpoint to verify the Node.js runtime used by Vercel.
- Manually test the `/api/generate-image` endpoint to confirm functionality.

```js
// Pseudocode for vercel.json modification:
{
  "functions": {
    "api/**/*.js": {
      "runtime": "nodejs18.x"
    }
  }
}

// Pseudocode for package.json modification (if needed):
{
  "name": "gemini-img-api",
  "version": "1.0.0",
  "type": "module",
  "engines": {
    "node": "18.x"
  },
  // ... other fields
}
```

---

## 5. Validation Plan

### Unit Tests / Manual Validation

List what to test to verify correctness.

- Deploy the application to Vercel.
- Access the temporary runtime check endpoint (e.g., `/api/runtime-check`) to confirm Node.js version is `18.x`.
- Access the `/api/generate-image` endpoint with valid parameters to ensure it processes requests correctly and returns expected output.
- Verify that no build errors related to runtime configuration occur during deployment.

### ‍ Manual Test Command

Provide a simple command or interaction to verify visually or through the console.

```bash
# After deploying to Vercel, access the deployed URL in a browser or with curl:
curl https://<your-vercel-app-url>/api/runtime-check
curl -X POST -H "Content-Type: application/json" -d '{"prompt": "a cat"}' https://<your-vercel-app-url>/api/generate-image
```

### Expected Output (Console or UI):

For runtime check:
```
Node.js Runtime Version: 18.x.x
```
For image generation:
```json
{
  "imageUrl": "..." // A valid image URL
}
```
And crucially, a successful Vercel deployment without runtime errors.
```
