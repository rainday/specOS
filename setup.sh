#!/bin/bash

# specOS Claude Code Setup Script
# This script installs specOS files for Claude Code

set -e  # Exit on error

# Initialize flags
OVERWRITE_INSTRUCTIONS=true
OVERWRITE_STANDARDS=true

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --overwrite-instructions)
            OVERWRITE_INSTRUCTIONS=true
            shift
            ;;
        --overwrite-standards)
            OVERWRITE_STANDARDS=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --overwrite-instructions    Overwrite existing instruction files"
            echo "  --overwrite-standards       Overwrite existing standards files"
            echo "  -h, --help                  Show this help message"
            echo ""
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

echo "🚀 specOS Claude Code Setup"
echo "============================="
echo ""

# Base URL for raw GitHub content
BASE_URL="https://raw.githubusercontent.com/rainday/specOS/main"

# Create directories
echo "📁 Creating directories..."
mkdir -p "$HOME/.specOS/standards"
mkdir -p "$HOME/.specOS/standards/code-style"
mkdir -p "$HOME/.specOS/instructions"
mkdir -p "$HOME/.claude/commands"
mkdir -p "$HOME/.claude/agents"

# Download standards files
echo ""
echo "📥 Downloading standards files to ~/.specOS/standards/"

# tech-stack.md
if [ -f "$HOME/.specOS/standards/tech-stack.md" ] && [ "$OVERWRITE_STANDARDS" = false ]; then
    echo "  ⚠️  ~/.specOS/standards/tech-stack.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/standards/tech-stack.md" "${BASE_URL}/standards/tech-stack.md"
    if [ -f "$HOME/.specOS/standards/tech-stack.md" ] && [ "$OVERWRITE_STANDARDS" = true ]; then
        echo "  ✓ ~/.specOS/standards/tech-stack.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/standards/tech-stack.md"
    fi
fi

# code-style.md
if [ -f "$HOME/.specOS/standards/code-style.md" ] && [ "$OVERWRITE_STANDARDS" = false ]; then
    echo "  ⚠️  ~/.specOS/standards/code-style.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/standards/code-style.md" "${BASE_URL}/standards/code-style.md"
    if [ -f "$HOME/.specOS/standards/code-style.md" ] && [ "$OVERWRITE_STANDARDS" = true ]; then
        echo "  ✓ ~/.specOS/standards/code-style.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/standards/code-style.md"
    fi
fi

# best-practices.md
if [ -f "$HOME/.specOS/standards/best-practices.md" ] && [ "$OVERWRITE_STANDARDS" = false ]; then
    echo "  ⚠️  ~/.specOS/standards/best-practices.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/standards/best-practices.md" "${BASE_URL}/standards/best-practices.md"
    if [ -f "$HOME/.specOS/standards/best-practices.md" ] && [ "$OVERWRITE_STANDARDS" = true ]; then
        echo "  ✓ ~/.specOS/standards/best-practices.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/standards/best-practices.md"
    fi
fi

# testing-standards.md
if [ -f "$HOME/.specOS/standards/testing-standards.md" ] && [ "$OVERWRITE_STANDARDS" = false ]; then
    echo "  ⚠️  ~/.specOS/standards/testing-standards.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/standards/testing-standards.md" "${BASE_URL}/standards/testing-standards.md"
    if [ -f "$HOME/.specOS/standards/testing-standards.md" ] && [ "$OVERWRITE_STANDARDS" = true ]; then
        echo "  ✓ ~/.specOS/standards/testing-standards.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/standards/testing-standards.md"
    fi
fi

# security-standards.md
if [ -f "$HOME/.specOS/standards/security-standards.md" ] && [ "$OVERWRITE_STANDARDS" = false ]; then
    echo "  ⚠️  ~/.specOS/standards/security-standards.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/standards/security-standards.md" "${BASE_URL}/standards/security-standards.md"
    if [ -f "$HOME/.specOS/standards/security-standards.md" ] && [ "$OVERWRITE_STANDARDS" = true ]; then
        echo "  ✓ ~/.specOS/standards/security-standards.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/standards/security-standards.md"
    fi
fi

# performance-standards.md
if [ -f "$HOME/.specOS/standards/performance-standards.md" ] && [ "$OVERWRITE_STANDARDS" = false ]; then
    echo "  ⚠️  ~/.specOS/standards/performance-standards.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/standards/performance-standards.md" "${BASE_URL}/standards/performance-standards.md"
    if [ -f "$HOME/.specOS/standards/performance-standards.md" ] && [ "$OVERWRITE_STANDARDS" = true ]; then
        echo "  ✓ ~/.specOS/standards/performance-standards.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/standards/performance-standards.md"
    fi
fi

# Download code-style subdirectory files
echo ""
echo "📥 Downloading code style files to ~/.specOS/standards/code-style/"

# css-style.md
if [ -f "$HOME/.specOS/standards/code-style/css-style.md" ] && [ "$OVERWRITE_STANDARDS" = false ]; then
    echo "  ⚠️  ~/.specOS/standards/code-style/css-style.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/standards/code-style/css-style.md" "${BASE_URL}/standards/code-style/css-style.md"
    if [ -f "$HOME/.specOS/standards/code-style/css-style.md" ] && [ "$OVERWRITE_STANDARDS" = true ]; then
        echo "  ✓ ~/.specOS/standards/code-style/css-style.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/standards/code-style/css-style.md"
    fi
fi

# html-style.md
if [ -f "$HOME/.specOS/standards/code-style/html-style.md" ] && [ "$OVERWRITE_STANDARDS" = false ]; then
    echo "  ⚠️  ~/.specOS/standards/code-style/html-style.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/standards/code-style/html-style.md" "${BASE_URL}/standards/code-style/html-style.md"
    if [ -f "$HOME/.specOS/standards/code-style/html-style.md" ] && [ "$OVERWRITE_STANDARDS" = true ]; then
        echo "  ✓ ~/.specOS/standards/code-style/html-style.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/standards/code-style/html-style.md"
    fi
fi

# javascript-style.md
if [ -f "$HOME/.specOS/standards/code-style/javascript-style.md" ] && [ "$OVERWRITE_STANDARDS" = false ]; then
    echo "  ⚠️  ~/.specOS/standards/code-style/javascript-style.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/standards/code-style/javascript-style.md" "${BASE_URL}/standards/code-style/javascript-style.md"
    if [ -f "$HOME/.specOS/standards/code-style/javascript-style.md" ] && [ "$OVERWRITE_STANDARDS" = true ]; then
        echo "  ✓ ~/.specOS/standards/code-style/javascript-style.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/standards/code-style/javascript-style.md"
    fi
fi



# Download instruction files
echo ""
echo "📥 Downloading instruction files to ~/.specOS/instructions/"

# plan-product.md
if [ -f "$HOME/.specOS/instructions/plan-product.md" ] && [ "$OVERWRITE_INSTRUCTIONS" = false ]; then
    echo "  ⚠️  ~/.specOS/instructions/plan-product.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/instructions/plan-product.md" "${BASE_URL}/instructions/plan-product.md"
    if [ -f "$HOME/.specOS/instructions/plan-product.md" ] && [ "$OVERWRITE_INSTRUCTIONS" = true ]; then
        echo "  ✓ ~/.specOS/instructions/plan-product.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/instructions/plan-product.md"
    fi
fi

# create-spec.md
if [ -f "$HOME/.specOS/instructions/create-spec.md" ] && [ "$OVERWRITE_INSTRUCTIONS" = false ]; then
  echo "  ⚠️  ~/.specOS/instructions/create-spec.md already exists - skipping"
else
  curl -s -o "$HOME/.specOS/instructions/create-spec.md" "${BASE_URL}/instructions/create-spec.md"
  if [ -f "$HOME/.specOS/instructions/create-spec.md" ] && [ "$OVERWRITE_INSTRUCTIONS" = true ]; then
    echo "  ✓ ~/.specOS/instructions/create-spec.md (overwritten)"
  else
    echo "  ✓ ~/.specOS/instructions/create-spec.md"
  fi
fi

# execute-tasks.md
if [ -f "$HOME/.specOS/instructions/execute-tasks.md" ] && [ "$OVERWRITE_INSTRUCTIONS" = false ]; then
    echo "  ⚠️  ~/.specOS/instructions/execute-tasks.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/instructions/execute-tasks.md" "${BASE_URL}/instructions/execute-tasks.md"
    if [ -f "$HOME/.specOS/instructions/execute-tasks.md" ] && [ "$OVERWRITE_INSTRUCTIONS" = true ]; then
        echo "  ✓ ~/.specOS/instructions/execute-tasks.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/instructions/execute-tasks.md"
    fi
fi

# execute-task.md
if [ -f "$HOME/.specOS/instructions/execute-task.md" ] && [ "$OVERWRITE_INSTRUCTIONS" = false ]; then
    echo "  ⚠️  ~/.specOS/instructions/execute-task.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/instructions/execute-task.md" "${BASE_URL}/instructions/execute-task.md"
    if [ -f "$HOME/.specOS/instructions/execute-task.md" ] && [ "$OVERWRITE_INSTRUCTIONS" = true ]; then
        echo "  ✓ ~/.specOS/instructions/execute-task.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/instructions/execute-task.md"
    fi
fi

# analyze-product.md
if [ -f "$HOME/.specOS/instructions/analyze-product.md" ] && [ "$OVERWRITE_INSTRUCTIONS" = false ]; then
    echo "  ⚠️  ~/.specOS/instructions/analyze-product.md already exists - skipping"
else
    curl -s -o "$HOME/.specOS/instructions/analyze-product.md" "${BASE_URL}/instructions/analyze-product.md"
    if [ -f "$HOME/.specOS/instructions/analyze-product.md" ] && [ "$OVERWRITE_INSTRUCTIONS" = true ]; then
        echo "  ✓ ~/.specOS/instructions/analyze-product.md (overwritten)"
    else
        echo "  ✓ ~/.specOS/instructions/analyze-product.md"
    fi
fi

# Download Claude Code command files
echo ""
echo "📥 Downloading Claude Code command files to ~/.claude/commands/"

# Commands
for cmd in plan-product create-spec execute-tasks analyze-product; do
    if [ -f "$HOME/.claude/commands/${cmd}.md" ]; then
        echo "  ⚠️  ~/.claude/commands/${cmd}.md already exists - skipping"
    else
        curl -s -o "$HOME/.claude/commands/${cmd}.md" "${BASE_URL}/commands/${cmd}.md"
        echo "  ✓ ~/.claude/commands/${cmd}.md"
    fi
done

# Download Claude Code user CLAUDE.md
echo ""
echo "📥 Downloading Claude Code configuration..."

if [ -f "$HOME/.claude/CLAUDE.md" ]; then
    echo "  ⚠️  ~/.claude/CLAUDE.md already exists - installing to project directory"
    # Create .claude directory in current project if it doesn't exist
    mkdir -p ".claude"
    curl -s -o ".claude/CLAUDE.md" "${BASE_URL}/claude-code/user/CLAUDE.md"
    echo "  ✓ .claude/CLAUDE.md (project directory)"
else
    curl -s -o "$HOME/.claude/CLAUDE.md" "${BASE_URL}/claude-code/user/CLAUDE.md"
    echo "  ✓ ~/.claude/CLAUDE.md"
fi

# Download Claude Code agents
echo ""
echo "📥 Downloading Claude Code subagents to ~/.claude/agents/"

# List of agent files to download
agents=("code-reviewer" "bug-fixer" "data-scientist" "context-fetcher" "file-creator" "git-workflow")

for agent in "${agents[@]}"; do
    if [ -f "$HOME/.claude/agents/${agent}.md" ]; then
        echo "  ⚠️  ~/.claude/agents/${agent}.md already exists - skipping"
    else
        curl -s -o "$HOME/.claude/agents/${agent}.md" "${BASE_URL}/claude-code/agents/${agent}.md"
        echo "  ✓ ~/.claude/agents/${agent}.md"
    fi
done

echo ""
echo "✅ specOS Claude Code installation complete!"
echo ""
echo "📍 Files installed to:"
echo "   ~/.specOS/standards/     - Your development standards"
echo "   ~/.specOS/instructions/  - specOS instructions"
echo "   ~/.claude/commands/      - Claude Code commands"
echo "   ~/.claude/agents/        - Claude Code specialized subagents"
echo "   ~/.claude/CLAUDE.md      - Claude Code configuration"
echo ""
if [ "$OVERWRITE_INSTRUCTIONS" = false ] && [ "$OVERWRITE_STANDARDS" = false ]; then
    echo "💡 Note: Existing files were skipped to preserve your customizations"
    echo "   Use --overwrite-instructions or --overwrite-standards to update specific files"
else
    echo "💡 Note: Some files were overwritten based on your flags"
    if [ "$OVERWRITE_INSTRUCTIONS" = false ]; then
        echo "   Existing instruction files were preserved"
    fi
    if [ "$OVERWRITE_STANDARDS" = false ]; then
        echo "   Existing standards files were preserved"
    fi
fi
echo ""
echo "Next steps:"
echo ""
echo "Initiate specOS in a new product's codebase with:"
echo "  /plan-product"
echo ""
echo "Initiate specOS in an existing product's codebase with:"
echo "  /analyze-product"
echo ""
echo "Initiate a new feature with:"
echo "  /create-spec (or simply ask 'what's next?')"
echo ""
echo "Build and ship code with:"
echo "  /execute-task"
echo ""
echo "Learn more at https://github.com/rainday/specOS"
echo ""
