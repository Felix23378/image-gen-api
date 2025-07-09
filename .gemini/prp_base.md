Perfect — this is an excellent, structured base for a Gemini-style PRP (Product Requirements Prompt). I’ve formatted it cleanly as a reusable Markdown template file named prp_base.md. This will be read by generate-prp.sh and filled dynamically (e.g., replacing placeholders with actual values from INITIAL.md, GEMINI.md, etc.).


---

✅ prp_base.md (Template for generate-prp.sh)

#  Product Requirements Prompt (PRP)

---

## 1. Overview

- **Feature Name:** _A short, descriptive name for the feature._

- **Objective:** _One sentence summary of the goal. What are we building?_

- **Why:** _What user problem does this solve or what value does it create?_

---

## 2. Success Criteria

_This feature will be considered complete when the following conditions are met:_

- [ ] The code runs without errors.

- [ ] All new unit tests pass (or manual test steps succeed).

- [ ] The feature meets all functional requirements described below.

- [ ] The code adheres to the project standards defined in `GEMINI.md`.

---

## 3. Context & Resources

###  External Documentation

_List any URLs for libraries, APIs, or tutorials._

- **Resource:** [https://example.com]  
  - **Purpose:** _Explain which parts are relevant._

---

###  Internal Codebase Patterns

_List any files in `examples/` or existing project files that show a pattern to follow._

- **File:** `examples/sample.js`  
  - **Reason:** _Use the animation + state logic from this component._

---

### ⚠️ Known Pitfalls

_List critical warnings, rate limits, or tricky logic to be aware of._

- _e.g., "Firebase rules block write access if user is not authenticated."_  
- _e.g., "Animation libraries must work on mobile — avoid GSAP."_

---

## 4. Implementation Blueprint

###  Proposed File Structure

_Show the desired directory tree. Include new or modified files._

src/ └── new_feature/ ├── index.jsx         (new) └── logic.js          (new)

examples/ └── reward_example.js     (reference)

---

### ✅ Task Breakdown

**Task 1: UI Component**

- Create a new responsive component using Tailwind and Framer Motion.

**Task 2: Core Logic**

- Handle user input, Firebase write, and animation feedback.

```js
// Pseudocode:
function handleSubmit(task) {
  if (!task) throw new Error("Missing task")
  addTaskToFirebase(task)
  animateTask()
}

Task 3: Manual Test Setup

Link component into /App.jsx or main view and test reward logic.



---

5. Validation Plan

 Unit Tests / Manual Validation

List what to test to verify correctness.

test_valid_input() – Confirm success on normal use case.

test_empty_input() – Show graceful error if input is blank.

test_db_failure() – Catch and log Firebase failures.



---

‍ Manual Test Command

Provide a simple command or interaction to verify visually or through the console.

# Run app
npm run dev

Expected Output (Console or UI):

✅ Task added!
 10 coins rewarded!