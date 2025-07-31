---
description: Analyze Current Product & Install specOS
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Analyze Current Product & Install specOS

<ai_meta>
<rules>Process XML blocks sequentially, use exact templates, request missing data</rules>
<format>UTF-8, LF, 2-space indent, no header indent</format>
</ai_meta>

## Overview

Install specOS into an existing codebase, analyze current product state and progress. Builds on plan-product.md

<process_flow>

<step number="1" name="check_plan_notes">

### Step 1: Check Plan Notes Availability

<step_metadata>
<action>verify plan-notes existence</action>
<purpose>ensure plan-notes exists before proceeding</purpose>
</step_metadata>

<check_plan_notes>
<file_path>.claude/docs/plan-notes.md</file_path>
<required>true</required>
</check_plan_notes>

<instructions>
  ACTION: Check if .claude/docs/plan-notes.md exists
  
  IF plan-notes.md EXISTS:
    PROCEED: to Step 2 (analyze existing codebase)
  
  IF plan-notes.md DOES NOT EXIST:
    INFORM: User to run plan-product.md first
    STOP: Execution until plan-product is called
</instructions>

<user_instruction_plan_notes_missing>
I notice that plan notes are missing (`.claude/docs/plan-notes.md`).

Please run `/plan-product` first to create plan notes, then return here to analyze your existing codebase.
</user_instruction_plan_notes_missing>

</step>

<step number="2" name="analyze_existing_codebase">

### Step 2: Analyze Existing Codebase

<step_metadata>
<action>deep codebase analysis</action>
<purpose>understand current state before documentation</purpose>
</step_metadata>

<analysis_areas>
<project_structure> - Directory organization - File naming patterns - Module structure - Build configuration
</project_structure>
<technology_stack> - Frameworks in use - Dependencies (package.json, Gemfile, requirements.txt, etc.) - Database systems - Infrastructure configuration
</technology_stack>
<implementation_progress> - Completed features - Work in progress - Authentication/authorization state - API endpoints - Database schema
</implementation_progress>
<code_patterns> - Coding style in use - Naming conventions - File organization patterns - Testing approach
</code_patterns>
</analysis_areas>

<instructions>
  ACTION: Thoroughly analyze the existing codebase
  DOCUMENT: Current technologies, features, and patterns
  IDENTIFY: Architectural decisions already made
  NOTE: Development progress and completed work
</instructions>

</step>

<step number="3" name="gather_product_context">

### Step 3: Gather Product Context

<step_metadata>
<supplements>codebase analysis</supplements>
<gathers>business context and future plans</gathers>
</step_metadata>

<context_questions>
Based on my analysis of your codebase, I can see you're building [OBSERVED_PRODUCT_TYPE].

To properly set up specOS, I need to understand:

1. **Product Vision**: What problem does this solve? Who are the target users?

2. **Current State**: Are there features I should know about that aren't obvious from the code?

3. **Roadmap**: What features are planned next? Any major refactoring planned?

4. **Decisions**: Are there important technical or product decisions I should document?

5. **Team Preferences**: Any coding standards or practices the team follows that I should capture?
   </context_questions>

<instructions>
  ACTION: Ask user for product context
  COMBINE: Merge user input with codebase analysis
  PREPARE: Information for plan-product.md execution
</instructions>

</step>

<step number="4" name="summary">

### Step 4: Summary and Next Steps

<step_metadata>
<provides>analysis summary</provides>
<directs>user to next actions</directs>
</step_metadata>

<summary_template>

## 📊 Codebase Analysis Complete

I've analyzed your existing codebase and gathered the following insights:

### What I Found

- **Tech Stack**: [SUMMARY_OF_DETECTED_STACK]
- **Completed Features**: [COUNT] features already implemented
- **Code Style**: [DETECTED_PATTERNS]
- **Current Phase**: [IDENTIFIED_DEVELOPMENT_STAGE]

### Next Steps

1. **Review the analysis** above and confirm it's accurate
2. **Run plan-product** to create your product documentation:
   ```
   /plan-product
   ```
3. **Start using specOS** for your next feature:
   ```
   @~/.specOS/instructions/create-spec.md
   ```

Your codebase is ready for specOS integration! 🚀
</summary_template>

<instructions>
  ACTION: Summarize the analysis findings
  PROVIDE: Clear next steps for user
  DIRECT: User to run plan-product.md
</instructions>

</step>

</process_flow>

## Error Handling

<error_scenarios>
<scenario name="no_clear_structure">
<condition>Cannot determine project type or structure</condition>
<action>Ask user for clarification about project</action>
</scenario>
<scenario name="conflicting_patterns">
<condition>Multiple coding styles detected</condition>
<action>Ask user which pattern to document</action>
</scenario>
<scenario name="missing_dependencies">
<condition>Cannot determine full tech stack</condition>
<action>List detected technologies and ask for missing pieces</action>
</scenario>
</error_scenarios>

## Execution Summary

<final_checklist>
<verify> - [ ] Plan notes verified (.claude/docs/plan-notes.md) - [ ] Codebase analyzed thoroughly - [ ] User context gathered - [ ] Analysis summary provided - [ ] User directed to run plan-product.md
</verify>
</final_checklist>
