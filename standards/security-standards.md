# Security Standards

## Context

Global security guidelines for specOS projects, ensuring consistent security practices across all codebases and protecting against common vulnerabilities.

## Core Security Principles

### Defense in Depth

- **Multiple layers** of security controls
- **Fail securely** - default to secure state
- **Principle of least privilege** - minimal access required
- **Security by design** - built-in from the start

### Zero Trust Architecture

- **Never trust, always verify** - authenticate and authorize every request
- **Assume breach** - design for compromise scenarios
- **Micro-segmentation** - isolate systems and data
- **Continuous monitoring** - real-time threat detection

## Authentication & Authorization

### Password Security

```javascript
// Password requirements
const PASSWORD_REQUIREMENTS = {
  minLength: 12,
  requireUppercase: true,
  requireLowercase: true,
  requireNumbers: true,
  requireSpecialChars: true,
  preventCommonPasswords: true,
  preventUserInfo: true, // username, email, etc.
};

// Password validation
const validatePassword = (password, userInfo) => {
  if (password.length < PASSWORD_REQUIREMENTS.minLength) {
    throw new Error("Password must be at least 12 characters");
  }

  if (!/[A-Z]/.test(password)) {
    throw new Error("Password must contain uppercase letter");
  }

  // Check against user info
  const userInfoLower = Object.values(userInfo).join("").toLowerCase();
  if (password.toLowerCase().includes(userInfoLower)) {
    throw new Error("Password cannot contain personal information");
  }
};
```

### Multi-Factor Authentication (MFA)

```javascript
// MFA implementation
const enableMFA = async (userId) => {
  // Generate secret for TOTP
  const secret = generateTOTPSecret();

  // Store encrypted secret
  await storeEncryptedSecret(userId, secret);

  // Generate QR code for authenticator app
  const qrCode = generateQRCode(secret, userId);

  return { secret, qrCode };
};

const verifyMFA = async (userId, token) => {
  const secret = await getEncryptedSecret(userId);
  return verifyTOTPToken(secret, token);
};
```

### Session Management

```javascript
// Secure session configuration
const sessionConfig = {
  secret: process.env.SESSION_SECRET,
  name: "sessionId", // Don't use default 'connect.sid'
  cookie: {
    httpOnly: true,
    secure: process.env.NODE_ENV === "production",
    sameSite: "strict",
    maxAge: 15 * 60 * 1000, // 15 minutes
  },
  resave: false,
  saveUninitialized: false,
  store: new RedisStore({ client: redisClient }),
};
```

## Input Validation & Sanitization

### SQL Injection Prevention

```javascript
// Use parameterized queries
const getUserById = async (userId) => {
  // ✅ Secure - parameterized query
  const query = "SELECT * FROM users WHERE id = ?";
  const [rows] = await db.execute(query, [userId]);
  return rows[0];

  // ❌ Vulnerable - string concatenation
  // const query = `SELECT * FROM users WHERE id = ${userId}`;
};

// Input validation
const validateUserId = (userId) => {
  if (!userId || typeof userId !== "string") {
    throw new Error("Invalid user ID");
  }

  // UUID validation
  const uuidRegex =
    /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
  if (!uuidRegex.test(userId)) {
    throw new Error("Invalid user ID format");
  }

  return userId;
};
```

### XSS Prevention

```javascript
// Content Security Policy
const cspConfig = {
  directives: {
    defaultSrc: ["'self'"],
    scriptSrc: ["'self'", "'unsafe-inline'"],
    styleSrc: ["'self'", "'unsafe-inline'"],
    imgSrc: ["'self'", "data:", "https:"],
    connectSrc: ["'self'"],
    fontSrc: ["'self'"],
    objectSrc: ["'none'"],
    mediaSrc: ["'self'"],
    frameSrc: ["'none'"],
  },
};

// Output encoding
const escapeHtml = (text) => {
  const div = document.createElement("div");
  div.textContent = text;
  return div.innerHTML;
};

// React XSS prevention
const UserDisplay = ({ user }) => {
  // ✅ Secure - React automatically escapes
  return <div>{user.name}</div>;

  // ❌ Vulnerable - dangerouslySetInnerHTML
  // return <div dangerouslySetInnerHTML={{ __html: user.name }} />;
};
```

### CSRF Protection

```javascript
// CSRF token generation
const generateCSRFToken = (req, res, next) => {
  if (!req.session.csrfToken) {
    req.session.csrfToken = crypto.randomBytes(32).toString("hex");
  }
  res.locals.csrfToken = req.session.csrfToken;
  next();
};

// CSRF token validation
const validateCSRFToken = (req, res, next) => {
  const token = req.body._csrf || req.headers["x-csrf-token"];

  if (!token || token !== req.session.csrfToken) {
    return res.status(403).json({ error: "Invalid CSRF token" });
  }

  next();
};
```

## Data Protection

### Encryption at Rest

```javascript
// Database encryption
const encryptSensitiveData = (data) => {
  const algorithm = "aes-256-gcm";
  const key = Buffer.from(process.env.ENCRYPTION_KEY, "hex");
  const iv = crypto.randomBytes(16);

  const cipher = crypto.createCipher(algorithm, key);
  cipher.setAAD(Buffer.from("additional-data"));

  let encrypted = cipher.update(data, "utf8", "hex");
  encrypted += cipher.final("hex");

  const authTag = cipher.getAuthTag();

  return {
    encrypted,
    iv: iv.toString("hex"),
    authTag: authTag.toString("hex"),
  };
};

const decryptSensitiveData = (encryptedData) => {
  const algorithm = "aes-256-gcm";
  const key = Buffer.from(process.env.ENCRYPTION_KEY, "hex");
  const iv = Buffer.from(encryptedData.iv, "hex");
  const authTag = Buffer.from(encryptedData.authTag, "hex");

  const decipher = crypto.createDecipher(algorithm, key);
  decipher.setAAD(Buffer.from("additional-data"));
  decipher.setAuthTag(authTag);

  let decrypted = decipher.update(encryptedData.encrypted, "hex", "utf8");
  decrypted += decipher.final("utf8");

  return decrypted;
};
```

### Encryption in Transit

```javascript
// HTTPS configuration
const httpsConfig = {
  key: fs.readFileSync("/path/to/private.key"),
  cert: fs.readFileSync("/path/to/certificate.crt"),
  ca: fs.readFileSync("/path/to/ca_bundle.crt"),
  secureOptions:
    crypto.constants.SSL_OP_NO_TLSv1 | crypto.constants.SSL_OP_NO_TLSv1_1,
  ciphers: "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256",
};

// API security headers
const securityHeaders = (req, res, next) => {
  res.setHeader(
    "Strict-Transport-Security",
    "max-age=31536000; includeSubDomains"
  );
  res.setHeader("X-Content-Type-Options", "nosniff");
  res.setHeader("X-Frame-Options", "DENY");
  res.setHeader("X-XSS-Protection", "1; mode=block");
  res.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");
  res.setHeader(
    "Permissions-Policy",
    "geolocation=(), microphone=(), camera=()"
  );
  next();
};
```

## API Security

### Rate Limiting

```javascript
// Rate limiting implementation
const rateLimit = require("express-rate-limit");

const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: "Too many requests from this IP",
  standardHeaders: true,
  legacyHeaders: false,
  handler: (req, res) => {
    res.status(429).json({
      error: "Rate limit exceeded",
      retryAfter: Math.ceil(req.rateLimit.resetTime / 1000),
    });
  },
});

// Apply to specific routes
app.use("/api/", apiLimiter);
```

### API Key Management

```javascript
// API key validation
const validateAPIKey = async (req, res, next) => {
  const apiKey = req.headers["x-api-key"];

  if (!apiKey) {
    return res.status(401).json({ error: "API key required" });
  }

  try {
    const keyData = await validateKey(apiKey);
    req.apiKey = keyData;
    next();
  } catch (error) {
    return res.status(401).json({ error: "Invalid API key" });
  }
};

// API key scopes
const checkScope = (requiredScope) => {
  return (req, res, next) => {
    if (!req.apiKey.scopes.includes(requiredScope)) {
      return res.status(403).json({ error: "Insufficient permissions" });
    }
    next();
  };
};
```

## Environment Security

### Environment Variables

```javascript
// Environment validation
const requiredEnvVars = [
  "NODE_ENV",
  "DATABASE_URL",
  "SESSION_SECRET",
  "ENCRYPTION_KEY",
  "JWT_SECRET",
];

const validateEnvironment = () => {
  const missing = requiredEnvVars.filter((varName) => !process.env[varName]);

  if (missing.length > 0) {
    throw new Error(
      `Missing required environment variables: ${missing.join(", ")}`
    );
  }

  // Validate encryption key length
  if (process.env.ENCRYPTION_KEY.length !== 64) {
    throw new Error("ENCRYPTION_KEY must be 32 bytes (64 hex characters)");
  }
};

// Load environment variables securely
require("dotenv").config({
  path: process.env.NODE_ENV === "production" ? ".env.production" : ".env",
});
```

### Secrets Management

```javascript
// AWS Secrets Manager integration
const AWS = require("aws-sdk");
const secretsManager = new AWS.SecretsManager();

const getSecret = async (secretName) => {
  try {
    const data = await secretsManager
      .getSecretValue({ SecretId: secretName })
      .promise();
    return JSON.parse(data.SecretString);
  } catch (error) {
    console.error("Error retrieving secret:", error);
    throw error;
  }
};

// Use secrets in application
const initializeSecrets = async () => {
  const dbSecrets = await getSecret("database-credentials");
  const apiSecrets = await getSecret("api-keys");

  process.env.DATABASE_PASSWORD = dbSecrets.password;
  process.env.API_KEY = apiSecrets.key;
};
```

## Logging & Monitoring

### Security Logging

```javascript
// Security event logging
const securityLogger = winston.createLogger({
  level: "info",
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: "security.log" }),
    new winston.transports.Console({
      format: winston.format.simple(),
    }),
  ],
});

const logSecurityEvent = (event, details) => {
  securityLogger.info({
    timestamp: new Date().toISOString(),
    event,
    details,
    ip: req.ip,
    userAgent: req.get("User-Agent"),
    userId: req.user?.id,
  });
};

// Log security events
logSecurityEvent("LOGIN_ATTEMPT", { success: true, userId: user.id });
logSecurityEvent("PERMISSION_DENIED", { resource: "/admin", userId: user.id });
logSecurityEvent("SUSPICIOUS_ACTIVITY", { pattern: "multiple_failed_logins" });
```

### Intrusion Detection

```javascript
// Simple intrusion detection
const intrusionDetection = {
  failedLogins: new Map(),
  suspiciousIPs: new Set(),

  recordFailedLogin: (ip, userId) => {
    const key = `${ip}:${userId}`;
    const count = this.failedLogins.get(key) || 0;
    this.failedLogins.set(key, count + 1);

    if (count + 1 >= 5) {
      this.suspiciousIPs.add(ip);
      logSecurityEvent("ACCOUNT_LOCKED", { ip, userId });
    }
  },

  isSuspicious: (ip) => {
    return this.suspiciousIPs.has(ip);
  },
};
```

## Dependency Security

### Vulnerability Scanning

```json
{
  "scripts": {
    "audit": "npm audit",
    "audit:fix": "npm audit fix",
    "security:check": "npm audit && snyk test",
    "security:monitor": "snyk monitor"
  },
  "devDependencies": {
    "snyk": "^1.1000.0"
  }
}
```

### Dependency Management

```javascript
// Package.json security configuration
{
  "overrides": {
    "vulnerable-package": "1.2.3"
  },
  "resolutions": {
    "vulnerable-package": "1.2.3"
  }
}
```

## Security Testing

### Automated Security Tests

```javascript
// Security test suite
describe("Security Tests", () => {
  it("should prevent SQL injection", async () => {
    const maliciousInput = "'; DROP TABLE users; --";

    await expect(UserService.searchUsers(maliciousInput)).rejects.toThrow(
      "Invalid input"
    );
  });

  it("should prevent XSS attacks", () => {
    const maliciousScript = '<script>alert("xss")</script>';
    const user = { name: maliciousScript };

    render(<UserCard user={user} />);

    expect(screen.getByText(maliciousScript)).toBeInTheDocument();
    expect(screen.queryByText("<script>")).not.toBeInTheDocument();
  });

  it("should validate CSRF tokens", async () => {
    const response = await request(app)
      .post("/api/users")
      .send({ name: "Test User" })
      .expect(403);

    expect(response.body.error).toBe("Invalid CSRF token");
  });
});
```

## Incident Response

### Security Incident Plan

```javascript
// Incident response procedures
const securityIncident = {
  severity: {
    LOW: "low",
    MEDIUM: "medium",
    HIGH: "high",
    CRITICAL: "critical",
  },

  response: {
    [this.severity.LOW]: [
      "Log incident",
      "Monitor for escalation",
      "Update documentation",
    ],
    [this.severity.MEDIUM]: [
      "Immediate notification to security team",
      "Begin investigation",
      "Implement temporary mitigations",
    ],
    [this.severity.HIGH]: [
      "Immediate notification to all stakeholders",
      "Activate incident response team",
      "Implement emergency mitigations",
      "Begin forensic analysis",
    ],
    [this.severity.CRITICAL]: [
      "Immediate system shutdown if necessary",
      "Notify law enforcement if required",
      "Activate disaster recovery plan",
      "Public disclosure if required",
    ],
  },
};
```

## Compliance & Auditing

### GDPR Compliance

```javascript
// Data subject rights
const dataSubjectRights = {
  rightToAccess: async (userId) => {
    const userData = await getUserData(userId);
    return {
      personalData: userData,
      processingPurposes: ["account_management", "service_provision"],
      retentionPeriod: "7 years",
      thirdPartySharing: [],
    };
  },

  rightToErasure: async (userId) => {
    await anonymizeUserData(userId);
    await logDataErasure(userId, "user_request");
  },

  rightToPortability: async (userId) => {
    const userData = await getUserData(userId);
    return JSON.stringify(userData, null, 2);
  },
};
```

### Audit Trail

```javascript
// Comprehensive audit logging
const auditLogger = {
  logAction: (action, userId, resource, details) => {
    const auditEntry = {
      timestamp: new Date().toISOString(),
      action,
      userId,
      resource,
      details,
      ip: req.ip,
      userAgent: req.get("User-Agent"),
      sessionId: req.sessionID,
    };

    // Store in audit database
    AuditLog.create(auditEntry);

    // Also log to security system
    logSecurityEvent("AUDIT_LOG", auditEntry);
  },
};

// Usage examples
auditLogger.logAction("USER_LOGIN", userId, "/auth/login", {
  method: "password",
});
auditLogger.logAction("DATA_ACCESS", userId, "/api/users/123", {
  fields: ["name", "email"],
});
auditLogger.logAction("DATA_MODIFICATION", userId, "/api/users/123", {
  changes: { name: "New Name" },
});
```

## Best Practices Summary

1. **Always validate and sanitize input**
2. **Use parameterized queries for database operations**
3. **Implement proper authentication and authorization**
4. **Encrypt sensitive data at rest and in transit**
5. **Use HTTPS everywhere**
6. **Implement rate limiting and API security**
7. **Keep dependencies updated and scan for vulnerabilities**
8. **Log security events and maintain audit trails**
9. **Follow principle of least privilege**
10. **Regular security testing and penetration testing**
11. **Have an incident response plan**
12. **Comply with relevant regulations (GDPR, SOC2, etc.)**

Remember: Security is not a one-time implementation but an ongoing process of monitoring, testing, and improvement.
