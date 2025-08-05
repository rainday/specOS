<!-- Version: 1.1.2 - Add version numbers to all markdown files -->

# specOS - Structured AI-Assisted Development Framework

specOS is a comprehensive framework for Spec Driven AI-assisted software development, designed to work seamlessly with Claude Code and other AI development tools.

## Purpose

specOS provides a systematic approach to:

- **Product Planning**: Structured product ideation and roadmap development
- **Feature Specification**: Detailed, testable feature specifications
- **Task Execution**: Systematic implementation with TDD approach
- **Code Quality**: Automated code review and bug fixing
- **Project Management**: Git workflow automation and documentation

## Architecture

### Core Components

```
specOS/
├── claude-code/      # Claude Code integration
├── agents/           # Specialized AI agents
├── user/             # User configuration
├── commands/         # Claude Code commands
├── instructions/     # Workflow instructions
├── standards/        # Development standards
└── setup.sh          # Installation script
```

### Specialized Agents

- **bug-fixer**: Systematic debugging and error resolution
- **code-reviewer**: Comprehensive code quality and security review
- **data-scientist**: SQL analysis and data insights
- **context-fetcher**: Smart information retrieval
- **file-creator**: Template-based file generation
- **git-workflow**: Automated git operations

## Getting Started

### Quick Installation

Run this command in your project directory to install specOS:

```bash
curl -sSL https://raw.githubusercontent.com/rainday/specOS/main/setup.sh | bash
```

**What this does:**

- Downloads and executes the specOS setup script
- Creates necessary directories in your home folder (`~/.specOS/`, `~/.claude/`)
- Downloads all development standards, instructions, and Claude Code configurations
- Sets up specialized AI agents for code review, bug fixing, data analysis, and more
- Configures Claude Code commands for seamless integration

### Manual Installation

Alternatively, you can clone the repository and run the setup manually:

```bash
# Clone the repository
git clone https://github.com/rainday/specOS.git
cd specOS

# Run the setup script
./setup.sh
```

### Quick Start

1. **Plan a new product**:

   ```bash
   /plan-product
   ```

2. **Analyze existing codebase**:

   ```bash
   /analyze-product
   ```

3. **Create a feature spec**:

   ```bash
   /create-spec
   ```

4. **Execute tasks**:
   ```bash
   /execute-tasks
   ```

## How to Use specOS

### Getting Started with a New Project

1. **Install specOS** (if not already done):

   ```bash
   curl -sSL https://raw.githubusercontent.com/rainday/specOS/main/setup.sh | bash
   ```

2. **Initialize your project**:
   ```bash
   /plan-product
   ```
   This will guide you through:
   - Defining your product mission and vision
   - Identifying target users and key features
   - Setting up your tech stack
   - Creating initial project structure

### Working with Existing Projects

1. **Analyze your codebase**:
   ```bash
   /analyze-product
   ```
   This will:
   - Review your existing code structure
   - Identify areas for improvement
   - Suggest optimizations
   - Create project documentation

### Feature Development Workflow

1. **Create a feature specification**:

   ```bash
   /create-spec
   ```

   Or simply ask: "What's next?" or "Create a spec for [feature name]"

2. **Implement the feature**:
   ```bash
   /execute-task
   ```
   This follows TDD approach with:
   - Test creation
   - Implementation
   - Code review
   - Quality assurance

### Using Specialized Agents

specOS includes several specialized AI agents that activate automatically:

- **🪲 Bug Fixer**: Automatically detects and fixes code issues
- **🧐 Code Reviewer**: Reviews code for quality, security, and best practices
- **📊 Data Scientist**: Analyzes SQL queries and provides data insights
- **🔍 Context Fetcher**: Retrieves relevant information from your codebase
- **📁 File Creator**: Generates files from templates
- **🌳 Git Workflow**: Manages git operations and commits

### Best Practices

1. **Start with planning**: Always use `/plan-product` for new projects
2. **Be specific**: When creating specs, provide clear requirements
3. **Iterate**: Use the agents to review and improve your code
4. **Document**: Let specOS handle documentation automatically
5. **Test first**: The framework follows TDD principles

### Common Commands

| Command            | Purpose                      | When to Use                |
| ------------------ | ---------------------------- | -------------------------- |
| `/plan-product`    | Initialize new project       | Starting a new project     |
| `/analyze-product` | Analyze existing codebase    | Working with existing code |
| `/create-spec`     | Create feature specification | Adding new features        |
| `/execute-task`    | Implement features           | Building functionality     |
| `What's next?`     | Get next steps               | General guidance           |

## Workflow

### 1. Product Planning

- Define product mission and vision
- Identify target users and key features
- Create technical roadmap
- Establish development standards

### 2. Feature Specification

- Create detailed feature specifications
- Define technical requirements
- Plan database and API changes
- Break down into testable tasks

### 3. Implementation

- Follow TDD approach
- Use specialized agents for quality assurance
- Maintain consistent code standards
- Automate git workflow

### 4. Quality Assurance

- Automated code review
- Security analysis
- Performance optimization
- Comprehensive testing

## Configuration

### Global Standards

- **Tech Stack**: `~/.specOS/standards/tech-stack.md`
- **Code Style**: `~/.specOS/standards/code-style.md`
- **Best Practices**: `~/.specOS/standards/best-practices.md`

### Project-Specific Overrides

- **Product Mission**: `.specOS/product/mission.md`
- **Tech Stack**: `.specOS/product/tech-stack.md`
- **Requirements**: `.specOS/product/requirements.md`

## Documentation

### Instructions

- **plan-product.md**: New product initialization
- **create-spec.md**: Feature specification creation
- **execute-tasks.md**: Task implementation workflow
- **analyze-product.md**: Existing codebase analysis

### Standards

- **tech-stack.md**: Technology stack defaults
- **best-practices.md**: Development guidelines
- **code-style/**: Language-specific style guides

## Customization

### Adding Custom Agents

1. Create agent file in `claude-code/agents/`
2. Define agent metadata and capabilities
3. Update setup script to include new agent

### Modifying Standards

1. Edit files in `standards/` directory
2. Run setup script with `--overwrite-standards`
3. Test changes in a sample project

### Extending Workflows

1. Modify instruction files in `instructions/`
2. Update command files in `commands/`
3. Test workflow changes

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- **Documentation**: [GitHub README](https://github.com/rainday/specOS)
- **Issues**: [GitHub Issues](https://github.com/rainday/specOS/issues)
- **Discussions**: [GitHub Discussions](https://github.com/rainday/specOS/discussions)

## Version History

- **v1.1.1** (2024-01-16): Added Japanese language support and improved Cursor integration
- **v1.1.0** (2024-01-15): Enhanced spec creation workflow
- **v1.0.0** (2024-01-10): Initial release with core functionality

---

**Built with ?��? by the Rainday**
