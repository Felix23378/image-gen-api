
## 🎯 The Goal

_Describe the feature you want to build. What is the primary objective? What should the user be able to do once this is complete?_

Example:  
> Build a "Daily Tasks" component where users can check off tasks and earn coins as rewards. Tasks and rewards should persist using Firebase.

---

## 🎨 Inspiration & Examples

_List any files in the `examples/` directory that show patterns to follow. Explain why they are relevant.

- **File:** `examples/components/TaskCard.jsx`  
  **Reason:** Uses clean component structure with animation and Tailwind.

- **File:** `examples/utils/rewardSystem.js`  
  **Reason:** Includes logic for calculating and updating user reward points.

---

## 📚 Required Knowledge

_Provide links to any external API documentation, libraries, or articles that are necessary to understand and build this feature._

Official Library Documentation

Helpful Stack Overflow Thread

---

## ⚠️ Potential Pitfalls & Gotchas

_What are the common mistakes or tricky parts of this task? Mention anything the AI should be extra careful about._

- Firebase reads/writes should be secured via rules — don’t expose data globally.
- Be mindful of animation performance on low-end mobile devices.
- Tailwind class stacking can get messy — keep classes grouped by purpose.
- Avoid hardcoding reward values — make them configurable if possible.
