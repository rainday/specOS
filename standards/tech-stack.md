# Tech Stack Standards

## Context

Global tech stack defaults for specOS projects, overridable in project-specific `.specOS/product/tech-stack.md`.

<conditional-block context-check="core-stack">
IF this Core Stack section already read in current context:
  SKIP: Re-reading this section
  NOTE: "Using Core Stack already in context"
ELSE:
  READ: The following core technology stack

## Core Stack

### Backend Framework

- **Primary**: Express.js 4.18+ / Fastify 4.0+ (project-specific choice)
- **Language**: JavaScript (ES2022+) / TypeScript 5.0+
- **Runtime**: Node.js 22 LTS
- **Rationale**: Lightweight, flexible, excellent ecosystem, TypeScript support
- **Alternatives**: Consider NestJS for enterprise applications, Koa.js for middleware-focused apps

### Database Layer

- **Primary Database**: PostgreSQL 17+
- **ORM**: Active Record
- **Backup Strategy**: Daily automated backups with 30-day retention
- **Rationale**: ACID compliance, JSON support, excellent performance
- **Alternatives**: MySQL 8.0+ for simpler deployments, Redis for caching layer

### Frontend Framework

- **JavaScript Framework**: React 18+ (latest stable)
- **Build Tool**: Vite 5.0+
- **Import Strategy**: ES6 modules with Node.js resolution
- **Package Manager**: npm 10+ (with package-lock.json)
- **Node Version**: 22 LTS
- **Rationale**: Component-based architecture, large ecosystem, excellent tooling
- **Alternatives**: Vue.js 3+ for simpler applications, Svelte for performance-critical apps
  </conditional-block>

<conditional-block context-check="ui-framework" task-condition="frontend-development">
IF current task involves frontend development:
  IF this UI Framework section already read in current context:
    SKIP: Re-reading this section
    NOTE: "Using UI Framework guidelines already in context"
  ELSE:
    READ: The following UI framework specifications
ELSE:
  SKIP: UI Framework section not relevant to current task

## UI Framework

### Styling & Components

- **CSS Framework**: TailwindCSS 4.0+
- **UI Component Library**: shadcn/ui (latest stable)
- **Installation Method**: Via CLI with component-by-component installation
- **Icon System**: Lucide React components
- **Font Provider**: Google Fonts (self-hosted for performance)
- **Rationale**: Utility-first CSS, copy-paste components, excellent customization, TypeScript support
- **Alternatives**: Bootstrap 5+ for rapid prototyping, Material-UI for Google Material Design
  </conditional-block>

<conditional-block context-check="infrastructure" task-condition="deployment-hosting">
IF current task involves deployment or hosting decisions:
  IF this Infrastructure section already read in current context:
    SKIP: Re-reading this section
    NOTE: "Using Infrastructure guidelines already in context"
  ELSE:
    READ: The following infrastructure specifications
ELSE:
  SKIP: Infrastructure section not relevant to current task

## Infrastructure & Hosting

### Application Hosting

- **Platform**: Digital Ocean App Platform (primary) / Droplets (custom needs)
- **Region Selection**: Primary region based on user base analysis
- **Auto-scaling**: Enabled for production environments
- **Health Checks**: HTTP endpoint monitoring with 30-second intervals

### Database Hosting

- **Platform**: Digital Ocean Managed PostgreSQL
- **Backup Strategy**: Daily automated backups with point-in-time recovery
- **Monitoring**: Performance insights and query analysis
- **Connection Pooling**: PgBouncer for connection management

### Asset Management

- **Storage**: Amazon S3 (Standard storage class)
- **CDN**: CloudFront with global edge locations
- **Access Control**: Private buckets with signed URLs (24-hour expiration)
- **Image Optimization**: Automatic WebP conversion and responsive sizing
  </conditional-block>

<conditional-block context-check="ci-cd" task-condition="deployment-automation">
IF current task involves CI/CD or deployment automation:
  IF this CI/CD section already read in current context:
    SKIP: Re-reading this section
    NOTE: "Using CI/CD guidelines already in context"
  ELSE:
    READ: The following CI/CD specifications
ELSE:
  SKIP: CI/CD section not relevant to current task

## CI/CD & Deployment

### Pipeline Platform

- **CI/CD Platform**: GitHub Actions
- **Trigger Events**: Push to main/staging branches, pull request creation
- **Test Execution**: Run before deployment (unit, integration, E2E)
- **Security Scanning**: Dependabot alerts, CodeQL analysis

### Environment Strategy

- **Production**: main branch (auto-deploy on merge)
- **Staging**: staging branch (auto-deploy on push)
- **Development**: feature branches (manual deployment)
- **Database Migrations**: Run automatically in staging, manual approval for production
  </conditional-block>

<conditional-block context-check="security" task-condition="security-implementation">
IF current task involves security considerations:
  IF this Security section already read in current context:
    SKIP: Re-reading this section
    NOTE: "Using Security guidelines already in context"
  ELSE:
    READ: The following security specifications
ELSE:
  SKIP: Security section not relevant to current task

## Security & Compliance

### Authentication & Authorization

- **Framework**: Passport.js / NextAuth.js with JWT tokens
- **Password Policy**: Minimum 12 characters, complexity requirements
- **Session Management**: Secure, HTTP-only cookies with CSRF protection
- **OAuth Providers**: Google, GitHub, Microsoft (configurable)

### Data Protection

- **Encryption**: AES-256 for data at rest, TLS 1.3 for data in transit
- **PII Handling**: Automatic data anonymization for analytics
- **Compliance**: GDPR-ready data processing workflows
- **Audit Logging**: All user actions logged with immutable timestamps
  </conditional-block>

<conditional-block context-check="monitoring" task-condition="observability">
IF current task involves monitoring or observability:
  IF this Monitoring section already read in current context:
    SKIP: Re-reading this section
    NOTE: "Using Monitoring guidelines already in context"
  ELSE:
    READ: The following monitoring specifications
ELSE:
  SKIP: Monitoring section not relevant to current task

## Monitoring & Observability

### Application Monitoring

- **APM**: New Relic or DataDog (project-specific choice)
- **Error Tracking**: Sentry with real-time alerting
- **Performance Metrics**: Response time, throughput, error rates
- **Health Checks**: Custom endpoints for critical service dependencies

### Infrastructure Monitoring

- **Server Monitoring**: Digital Ocean monitoring + custom metrics
- **Database Monitoring**: PostgreSQL query performance and connection metrics
- **Uptime Monitoring**: External service monitoring with 5-minute intervals
- **Alerting**: Slack/email notifications for critical issues
  </conditional-block>

## Version Management

### Dependency Updates

- **Automated Updates**: Dependabot for security patches
- **Major Version Updates**: Quarterly review and testing
- **Breaking Changes**: Staged rollout with feature flags
- **Compatibility Matrix**: Maintained for all component versions

### Migration Strategy

- **Database Migrations**: Zero-downtime deployments with rollback capability
- **API Versioning**: Semantic versioning with backward compatibility
- **Feature Flags**: LaunchDarkly or similar for gradual rollouts
- **Rollback Plan**: 5-minute rollback capability for critical issues
