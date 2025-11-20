# Cursor Prompt Files (Slash Commands)

## How to Use

1. **Open Cursor Chat** (Cmd+L or Cmd+I)
2. **Type `/`** - Cursor will show auto-complete with available prompts
3. **Select a role** - e.g., `/product-owner`
4. **Add your request** after the prompt loads

## Available Role Prompts

| Slash Command | Role | What It Does |
|---------------|------|--------------|
| `/product-owner` | Product Owner | Creates tasks with ACs from PRD |
| `/ux-ui-designer` | UX/UI Designer | Designs flows (≤6 steps) + screens + visual style |
| `/tech-lead` | Tech Lead | Designs architecture + interfaces + models |
| `/developer` | Developer | Implements code following tech design |
| `/qa-reviewer` | QA Reviewer | Tests and issues MVP verdict |

## Example Usage

### In Cursor Chat:
```
You: /product-owner
You: Break down the "Edit Ritual" feature from PRD section 2.1

AI: [Responds ONLY as Product Owner, creates tasks with ACs]
```

### Role Constraints
Each prompt **locks the AI** to that role:
- ✅ AI will do ONLY what that role is authorized to do
- ❌ AI will refuse work outside its scope
- 🔄 AI will tell you which role to use instead

**Example**:
```
You: /product-owner
You: Write code for the create ritual screen

AI: "That's not Product Owner's role. Use /developer for implementation."
```

## Why This Works

Each prompt file (`.prompts/*.prompt.md`) contains:
1. **Role definition** - "You are ONLY acting as [Role]"
2. **Authority boundaries** - What you CAN and CANNOT do
3. **Constraint enforcement** - Instructions to refuse out-of-scope work
4. **Output format** - Exact template to follow

This prevents:
- ❌ Scope creep (AI adding features not in PRD)
- ❌ Role confusion (AI mixing Product Owner + Developer work)
- ❌ Inconsistent outputs (every role follows its template)

## Workflow Example

```
1. /product-owner
   "Create tasks for notification feature"
   → Get: Task list with ACs

2. /ux-ui-designer
   "Design flows for the tasks above"
   → Get: Flows + screen blueprints + design tokens

3. /tech-lead
   "Design architecture for those flows"
   → Get: Interfaces + data models + folder structure

4. /developer
   "Implement Task 1: Schedule Notification"
   → Get: Working code + test summary

5. /qa-reviewer
   "Test Task 1 implementation"
   → Get: Test report + verdict (MVP READY or NOT READY)
```

## Tips

- **One role per chat turn** - Don't mix roles in same message
- **Reference previous output** - "Based on the PO tasks above..."
- **Use role constraints** - If AI refuses, that's GOOD (it's protecting scope)
- **Chain roles** - Each role builds on previous output

## Files

Prompt files are in `.prompts/` directory:
- `product-owner.prompt.md`
- `ux-ui-designer.prompt.md`
- `tech-lead.prompt.md`
- `developer.prompt.md`
- `qa-reviewer.prompt.md`

Cursor automatically indexes these and makes them available via `/` command.

