<!-- Version: 1.0.0 - Add version numbers to all markdown files -->

# Folder Structure Best Practices

## Context

Global folder structure guidelines for specOS projects, organized by tech stack and project type.

## Core Principles

### Separation of Concerns

- **Frontend/Backend Separation**: Clear boundaries between client and server code
- **Feature-Based Organization**: Group related functionality together
- **Layer Separation**: Separate data, business logic, and presentation layers
- **Configuration Isolation**: Keep configuration separate from application code

### Scalability

- **Predictable Structure**: Consistent patterns across all projects
- **Modular Design**: Easy to add/remove features without affecting others
- **Clear Dependencies**: Explicit import/export relationships
- **Test Co-location**: Tests alongside the code they test

## Tech Stack Specific Structures

### React + Node.js + PostgreSQL (Full-Stack)

```
project-root/
├── client/                          # Frontend React application
│   ├── public/                      # Static assets
│   │   ├── index.html
│   │   ├── favicon.ico
│   │   └── assets/
│   ├── src/
│   │   ├── components/              # Reusable UI components
│   │   │   ├── common/              # Shared components (Button, Input, etc.)
│   │   │   ├── layout/              # Layout components (Header, Sidebar, etc.)
│   │   │   └── features/            # Feature-specific components
│   │   ├── pages/                   # Page-level components
│   │   ├── hooks/                   # Custom React hooks
│   │   ├── services/                # API calls and external services
│   │   ├── utils/                   # Utility functions
│   │   ├── types/                   # TypeScript type definitions
│   │   ├── constants/               # Application constants
│   │   ├── styles/                  # Global styles and CSS modules
│   │   ├── App.tsx
│   │   └── index.tsx
│   ├── package.json
│   ├── tsconfig.json
│   ├── vite.config.ts
│   └── tailwind.config.js
├── server/                          # Backend Node.js application
│   ├── src/
│   │   ├── controllers/             # Request handlers
│   │   ├── models/                  # Data models and database schemas
│   │   ├── routes/                  # API route definitions
│   │   ├── middleware/              # Express middleware
│   │   ├── services/                # Business logic
│   │   ├── utils/                   # Utility functions
│   │   ├── types/                   # TypeScript type definitions
│   │   ├── config/                  # Configuration files
│   │   ├── migrations/              # Database migrations
│   │   ├── seeds/                   # Database seed data
│   │   └── app.ts                   # Application entry point
│   ├── tests/                       # Backend tests
│   │   ├── unit/
│   │   ├── integration/
│   │   └── e2e/
│   ├── package.json
│   ├── tsconfig.json
│   └── .env.example
├── shared/                          # Shared code between client/server
│   ├── types/                       # Shared TypeScript types
│   ├── constants/                   # Shared constants
│   └── utils/                       # Shared utilities
├── docs/                            # Project documentation
│   ├── api/                         # API documentation
│   ├── deployment/                  # Deployment guides
│   └── development/                 # Development setup
├── scripts/                         # Build and deployment scripts
├── .github/                         # GitHub workflows
├── .specOS/                         # specOS configuration
├── package.json                     # Root package.json for scripts
├── docker-compose.yml              # Local development environment
├── Dockerfile                      # Production container
└── README.md
```

### Next.js + PostgreSQL (Full-Stack)

```
project-root/
├── app/                             # App Router (Next.js 13+)
│   ├── (auth)/                      # Route groups
│   │   ├── login/
│   │   └── register/
│   ├── api/                         # API routes
│   │   ├── auth/
│   │   ├── users/
│   │   └── middleware.ts
│   ├── globals.css
│   ├── layout.tsx
│   └── page.tsx
├── components/                      # Reusable components
│   ├── ui/                          # Base UI components
│   ├── forms/                       # Form components
│   └── features/                    # Feature-specific components
├── lib/                             # Utility libraries
│   ├── db.ts                        # Database connection
│   ├── auth.ts                      # Authentication utilities
│   └── utils.ts                     # General utilities
├── types/                           # TypeScript definitions
├── styles/                          # Additional styles
├── prisma/                          # Database schema and migrations
│   ├── schema.prisma
│   └── migrations/
├── public/                          # Static assets
├── tests/                           # Test files
├── docs/                            # Documentation
├── .specOS/                         # specOS configuration
├── package.json
├── next.config.js
├── tailwind.config.js
├── tsconfig.json
└── README.md
```

### Express.js + React (Separate Repos)

#### Backend Repository

```
backend/
├── src/
│   ├── controllers/                 # Request handlers
│   ├── models/                      # Data models
│   ├── routes/                      # Route definitions
│   ├── middleware/                  # Custom middleware
│   ├── services/                    # Business logic
│   ├── utils/                       # Utility functions
│   ├── config/                      # Configuration
│   ├── migrations/                  # Database migrations
│   ├── seeds/                       # Seed data
│   └── app.js                       # Application entry
├── tests/
├── docs/
├── package.json
└── README.md
```

#### Frontend Repository

```
frontend/
├── public/
├── src/
│   ├── components/
│   ├── pages/
│   ├── hooks/
│   ├── services/
│   ├── utils/
│   ├── types/
│   └── App.tsx
├── package.json
└── README.md
```

## Component Organization

### React Components Structure

```
components/
├── ui/                              # Base UI components
│   ├── Button/
│   │   ├── Button.tsx
│   │   ├── Button.test.tsx
│   │   ├── Button.stories.tsx       # Storybook stories
│   │   └── index.ts
│   ├── Input/
│   ├── Modal/
│   └── index.ts                     # Barrel exports
├── layout/                          # Layout components
│   ├── Header/
│   ├── Sidebar/
│   ├── Footer/
│   └── Layout.tsx
├── forms/                           # Form components
│   ├── LoginForm/
│   ├── RegistrationForm/
│   └── ContactForm/
└── features/                        # Feature-specific components
    ├── dashboard/
    │   ├── DashboardCard/
    │   ├── DashboardStats/
    │   └── DashboardChart/
    └── user/
        ├── UserProfile/
        ├── UserList/
        └── UserCard/
```

## File Naming Conventions

### Components

- **PascalCase**: `UserProfile.tsx`, `DashboardCard.tsx`
- **Index files**: `index.ts` for barrel exports
- **Test files**: `ComponentName.test.tsx`
- **Story files**: `ComponentName.stories.tsx`

### Utilities and Services

- **camelCase**: `dateUtils.ts`, `apiService.ts`
- **Constants**: `UPPER_SNAKE_CASE`: `API_ENDPOINTS.ts`

### Pages and Routes

- **kebab-case**: `user-profile.tsx`, `dashboard-overview.tsx`
- **Dynamic routes**: `[id].tsx`, `[slug].tsx`

## Database Organization

### Migrations

```
migrations/
├── 001_create_users_table.sql
├── 002_create_posts_table.sql
├── 003_add_user_avatar.sql
└── 004_create_comments_table.sql
```

### Seeds

```
seeds/
├── users.sql
├── posts.sql
└── comments.sql
```

## Testing Structure

### Test Organization

```
tests/
├── unit/                            # Unit tests
│   ├── components/
│   ├── services/
│   └── utils/
├── integration/                     # Integration tests
│   ├── api/
│   └── database/
├── e2e/                            # End-to-end tests
│   ├── user-flows/
│   └── critical-paths/
└── fixtures/                        # Test data
    ├── users.json
    └── posts.json
```

## Configuration Files

### Environment Configuration

```
config/
├── database.ts                      # Database configuration
├── auth.ts                          # Authentication settings
├── email.ts                         # Email service configuration
├── redis.ts                         # Redis configuration
└── index.ts                         # Main config export
```

### Build Configuration

- **Vite**: `vite.config.ts`
- **Webpack**: `webpack.config.js`
- **TypeScript**: `tsconfig.json`
- **ESLint**: `.eslintrc.js`
- **Prettier**: `.prettierrc`

## Documentation Structure

```
docs/
├── api/                             # API documentation
│   ├── endpoints.md
│   ├── authentication.md
│   └── examples.md
├── deployment/                      # Deployment guides
│   ├── production.md
│   ├── staging.md
│   └── local.md
├── development/                     # Development guides
│   ├── setup.md
│   ├── contributing.md
│   └── architecture.md
└── user/                           # User documentation
    ├── getting-started.md
    ├── features.md
    └── troubleshooting.md
```

## Best Practices Summary

### Do's

- ✅ Use consistent naming conventions
- ✅ Group related files together
- ✅ Keep components small and focused
- ✅ Co-locate tests with source code
- ✅ Use barrel exports for clean imports
- ✅ Separate concerns clearly
- ✅ Document folder structure decisions

### Don'ts

- ❌ Don't create deeply nested folders (>4 levels)
- ❌ Don't mix different naming conventions
- ❌ Don't put everything in one folder
- ❌ Don't ignore the importance of clear imports
- ❌ Don't forget to update documentation when structure changes

## Migration Guidelines

When restructuring existing projects:

1. **Plan the migration** - Document current vs. target structure
2. **Create a script** - Automate the file moves where possible
3. **Update imports** - Use search/replace to fix import paths
4. **Test thoroughly** - Ensure all functionality still works
5. **Update documentation** - Reflect new structure in docs
6. **Communicate changes** - Inform team of new conventions
