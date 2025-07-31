<!-- Version: 1.0.1 - Add version numbers to all markdown files -->

# JavaScript/TypeScript Style Guide

## General Principles

- Use **ES2022+** features when available
- Prefer **const** over let, avoid var
- Use **arrow functions** for callbacks and short functions
- Use **template literals** for string interpolation
- Use **destructuring** for object/array assignment

## Naming Conventions

### Variables and Functions

```javascript
// Use camelCase for variables and functions
const userName = "john";
const isAuthenticated = true;

function getUserData() {
  // function implementation
}

const handleSubmit = () => {
  // arrow function implementation
};
```

### Constants

```javascript
// Use UPPER_SNAKE_CASE for constants
const API_BASE_URL = "https://api.example.com";
const MAX_RETRY_ATTEMPTS = 3;
```

### Classes and Components

```javascript
// Use PascalCase for classes and React components
class UserService {
  constructor() {
    // constructor implementation
  }
}

const UserProfile = () => {
  // React component implementation
};
```

## Code Structure

### Imports

```javascript
// Group imports in this order:
// 1. External libraries
import React from "react";
import { useState, useEffect } from "react";

// 2. Internal modules
import { UserService } from "../services/UserService";

// 3. Relative imports
import "./UserProfile.css";
```

### Function Organization

```javascript
// Use this order within files:
// 1. Imports
// 2. Constants
// 3. Helper functions
// 4. Main component/class
// 5. Exports

const API_ENDPOINTS = {
  users: "/api/users",
  posts: "/api/posts",
};

const formatDate = (date) => {
  return new Date(date).toLocaleDateString();
};

const UserList = () => {
  // component implementation
};

export default UserList;
```

## React/Next.js Patterns

### Component Structure

```javascript
const UserCard = ({ user, onEdit, onDelete }) => {
  // 1. Hooks
  const [isLoading, setIsLoading] = useState(false);

  // 2. Event handlers
  const handleEdit = () => {
    onEdit(user.id);
  };

  // 3. Effects
  useEffect(() => {
    // effect implementation
  }, []);

  // 4. Render
  return <div className="user-card">{/* JSX content */}</div>;
};
```

### Hook Usage

```javascript
// Custom hooks should start with 'use'
const useUserData = (userId) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // fetch user data
  }, [userId]);

  return { user, loading };
};
```

## Error Handling

### Try-Catch Blocks

```javascript
const fetchUserData = async (userId) => {
  try {
    const response = await fetch(`/api/users/${userId}`);

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    return await response.json();
  } catch (error) {
    console.error("Failed to fetch user data:", error);
    throw error;
  }
};
```

### Promise Handling

```javascript
// Use async/await over .then() chains
const processData = async () => {
  try {
    const data = await fetchData();
    const processed = await processData(data);
    return processed;
  } catch (error) {
    handleError(error);
  }
};
```

## TypeScript Specific

### Type Definitions

```typescript
// Use interfaces for object shapes
interface User {
  id: string;
  name: string;
  email: string;
  createdAt: Date;
}

// Use type aliases for unions and complex types
type UserStatus = "active" | "inactive" | "pending";
type ApiResponse<T> = {
  data: T;
  status: number;
  message: string;
};
```

### Component Props

```typescript
interface UserCardProps {
  user: User;
  onEdit: (userId: string) => void;
  onDelete: (userId: string) => void;
  className?: string; // optional prop
}

const UserCard: React.FC<UserCardProps> = ({
  user,
  onEdit,
  onDelete,
  className = "",
}) => {
  // component implementation
};
```

## Testing Patterns

### Test Structure

```javascript
describe("UserService", () => {
  describe("fetchUser", () => {
    it("should fetch user data successfully", async () => {
      // Arrange
      const userId = "123";
      const mockUser = { id: userId, name: "John" };

      // Act
      const result = await UserService.fetchUser(userId);

      // Assert
      expect(result).toEqual(mockUser);
    });

    it("should throw error for invalid user ID", async () => {
      // Arrange
      const invalidId = "";

      // Act & Assert
      await expect(UserService.fetchUser(invalidId)).rejects.toThrow(
        "Invalid user ID"
      );
    });
  });
});
```

## Performance Considerations

### Memoization

```javascript
// Use React.memo for expensive components
const ExpensiveComponent = React.memo(({ data }) => {
  return <div>{/* expensive rendering */}</div>;
});

// Use useMemo for expensive calculations
const expensiveValue = useMemo(() => {
  return data.filter((item) => item.active).map((item) => item.value);
}, [data]);

// Use useCallback for stable function references
const handleClick = useCallback(() => {
  // click handler
}, [dependencies]);
```

### Bundle Optimization

```javascript
// Use dynamic imports for code splitting
const LazyComponent = lazy(() => import("./LazyComponent"));

// Use named exports for tree shaking
export const utilityFunction = () => {
  // implementation
};
```

## Code Comments

### Documentation Comments

```javascript
/**
 * Fetches user data from the API
 * @param {string} userId - The unique identifier of the user
 * @returns {Promise<User>} Promise that resolves to user data
 * @throws {Error} When user is not found or API fails
 */
const fetchUser = async (userId) => {
  // implementation
};
```

### Inline Comments

```javascript
// Only comment the "why", not the "what"
const processUserData = (users) => {
  // Filter out inactive users to improve performance
  const activeUsers = users.filter((user) => user.status === "active");

  // Transform data for the UI layer
  return activeUsers.map((user) => ({
    ...user,
    displayName: `${user.firstName} ${user.lastName}`,
  }));
};
```
