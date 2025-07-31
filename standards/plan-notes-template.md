<!-- Version: 1.0.1 - Add version numbers to all markdown files -->

# Plan Notes Template

Fill out this template with your product information. Copy and paste any text - no special formatting needed. Leave sections empty if you don't have the information yet.

## Product Information

### Main Idea

What is your product? (1-2 sentences describing what it does and who it's for)

**Example:** A task management app for remote teams that automatically syncs with GitHub and Slack to provide real-time project visibility.

**Your Product:**
[Write your main idea here]

### Key Features (Minimum: 3)

List the main features your product will have:

**Example:**

1. Real-time task tracking with GitHub integration
2. Automated daily standup reports via Slack
3. Team workload visualization dashboard
4. Smart task prioritization based on deadlines
5. One-click time tracking and reporting

**Your Features:**

1. [Feature 1]
2. [Feature 2]
3. [Feature 3]
4. [Feature 4]
5. [Feature 5]

### Target Users (Minimum: 1)

Who will use your product? Include their role, context, and main problems.

**Example:**

- **Remote Development Teams (5-15 people)**: Need better project coordination across time zones, struggle with task visibility and deadline management
- **Project Managers**: Want automated reporting and real-time team capacity insights
- **Individual Developers**: Need cleaner task organization integrated with their existing tools

**Your Users:**

- **[User Type 1]**: [Their context and problems]
- **[User Type 2]**: [Their context and problems]
- **[User Type 3]**: [Their context and problems]

## Technical Stack

Below are modern, production-ready defaults. Change any that don't fit your needs, or leave blank if unsure.

### Application Framework

**Default:** Next.js 15+ (full-stack React framework)
**Your Choice:** [Leave blank to use default, or specify alternative]

### Database System

**Default:** PostgreSQL 17+ with Prisma ORM
**Your Choice:** [Leave blank to use default, or specify alternative]

### JavaScript Framework

**Default:** React 18+ with TypeScript
**Your Choice:** [Leave blank to use default, or specify alternative]

### CSS Framework

**Default:** Tailwind CSS 4.0+
**Your Choice:** [Leave blank to use default, or specify alternative]

### UI Component Library

**Default:** shadcn/ui (copy-paste components)
**Your Choice:** [Leave blank to use default, or specify alternative]

### Icon System

**Default:** Lucide React
**Your Choice:** [Leave blank to use default, or specify alternative]

### Font Provider

**Default:** Google Fonts (self-hosted)
**Your Choice:** [Leave blank to use default, or specify alternative]

### Application Hosting

**Default:** Vercel (for Next.js) or Digital Ocean App Platform
**Your Choice:** [Leave blank to use default, or specify alternative]

### Database Hosting

**Default:** Digital Ocean Managed PostgreSQL or Supabase
**Your Choice:** [Leave blank to use default, or specify alternative]

### Asset Hosting

**Default:** Amazon S3 + CloudFront CDN
**Your Choice:** [Leave blank to use default, or specify alternative]

### Authentication

**Default:** NextAuth.js with Google/GitHub OAuth
**Your Choice:** [Leave blank to use default, or specify alternative]

### Additional Services

List any other services you need (email, payments, analytics, etc.):

**Example:** Stripe for payments, SendGrid for emails, Google Analytics

**Your Services:** [List any additional services]

## Project Status

### Are you ready to start planning?

- [ ] Yes, I'm in my project folder and ready to create documentation
- [ ] No, I need to set up my project folder first
- [ ] I want to review the plan first

### Project Folder Location

Where is your project located? (Leave blank if not ready)

**Your Project Path:** [/path/to/your/project or leave blank]

## Sample Code (Optional)

If you have existing code examples, wireframes, or specific technical requirements, add them here:

### Example Components

```jsx
// Example: A simple task card component
const TaskCard = ({ task }) => (
  <div className="p-4 border rounded-lg">
    <h3>{task.title}</h3>
    <p>{task.description}</p>
    <span className="text-sm text-gray-500">{task.status}</span>
  </div>
);
```

**Your Components:** [Add any component examples or leave blank]

### Example API Endpoints

```javascript
// Example: Get user tasks
GET /api/users/:id/tasks
Response: { tasks: [{ id, title, status, assignee }] }

// Example: Create new task
POST /api/tasks
Body: { title, description, assigneeId, priority }
```

**Your API Ideas:** [Add any API endpoint ideas or leave blank]

### Example Database Schema

```sql
-- Example: Tasks table
CREATE TABLE tasks (
  id UUID PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  status VARCHAR(50) DEFAULT 'todo',
  assigned_to UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW()
);
```

**Your Database Ideas:** [Add any database schema ideas or leave blank]

### Code Snippets

Add any specific code examples, algorithms, or technical approaches:

**Your Code Examples:** [Add any code snippets or leave blank]

## Additional Context (Optional)

### Market Research

What similar products exist? How will yours be different?

**Your Research:** [Add market insights or leave blank]

### Business Model

How will you make money? (subscription, one-time, freemium, etc.)

**Your Model:** [Add business model or leave blank]

### Budget Considerations

Any budget constraints for hosting, services, or development?

**Your Budget:** [Add budget notes or leave blank]

### Timeline

When do you want to launch? Any important deadlines?

**Your Timeline:** [Add timeline or leave blank]

### Team Information

Who's working on this? What are their skills?

**Your Team:** [Add team info or leave blank]

---

## Instructions

1. **Fill out the sections** above with your specific product details
2. **Use the provided examples** as guides for formatting
3. **Keep the tech stack defaults** if you're unsure about technical choices
4. **Copy and paste any text** - no special formatting needed
5. **Leave sections empty** if you don't have the information
6. **Save this file** when you're done

The template includes sensible defaults for a modern web application. You can change any technical choices or leave them blank to use the defaults.

## Ready to Proceed?

Once you've filled out this template, let me know and I'll help you create your complete product documentation and development roadmap using specOS.
