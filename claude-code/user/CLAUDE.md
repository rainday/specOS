# CLAUDE.md

## Purpose

This file directs Claude Code to use your personal specOS standards for all development work. These global standards define your preferred way of building software across all projects.

## Global Standards

### Development Standards

- **Tech Stack Defaults:** @~/.specOS/standards/tech-stack.md
- **Code Style Preferences:** @~/.specOS/standards/code-style.md
- **Best Practices Philosophy:** @~/.specOS/standards/best-practices.md
- **Testing Standards:** @~/.specOS/standards/testing-standards.md
- **Security Standards:** @~/.specOS/standards/security-standards.md
- **Performance Standards:** @~/.specOS/standards/performance-standards.md

### specOS Instructions

- **Initialize Products:** @~/.specOS/instructions/plan-product.md
- **Plan Features:** @~/.specOS/instructions/create-spec.md
- **Execute Tasks:** @~/.specOS/instructions/execute-tasks.md
- **Analyze Existing Code:** @~/.specOS/instructions/analyze-product.md

## How These Work Together

1. **Standards** define your universal preferences that apply to all projects
2. **Instructions** guide the agent through specOS workflows
3. **Project-specific files** (if present) override these global defaults

## Using specOS Commands

You can invoke specOS commands directly:

- `/plan-product` - Start a new product
- `/create-spec` - Plan a new feature
- `/execute-tasks` - Build and ship code
- `/analyze-product` - Add specOS to existing code

## Important Notes

- These are YOUR standards - customize them to match your preferences
- Project-specific standards in `.specOS/product/` override these globals
- Update these files as you discover new patterns and preferences

---

_Using specOS for structured AI-assisted development. Learn more at [GitHub](https://github.com/rainday/specOS)_
