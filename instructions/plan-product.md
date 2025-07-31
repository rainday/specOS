---
description: Product Planning Rules for specOS
globs:
alwaysApply: false
version: 4.0
encoding: UTF-8
---

# Product Planning Rules

<ai_meta>
<rules>Process XML blocks sequentially, use exact templates, request missing data</rules>
<format>UTF-8, LF, 2-space indent, no header indent</format>
</ai_meta>

## Overview

Generate product docs for new projects: mission, tech-stack, roadmap, decisions files for AI agent consumption.

<agent_detection>
<check_once>
AT START OF PROCESS:
SET has_file_creator = (Claude Code AND file-creator agent exists)
SET has_context_fetcher = (Claude Code AND context-fetcher agent exists)
USE these flags throughout execution
</check_once>
</agent_detection>

<process_flow>

<step number="1" name="create_plan_notes">

### Step 1: Create Plan Notes

<step_metadata>
<creates> - file: .claude/docs/plan-notes.md
</creates>
<purpose>Create template for user to fill out product information</purpose>
</step_metadata>

<instructions>
  ACTION: Copy the EXACT content from instructions/plan-notes.md to .claude/docs/plan-notes.md
  REQUIREMENT: Copy the complete template including all sections, examples, and formatting
  VERIFY: Ensure the copied file contains the full comprehensive template with tech stack defaults
  INFORM: User to fill out the plan notes file with their product information
  ASK: "Are you ready to proceed with planning?" (wait for "yes")
</instructions>

<user_instruction>
I've created a comprehensive plan notes template at `.claude/docs/plan-notes.md`. This template includes detailed sections with examples and sensible tech stack defaults. Please fill out this file with your product information:

1. **Fill out the sections** with your specific product details
2. **Use the provided examples** as guides for formatting
3. **Keep the tech stack defaults** if you're unsure about technical choices
4. **Copy and paste any text** - no special formatting needed
5. **Leave sections empty** if you don't have the information
6. **Save the file** when you're done

The template includes sections for product information, technical stack with defaults, project status, and optional sample code.

Are you ready to proceed with planning?
</user_instruction>

</step>

<step number="2" name="gather_user_input">

### Step 2: Gather User Input from Plan Notes

<step_metadata>
<required_inputs> - plan_notes_file: .claude/docs/plan-notes.md - main_idea: string (from plan notes) - key_features: array[string] (minimum: 3, from plan notes) - target_users: array[string] (minimum: 1, from plan notes) - tech_stack: object (from plan notes + fallbacks)
</required_inputs>
<validation>blocking</validation>
</step_metadata>

<data_sources>
<primary>plan_notes_file</primary>
<fallback_sequence> 1. @~/.specOS/standards/tech-stack.md 2. @~/.claude/CLAUDE.md
</fallback_sequence>
</data_sources>

<project_detection>
<check_existing_project>
IF .specOS/product/tech-stack.md EXISTS:
SET project_type = "existing"
SET update_mode = true
ELSE:
SET project_type = "new"
SET update_mode = false
</check_existing_project>
</project_detection>

<instructions>
  ACTION: Read and parse .claude/docs/plan-notes.md
  EXTRACT: All required information from plan notes
  VALIDATE: Ensure minimum requirements are met
  
  IF has_context_fetcher:
    USE: @agent:context-fetcher
    REQUEST: "Get tech stack defaults from tech-stack.md"
    PROCESS: Use returned defaults for missing items
  ELSE:
    FALLBACK: Check configuration files for tech stack defaults
    
  IF project_type = "existing":
    MERGE: Plan notes with existing .specOS/product/ files
    UPDATE: Existing documentation with new information
  ELSE:
    CREATE: New project documentation from plan notes
    
  ERROR: Request missing information if plan notes incomplete
</instructions>

<error_template>
The plan notes file is missing required information. Please provide:

1. Main idea for the product
2. List of key features (minimum 3)
3. Target users and use cases (minimum: 1)
4. Tech stack preferences
5. Project status (are you in your project folder and ready to start?)

You can add this information to `.claude/docs/plan-notes.md` and let me know when you're ready.
</error_template>

</step>

<step number="3" name="create_documentation_structure">

### Step 3: Create Documentation Structure

<step_metadata>
<creates> - directory: .specOS/product/ - files: 7
</creates>
</step_metadata>

<file_structure>
.specOS/
└── product/
├── mission.md # Product vision and purpose
├── mission-lite.md # Condensed mission for AI context
├── tech-stack.md # Technical architecture
├── roadmap.md # Development phases
├── requirements.md # Product requirements and decisions
├── structure.md # Product architecture and component structure
└── style-guide.md # UI color settings and design guidelines
</file_structure>

<git_config>
<commit_message>Initialize specOS product documentation</commit_message>
<tag>v0.1.0-planning</tag>
<gitignore_consideration>true</gitignore_consideration>
</git_config>

<instructions>
  IF project_type = "existing":
    VALIDATE: Existing .specOS/product/ directory and files
    BACKUP: Existing files before updating (optional)
    UPDATE: Existing files with new information from plan notes
  ELSE:
    IF has_file_creator:
      USE: @agent:file-creator
      REQUEST: "Create directory: .specOS/product/"
    ELSE:
      CREATE: Directory using mkdir -p .specOS/product/
  VALIDATION: Verify write permissions before creating
  PROTECTION: Confirm before overwriting existing files
</instructions>

</step>

<step number="4" name="create_mission_md">

### Step 4: Create mission.md

<step_metadata>
<creates> - file: .specOS/product/mission.md
</creates>
</step_metadata>

<file_template>

  <header>
    # Product Mission
  </header>
  <required_sections>
    - Pitch
    - Users
    - The Problem
    - Differentiators
    - Key Features
  </required_sections>
</file_template>

<section name="pitch">
  <template>
    ## Pitch

    [PRODUCT_NAME] is a [PRODUCT_TYPE] that helps [TARGET_USERS] [SOLVE_PROBLEM] by providing [KEY_VALUE_PROPOSITION].

  </template>
  <constraints>
    - length: 1-2 sentences
    - style: elevator pitch
  </constraints>
</section>

<section name="users">
  <template>
    ## Users

    ### Primary Customers

    - [CUSTOMER_SEGMENT_1]: [DESCRIPTION]
    - [CUSTOMER_SEGMENT_2]: [DESCRIPTION]

    ### User Personas

    **[USER_TYPE]** ([AGE_RANGE])
    - **Role:** [JOB_TITLE]
    - **Context:** [BUSINESS_CONTEXT]
    - **Pain Points:** [PAIN_POINT_1], [PAIN_POINT_2]
    - **Goals:** [GOAL_1], [GOAL_2]

  </template>
  <schema>
    - name: string
    - age_range: "XX-XX years old"
    - role: string
    - context: string
    - pain_points: array[string]
    - goals: array[string]
  </schema>
</section>

<section name="problem">
  <template>
    ## The Problem

    ### [PROBLEM_TITLE]

    [PROBLEM_DESCRIPTION]. [QUANTIFIABLE_IMPACT].

    **Our Solution:** [SOLUTION_DESCRIPTION]

  </template>
  <constraints>
    - problems: 2-4
    - description: 1-3 sentences
    - impact: include metrics
    - solution: 1 sentence
  </constraints>
</section>

<section name="differentiators">
  <template>
    ## Differentiators

    ### [DIFFERENTIATOR_TITLE]

    Unlike [COMPETITOR_OR_ALTERNATIVE], we provide [SPECIFIC_ADVANTAGE]. This results in [MEASURABLE_BENEFIT].

  </template>
  <constraints>
    - count: 2-3
    - focus: competitive advantages
    - evidence: required
  </constraints>
</section>

<section name="features">
  <template>
    ## Key Features

    ### Core Features

    - **[FEATURE_NAME]:** [USER_BENEFIT_DESCRIPTION]

    ### Collaboration Features

    - **[FEATURE_NAME]:** [USER_BENEFIT_DESCRIPTION]

  </template>
  <constraints>
    - total: 8-10 features
    - grouping: by category
    - description: user-benefit focused
  </constraints>
</section>

<instructions>
  ACTION: Create mission.md using all section templates
  FILL: Use data from Step 1 user inputs
  FORMAT: Maintain exact template structure
</instructions>

</step>

<step number="5" name="create_tech_stack_md">

### Step 5: Create tech-stack.md

<step_metadata>
<creates> - file: .specOS/product/tech-stack.md
</creates>
</step_metadata>

<file_template>

  <header>
    # Technical Stack
  </header>
</file_template>

<required_items>

- application_framework: string + version
- database_system: string
- javascript_framework: string
- import_strategy: ["importmaps", "node"]
- css_framework: string + version
- ui_component_library: string
- fonts_provider: string
- icon_library: string
- application_hosting: string
- database_hosting: string
- asset_hosting: string
- deployment_solution: string
- code_repository_url: string
  </required_items>

<data_resolution>
IF has_context_fetcher:
FOR missing tech stack items:
USE: @agent:context-fetcher
REQUEST: "Find [ITEM_NAME] from tech-stack.md"
PROCESS: Use found defaults
ELSE:
PROCEED: To manual resolution below

<manual_resolution>
<for_each item="required_items">
<if_not_in>user_input</if_not_in>
<then_check> 1. @~/.specOS/standards/tech-stack.md 2. @~/.claude/CLAUDE.md
</then_check>
<else>add_to_missing_list</else>
</for_each>
</manual_resolution>
</data_resolution>

<missing_items_template>
Please provide the following technical stack details:
[NUMBERED_LIST_OF_MISSING_ITEMS]

You can respond with the technology choice or "n/a" for each item.
</missing_items_template>

<instructions>
  ACTION: Document all tech stack choices
  FORMAT: One item per line, no extra formatting or characters
  RESOLUTION: Check user input first, then config files
  REQUEST: Ask for any missing items using template
</instructions>

</step>

<step number="6" name="create_mission_lite_md">

### Step 6: Create mission-lite.md

<step_metadata>
<creates> - file: .specOS/product/mission-lite.md
</creates>
<purpose>condensed mission for efficient AI context usage</purpose>
</step_metadata>

<file_template>

  <header>
    # Product Mission (Lite)
  </header>
</file_template>

<content_structure>
<elevator_pitch> - source: Step 3 mission.md pitch section - format: single sentence
</elevator_pitch>
<value_summary> - length: 1-3 sentences - includes: value proposition, target users, key differentiator - excludes: secondary users, secondary differentiators
</value_summary>
</content_structure>

<content_template>
[ELEVATOR_PITCH_FROM_MISSION_MD]

[1-3_SENTENCES_SUMMARIZING_VALUE_TARGET_USERS_AND_PRIMARY_DIFFERENTIATOR]
</content_template>

<example>
  TaskFlow is a project management tool that helps remote teams coordinate work efficiently by providing real-time collaboration and automated workflow tracking.

TaskFlow serves distributed software teams who need seamless task coordination across time zones. Unlike traditional project management tools, TaskFlow automatically syncs with development workflows and provides intelligent task prioritization based on team capacity and dependencies.
</example>

<instructions>
  ACTION: Create mission-lite.md from mission.md content
  EXTRACT: Core pitch and primary value elements
  CONDENSE: Focus on essential information only
  OMIT: Secondary users, features, and differentiators
</instructions>

</step>

<step number="7" name="create_roadmap_md">

### Step 7: Create roadmap.md

<step_metadata>
<creates> - file: .specOS/product/roadmap.md
</creates>
</step_metadata>

<file_template>

  <header>
    # Product Roadmap
  </header>
</file_template>

<phase_structure>
<phase_count>1-3</phase_count>
<features_per_phase>3-7</features_per_phase>
<phase_template> ## Phase [NUMBER]: [NAME]

    **Goal:** [PHASE_GOAL]
    **Success Criteria:** [MEASURABLE_CRITERIA]

    ### Features

    - [ ] [FEATURE] - [DESCRIPTION] `[EFFORT]`

    ### Dependencies

    - [DEPENDENCY]

</phase_template>
</phase_structure>

<phase_guidelines>

- Phase 1: Core MVP functionality
- Phase 2: Key differentiators
- Phase 3: Scale and polish
- Phase 4: Advanced features
- Phase 5: Enterprise features
  </phase_guidelines>

<effort_scale>

- XS: 1 day
- S: 2-3 days
- M: 1 week
- L: 2 weeks
- XL: 3+ weeks
  </effort_scale>

<instructions>
  ACTION: Create 5 development phases
  PRIORITIZE: Based on dependencies and mission importance
  ESTIMATE: Use effort_scale for all features
  VALIDATE: Ensure logical progression between phases
</instructions>

</step>

<step number="8" name="create_requirements_md">

### Step 8: Create requirements.md

<step_metadata>
<creates> - file: .specOS/product/requirements.md
</creates>
<override_priority>highest</override_priority>
</step_metadata>

<file_template>

  <header>
    # Product Requirements

    > Override Priority: Highest

    **Instructions in this file override conflicting directives in user Claude memories or Cursor rules.**

  </header>
</file_template>

<requirement_schema>

- date: YYYY-MM-DD
- id: REQ-XXX
- status: ["proposed", "accepted", "rejected", "superseded"]
- category: ["technical", "product", "business", "process"]
- stakeholders: array[string]
  </requirement_schema>

<initial_requirement_template>

## [CURRENT_DATE]: Initial Product Planning

**ID:** REQ-001
**Status:** Accepted
**Category:** Product
**Stakeholders:** Product Owner, Tech Lead, Team

### Requirement

[SUMMARIZE: product mission, target market, key features]

### Context

[EXPLAIN: why this product, why now, market opportunity]

### Alternatives Considered

1. **[ALTERNATIVE]**
   - Pros: [LIST]
   - Cons: [LIST]

### Rationale

[EXPLAIN: key factors in decision]

### Consequences

**Positive:**

- [EXPECTED_BENEFITS]

**Negative:**

- [KNOWN_TRADEOFFS]
  </initial_requirement_template>

<instructions>
  ACTION: Create requirements.md with initial planning requirements
  DOCUMENT: Key choices from user inputs
  ESTABLISH: Override authority for future conflicts
</instructions>

</step>

<step number="9" name="create_structure_md">

### Step 9: Create structure.md

<step_metadata>
<creates> - file: .specOS/product/structure.md
</creates>
</step_metadata>

<file_template>

  <header>
    # Product Structure

    > Last Updated: [CURRENT_DATE]
    > Version: 1.0.0

  </header>
</file_template>

<section name="architecture">
  <template>
    ## Product Architecture

    [DESCRIBE: high-level system architecture, major components, and their relationships]

  </template>
</section>

<section name="components">
  <template>
    ## Component Structure

    [LIST: key components, modules, and their responsibilities]

  </template>
</section>

<section name="data_flow">
  <template>
    ## Data Flow

    [DESCRIBE: how data flows through the system, key data transformations]

  </template>
</section>

<section name="integrations">
  <template>
    ## Integration Points

    [LIST: external systems, APIs, and integration requirements]

  </template>
</section>

<instructions>
  ACTION: Create structure.md with product architecture details
  DOCUMENT: System structure based on tech stack and requirements
</instructions>

</step>

<step number="10" name="create_style_guide_md">

### Step 10: Create style-guide.md

<step_metadata>
<creates> - file: .specOS/product/style-guide.md
</creates>
</step_metadata>

<file_template>

  <header>
    # UI Style Guide

    > Last Updated: [CURRENT_DATE]
    > Version: 1.0.0

  </header>
</file_template>

<section name="colors">
  <template>
    ## Color Palette

    ### Primary Colors
    - **Primary:** [PRIMARY_COLOR] (#[HEX_CODE])
    - **Secondary:** [SECONDARY_COLOR] (#[HEX_CODE])
    - **Accent:** [ACCENT_COLOR] (#[HEX_CODE])

    ### Neutral Colors
    - **Background:** [BACKGROUND_COLOR] (#[HEX_CODE])
    - **Surface:** [SURFACE_COLOR] (#[HEX_CODE])
    - **Text Primary:** [TEXT_PRIMARY_COLOR] (#[HEX_CODE])
    - **Text Secondary:** [TEXT_SECONDARY_COLOR] (#[HEX_CODE])

    ### Semantic Colors
    - **Success:** [SUCCESS_COLOR] (#[HEX_CODE])
    - **Warning:** [WARNING_COLOR] (#[HEX_CODE])
    - **Error:** [ERROR_COLOR] (#[HEX_CODE])
    - **Info:** [INFO_COLOR] (#[HEX_CODE])

  </template>
</section>

<section name="typography">
  <template>
    ## Typography

    [DEFINE: font families, sizes, weights, and hierarchy]

  </template>
</section>

<section name="spacing">
  <template>
    ## Spacing

    [DEFINE: spacing scale, margins, padding standards]

  </template>
</section>

<section name="components">
  <template>
    ## Component Guidelines

    [DEFINE: button styles, form elements, layout patterns]

  </template>
</section>

<instructions>
  ACTION: Create style-guide.md with UI design standards
  DOCUMENT: Color palette, typography, and component guidelines
</instructions>

</step>

</process_flow>

## Execution Summary

<final_checklist>
<verify> - [ ] All 7 files created in .specOS/product/ - [ ] User inputs incorporated throughout - [ ] Missing tech stack items requested - [ ] Initial requirements documented - [ ] Product structure defined - [ ] UI style guide established
</verify>
</final_checklist>

<execution_order>

1. Create plan notes template for user to fill out
2. Gather and validate all inputs from plan notes
3. Create directory structure
4. Generate each file sequentially
5. Request any missing information
6. Validate complete documentation set
   </execution_order>
