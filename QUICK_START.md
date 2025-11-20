# Quick Start: AI Role System

## TL;DR
Type `/` in Cursor chat → select a role → AI acts ONLY as that role.

---

## Available Roles

| Command | When to Use |
|---------|-------------|
| `/product-owner` | Need to break PRD into tasks |
| `/ux-ui-designer` | Need flows & screen designs |
| `/tech-lead` | Need architecture decisions |
| `/developer` | Need code implementation |
| `/qa-reviewer` | Need testing & verdict |

---

## Example: Build "Edit Ritual" Feature

### Step 1: Tasks
```
/product-owner
Break down Edit Ritual feature into tasks with acceptance criteria.
```
**Output**: 2-3 tasks with testable ACs

---

### Step 2: Design
```
/ux-ui-designer
Design the Edit Ritual flow and screen based on Product Owner tasks above.
```
**Output**: Flow (≤6 steps) + screen blueprint + visual style

---

### Step 3: Architecture
```
/tech-lead
Design architecture for Edit Ritual: add update method to repository.
```
**Output**: Interface updates, data flow

---

### Step 4: Code
```
/developer
Implement EditRitualScreen following tech design.
```
**Output**: Working code + test summary

---

### Step 5: Test
```
/qa-reviewer
Test Edit Ritual implementation against acceptance criteria.
```
**Output**: Test report + verdict (MVP READY or NOT READY)

---

## How It Works

Each `/` command loads a **role-locked prompt**:
- ✅ AI does ONLY what that role is authorized to do
- ❌ AI refuses work outside its scope
- 📋 AI follows exact output format for that role

**Example**:
```
You: /product-owner
You: Write code for the create ritual screen

AI: "That's not Product Owner's role. Use /developer for implementation."
```

---

## Key Rules

1. **One role per chat** - Don't mix roles in same message
2. **PRD is law** - All roles respect `docs/PRD.md` as immutable
3. **Chain roles** - Each role builds on previous output
4. **Roles refuse** - If AI says "not my role", that's working correctly

---

## Files

- **Role definitions**: `roles/*.md` (30-70 lines each)
- **Prompt files**: `.prompts/*.prompt.md` (Cursor slash commands)
- **Full guide**: `roles/README.md` or `.prompts/README.md`
- **Project rules**: `.cursorrules`

---

**That's it!** Type `/` and start building. 🚀

