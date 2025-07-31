<!-- Version: 1.0.1 - Add version numbers to all markdown files -->

# Testing Standards

## Context

Global testing guidelines for specOS projects, ensuring consistent quality and reliability across all codebases.

## Core Testing Principles

### Test-Driven Development (TDD)

- **Write tests first** before implementing features
- **Red-Green-Refactor** cycle: Write failing test ??Implement ??Refactor
- **Test behavior, not implementation** - focus on what the code does, not how
- **Keep tests simple** and focused on single responsibilities

### Test Coverage Requirements

- **Minimum 80% code coverage** for all new features
- **100% coverage** for critical business logic and security features
- **Integration tests** for all API endpoints and database operations
- **End-to-end tests** for complete user workflows

## Testing Pyramid

### Unit Tests (70% of tests)

- **Scope**: Individual functions, methods, and components
- **Speed**: Fast execution (< 100ms per test)
- **Isolation**: No external dependencies
- **Purpose**: Verify individual component behavior

### Integration Tests (20% of tests)

- **Scope**: Component interactions, API endpoints, database operations
- **Speed**: Medium execution (< 1s per test)
- **Dependencies**: Limited external dependencies (mocked where appropriate)
- **Purpose**: Verify component integration and data flow

### End-to-End Tests (10% of tests)

- **Scope**: Complete user workflows and critical paths
- **Speed**: Slow execution (< 30s per test)
- **Dependencies**: Full application stack
- **Purpose**: Verify complete user experience

## Test Structure and Organization

### File Naming Conventions

```
src/
?œâ??€ components/
??  ?œâ??€ UserCard.jsx
??  ?”â??€ UserCard.test.jsx
?œâ??€ services/
??  ?œâ??€ UserService.js
??  ?”â??€ UserService.test.js
?”â??€ utils/
    ?œâ??€ dateUtils.js
    ?”â??€ dateUtils.test.js
```

### Test File Structure

```javascript
describe("ComponentName", () => {
  // Setup and teardown
  beforeEach(() => {
    // Setup code
  });

  afterEach(() => {
    // Cleanup code
  });

  describe("methodName", () => {
    it("should do something when condition is met", () => {
      // Arrange
      const input = "test data";

      // Act
      const result = methodName(input);

      // Assert
      expect(result).toBe("expected output");
    });

    it("should handle error conditions", () => {
      // Arrange
      const invalidInput = null;

      // Act & Assert
      expect(() => methodName(invalidInput)).toThrow("Invalid input");
    });
  });
});
```

## Testing Frameworks and Tools

### Frontend Testing

#### Jest + React Testing Library

```javascript
import { render, screen, fireEvent } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import UserCard from "./UserCard";

describe("UserCard", () => {
  it("should display user information", () => {
    // Arrange
    const user = { name: "John Doe", email: "john@example.com" };

    // Act
    render(<UserCard user={user} />);

    // Assert
    expect(screen.getByText("John Doe")).toBeInTheDocument();
    expect(screen.getByText("john@example.com")).toBeInTheDocument();
  });

  it("should call onEdit when edit button is clicked", async () => {
    // Arrange
    const user = { id: "1", name: "John Doe" };
    const onEdit = jest.fn();
    const userEventInstance = userEvent.setup();

    render(<UserCard user={user} onEdit={onEdit} />);

    // Act
    await userEventInstance.click(
      screen.getByRole("button", { name: /edit/i })
    );

    // Assert
    expect(onEdit).toHaveBeenCalledWith("1");
  });
});
```

#### Component Testing Best Practices

- **Test user interactions**, not implementation details
- **Use semantic queries** (getByRole, getByLabelText) over getByTestId
- **Test accessibility** with screen readers and keyboard navigation
- **Mock external dependencies** (APIs, services, etc.)

### Backend Testing

#### API Testing

```javascript
describe("User API", () => {
  describe("GET /api/users/:id", () => {
    it("should return user data for valid ID", async () => {
      // Arrange
      const userId = "123";
      const expectedUser = { id: userId, name: "John Doe" };

      // Act
      const response = await request(app)
        .get(`/api/users/${userId}`)
        .expect(200);

      // Assert
      expect(response.body).toEqual(expectedUser);
    });

    it("should return 404 for invalid user ID", async () => {
      // Arrange
      const invalidId = "999";

      // Act & Assert
      await request(app).get(`/api/users/${invalidId}`).expect(404);
    });
  });
});
```

#### Database Testing

```javascript
describe("UserService", () => {
  beforeEach(async () => {
    // Setup test database
    await setupTestDatabase();
  });

  afterEach(async () => {
    // Cleanup test database
    await cleanupTestDatabase();
  });

  it("should create user successfully", async () => {
    // Arrange
    const userData = { name: "John Doe", email: "john@example.com" };

    // Act
    const user = await UserService.createUser(userData);

    // Assert
    expect(user.id).toBeDefined();
    expect(user.name).toBe(userData.name);
    expect(user.email).toBe(userData.email);
  });
});
```

## Mocking and Stubbing

### API Mocking

```javascript
// Mock external API calls
jest.mock("../services/api", () => ({
  fetchUser: jest.fn(),
}));

describe("UserComponent", () => {
  it("should display user data from API", async () => {
    // Arrange
    const mockUser = { id: "1", name: "John Doe" };
    api.fetchUser.mockResolvedValue(mockUser);

    // Act
    render(<UserComponent userId="1" />);

    // Assert
    await waitFor(() => {
      expect(screen.getByText("John Doe")).toBeInTheDocument();
    });
  });
});
```

### Database Mocking

```javascript
// Mock database operations
jest.mock("../models/User", () => ({
  findById: jest.fn(),
  create: jest.fn(),
}));

describe("UserService", () => {
  it("should return user by ID", async () => {
    // Arrange
    const mockUser = { id: "1", name: "John Doe" };
    User.findById.mockResolvedValue(mockUser);

    // Act
    const result = await UserService.getUserById("1");

    // Assert
    expect(result).toEqual(mockUser);
    expect(User.findById).toHaveBeenCalledWith("1");
  });
});
```

## Test Data Management

### Test Data Factories

```javascript
// factories/userFactory.js
export const createUser = (overrides = {}) => ({
  id: "1",
  name: "John Doe",
  email: "john@example.com",
  createdAt: new Date(),
  ...overrides,
});

export const createUserList = (count = 3) =>
  Array.from({ length: count }, (_, i) =>
    createUser({ id: String(i + 1), name: `User ${i + 1}` })
  );
```

### Test Database Setup

```javascript
// test/setup/database.js
export const setupTestDatabase = async () => {
  // Create test database connection
  // Run migrations
  // Seed with test data
};

export const cleanupTestDatabase = async () => {
  // Clean up test data
  // Close database connection
};
```

## Performance Testing

### Load Testing

```javascript
// Load test critical endpoints
describe("API Performance", () => {
  it("should handle concurrent requests", async () => {
    const concurrentRequests = 100;
    const promises = Array.from({ length: concurrentRequests }, () =>
      request(app).get("/api/users")
    );

    const startTime = Date.now();
    const responses = await Promise.all(promises);
    const endTime = Date.now();

    expect(endTime - startTime).toBeLessThan(5000); // 5 seconds
    responses.forEach((response) => {
      expect(response.status).toBe(200);
    });
  });
});
```

### Memory Testing

```javascript
// Test for memory leaks
describe("Memory Usage", () => {
  it("should not leak memory during operations", () => {
    const initialMemory = process.memoryUsage().heapUsed;

    // Perform operations that might cause memory leaks
    for (let i = 0; i < 1000; i++) {
      // Simulate operations
    }

    const finalMemory = process.memoryUsage().heapUsed;
    const memoryIncrease = finalMemory - initialMemory;

    expect(memoryIncrease).toBeLessThan(10 * 1024 * 1024); // 10MB
  });
});
```

## Continuous Integration

### Test Execution

```yaml
# .github/workflows/test.yml
name: Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: "18"

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Generate coverage report
        run: npm run test:coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v3
```

### Coverage Reporting

```json
// jest.config.js
module.exports = {
  collectCoverageFrom: [
    'src/**/*.{js,jsx,ts,tsx}',
    '!src/**/*.d.ts',
    '!src/index.js',
    '!src/test/**/*'
  ],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  }
};
```

## Accessibility Testing

### Screen Reader Testing

```javascript
import { axe, toHaveNoViolations } from "jest-axe";

expect.extend(toHaveNoViolations);

describe("Accessibility", () => {
  it("should not have accessibility violations", async () => {
    const { container } = render(<UserCard user={mockUser} />);
    const results = await axe(container);
    expect(results).toHaveNoViolations();
  });
});
```

### Keyboard Navigation Testing

```javascript
it("should be navigable with keyboard", async () => {
  render(<UserCard user={mockUser} onEdit={jest.fn()} />);

  // Tab to focusable elements
  await userEvent.tab();
  expect(screen.getByRole("button", { name: /edit/i })).toHaveFocus();

  // Test Enter key activation
  await userEvent.keyboard("{Enter}");
  expect(onEdit).toHaveBeenCalled();
});
```

## Security Testing

### Input Validation Testing

```javascript
describe("Security", () => {
  it("should prevent SQL injection", async () => {
    const maliciousInput = "'; DROP TABLE users; --";

    await expect(UserService.searchUsers(maliciousInput)).rejects.toThrow(
      "Invalid input"
    );
  });

  it("should prevent XSS attacks", () => {
    const maliciousScript = '<script>alert("xss")</script>';
    const user = createUser({ name: maliciousScript });

    render(<UserCard user={user} />);

    expect(screen.getByText(maliciousScript)).toBeInTheDocument();
    expect(screen.queryByText("<script>")).not.toBeInTheDocument();
  });
});
```

## Best Practices Summary

1. **Write tests first** (TDD approach)
2. **Test behavior, not implementation**
3. **Keep tests simple and focused**
4. **Use descriptive test names**
5. **Mock external dependencies**
6. **Maintain high test coverage**
7. **Test error conditions and edge cases**
8. **Use test data factories**
9. **Run tests in CI/CD pipeline**
10. **Regularly review and refactor tests**

Remember: Good tests are a form of documentation and help prevent regressions while enabling confident refactoring.
