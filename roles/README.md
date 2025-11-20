# AI Agent Roles

## Quick Start (Cursor Slash Commands)

Type `/` in Cursor chat and select a role:

```
/product-owner    - Break PRD into tasks with acceptance criteria
/ux-ui-designer   - Design flows (≤6 steps) + screens + visual style
/tech-lead        - Design architecture + interfaces + data models
/developer        - Implement code following tech design
/qa-reviewer      - Test and issue MVP verdict
```

**Each role is LOCKED to its scope** - it will refuse to do other roles' work.

## Roles

| Role | Use When | Outputs |
|------|----------|---------|
| **Product Owner** | Need tasks with acceptance criteria | Task list from PRD |
| **UX/UI Designer** | Need flows, screens & visual design | Flows (≤6 steps) + screens + design tokens |
| **Tech Lead** | Need architecture and interfaces | Tech design doc |
| **Developer** | Need code implementation | Working code + summary |
| **QA Reviewer** | Need testing and MVP verdict | Test report + verdict |

## Role Chain

```
PRD → Product Owner → UX/UI Designer → Tech Lead → Developer → QA → MVP
```

Each role:
- ✅ Has clear authority (what they decide)
- ❌ Has clear limits (what they can't change)
- 📋 Outputs specific format (next role's input)
- ✔️ Self-checks before output (3 questions)

## Usage Examples

### Single Role (Recommended)
```
Type in Cursor chat:
/tech-lead
Design the notification service interface.
```

### Full Workflow (Slash Commands)
```
Chat 1: /product-owner
        Create tasks for Edit Ritual feature.

Chat 2: /ux-ui-designer
        Design flows and screens for those tasks.

Chat 3: /tech-lead
        Design architecture for the flows.

Chat 4: /developer
        Implement the Edit Ritual screen.

Chat 5: /qa-reviewer
        Test against acceptance criteria.
```

### Alternative (File Reference)
```
@roles/1_product_owner.md Break down the edit ritual feature
```

## Key Principles

1. **PRD is Law** - All roles treat `docs/PRD.md` as immutable
2. **One Role at a Time** - Don't mix roles in one prompt
3. **Follow the Chain** - Each role builds on previous output
4. **Use Self-Checks** - Ask AI to run verification before accepting output

## Role Files

- `1_product_owner.md` - Scope keeper, tasks with ACs
- `2_ux_ui_designer.md` - Flows (max 6 steps) + screens + visual design
- `3_tech_lead.md` - Architecture + interfaces + models
- `4_developer.md` - Code implementation
- `5_qa_reviewer.md` - Testing + MVP verdict

Each file is ~20 lines: Role + Authority + Rules + Output Format + Self-Check

## Example Workflow

```
User: "Implement Edit Ritual feature"

→ Product Owner: Creates 2 tasks with ACs
→ UX/UI Designer: Designs 5-step flow + screen + visual style
→ Tech Lead: Adds update() method to RitualRepository interface
→ Developer: Implements EditRitualScreen with design tokens + tests
→ QA Reviewer: Tests against ACs → Verdict: MVP READY ✅
```

That's it! Brief, focused, effective. 🎯
