# Performance Standards

## Context

Global performance guidelines for specOS projects, ensuring fast, scalable, and efficient applications.

## Core Performance Principles

### Performance Budgets

- **First Contentful Paint (FCP)**: < 1.5 seconds
- **Largest Contentful Paint (LCP)**: < 2.5 seconds
- **First Input Delay (FID)**: < 100 milliseconds
- **Cumulative Layout Shift (CLS)**: < 0.1
- **Time to Interactive (TTI)**: < 3.8 seconds

### Resource Optimization

- **JavaScript Bundle**: < 200KB (gzipped)
- **CSS Bundle**: < 50KB (gzipped)
- **Image Optimization**: WebP format with fallbacks
- **Font Loading**: Preload critical fonts, use font-display: swap

## Frontend Performance

### Code Splitting

```javascript
// Dynamic imports for route-based splitting
const HomePage = lazy(() => import("./pages/HomePage"));
const UserProfile = lazy(() => import("./pages/UserProfile"));

// Component-level splitting for heavy components
const HeavyChart = lazy(() => import("./components/HeavyChart"));

// Library splitting
const { Chart } = await import("chart.js");
```

### Bundle Optimization

```javascript
// webpack.config.js
module.exports = {
  optimization: {
    splitChunks: {
      chunks: "all",
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: "vendors",
          chunks: "all",
        },
        common: {
          name: "common",
          minChunks: 2,
          chunks: "all",
          enforce: true,
        },
      },
    },
  },
};
```

### Image Optimization

```javascript
// Next.js Image component usage
import Image from "next/image";

const OptimizedImage = ({ src, alt, width, height }) => (
  <Image
    src={src}
    alt={alt}
    width={width}
    height={height}
    placeholder="blur"
    blurDataURL="data:image/jpeg;base64,..."
    priority={true} // For above-the-fold images
  />
);

// Responsive images
const ResponsiveImage = ({ src, alt }) => (
  <picture>
    <source srcSet={`${src}.webp`} type="image/webp" />
    <source srcSet={`${src}.jpg`} type="image/jpeg" />
    <img src={`${src}.jpg`} alt={alt} loading="lazy" />
  </picture>
);
```

### Caching Strategies

```javascript
// Service Worker caching
const CACHE_NAME = "app-v1";
const urlsToCache = ["/", "/static/js/main.bundle.js", "/static/css/main.css"];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(urlsToCache))
  );
});

// Cache-first strategy for static assets
self.addEventListener("fetch", (event) => {
  if (event.request.url.includes("/static/")) {
    event.respondWith(
      caches
        .match(event.request)
        .then((response) => response || fetch(event.request))
    );
  }
});
```

## Backend Performance

### Database Optimization

```javascript
// Connection pooling
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  connectionLimit: 10,
  acquireTimeout: 60000,
  timeout: 60000,
  reconnect: true,
});

// Query optimization
const getUserWithPosts = async (userId) => {
  // Use JOIN instead of separate queries
  const query = `
    SELECT u.*, p.id as post_id, p.title, p.content
    FROM users u
    LEFT JOIN posts p ON u.id = p.user_id
    WHERE u.id = ?
  `;

  const [rows] = await pool.execute(query, [userId]);
  return rows;
};

// Index optimization
const createIndexes = async () => {
  await pool.execute(`
    CREATE INDEX idx_users_email ON users(email);
    CREATE INDEX idx_posts_user_id ON posts(user_id);
    CREATE INDEX idx_posts_created_at ON posts(created_at);
  `);
};
```

### Caching Strategies

```javascript
// Redis caching
const redis = require("redis");
const client = redis.createClient({
  host: process.env.REDIS_HOST,
  port: process.env.REDIS_PORT,
});

// Cache middleware
const cacheMiddleware = (duration = 300) => {
  return async (req, res, next) => {
    const key = `cache:${req.originalUrl}`;

    try {
      const cached = await client.get(key);
      if (cached) {
        return res.json(JSON.parse(cached));
      }

      // Store original send method
      const originalSend = res.json;

      // Override send method to cache response
      res.json = function (data) {
        client.setex(key, duration, JSON.stringify(data));
        return originalSend.call(this, data);
      };

      next();
    } catch (error) {
      next();
    }
  };
};

// Usage
app.get("/api/users/:id", cacheMiddleware(600), getUserById);
```

### API Response Optimization

```javascript
// Response compression
const compression = require("compression");
app.use(
  compression({
    filter: (req, res) => {
      if (req.headers["x-no-compression"]) {
        return false;
      }
      return compression.filter(req, res);
    },
    level: 6,
  })
);

// Response streaming for large datasets
const streamUsers = async (req, res) => {
  res.setHeader("Content-Type", "application/json");
  res.write("[");

  const stream = await User.find().cursor();
  let isFirst = true;

  stream.on("data", (user) => {
    if (!isFirst) res.write(",");
    res.write(JSON.stringify(user));
    isFirst = false;
  });

  stream.on("end", () => {
    res.write("]");
    res.end();
  });
};
```

## Monitoring and Metrics

### Performance Monitoring

```javascript
// Custom performance metrics
const performanceMetrics = {
  recordTiming: (name, duration) => {
    // Send to monitoring service
    analytics.timing(name, duration);
  },

  recordMemoryUsage: () => {
    const usage = process.memoryUsage();
    analytics.gauge("memory.heap.used", usage.heapUsed);
    analytics.gauge("memory.heap.total", usage.heapTotal);
    analytics.gauge("memory.rss", usage.rss);
  },

  recordDatabaseQuery: (query, duration) => {
    analytics.timing("db.query", duration);
    analytics.increment("db.queries");
  },
};

// Performance middleware
const performanceMiddleware = (req, res, next) => {
  const start = Date.now();

  res.on("finish", () => {
    const duration = Date.now() - start;
    performanceMetrics.recordTiming("http.request", duration);
    performanceMetrics.recordTiming(`http.${req.method}.${req.path}`, duration);
  });

  next();
};
```

### Load Testing

```javascript
// Artillery load testing configuration
// artillery.config.yml
config:
  target: 'https://api.example.com'
  phases:
    - duration: 60
      arrivalRate: 10
    - duration: 120
      arrivalRate: 50
    - duration: 60
      arrivalRate: 100
  defaults:
    headers:
      Authorization: 'Bearer {{ $randomString() }}'

scenarios:
  - name: "API Load Test"
    requests:
      - get:
          url: "/api/users"
      - post:
          url: "/api/users"
          json:
            name: "Test User"
            email: "test@example.com"
```

## Optimization Techniques

### Lazy Loading

```javascript
// Component lazy loading
const LazyComponent = lazy(() =>
  import("./HeavyComponent").then((module) => ({
    default: module.HeavyComponent,
  }))
);

// Data lazy loading
const useLazyData = (fetchFn, deps = []) => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    let mounted = true;

    const loadData = async () => {
      setLoading(true);
      try {
        const result = await fetchFn();
        if (mounted) {
          setData(result);
        }
      } catch (error) {
        console.error("Failed to load data:", error);
      } finally {
        if (mounted) {
          setLoading(false);
        }
      }
    };

    loadData();

    return () => {
      mounted = false;
    };
  }, deps);

  return { data, loading };
};
```

### Virtual Scrolling

```javascript
// Virtual scrolling for large lists
import { FixedSizeList as List } from "react-window";

const VirtualList = ({ items }) => {
  const Row = ({ index, style }) => (
    <div style={style}>
      <ListItem item={items[index]} />
    </div>
  );

  return (
    <List height={400} itemCount={items.length} itemSize={50} width="100%">
      {Row}
    </List>
  );
};
```

### Debouncing and Throttling

```javascript
// Debounce utility
const debounce = (func, wait) => {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
};

// Throttle utility
const throttle = (func, limit) => {
  let inThrottle;
  return function () {
    const args = arguments;
    const context = this;
    if (!inThrottle) {
      func.apply(context, args);
      inThrottle = true;
      setTimeout(() => (inThrottle = false), limit);
    }
  };
};

// Usage examples
const debouncedSearch = debounce((query) => {
  searchAPI(query);
}, 300);

const throttledScroll = throttle(() => {
  updateScrollPosition();
}, 100);
```

## Performance Testing

### Lighthouse CI

```yaml
# .lighthouserc.js
module.exports = {
  ci: {
    collect: {
      url: ['http://localhost:3000'],
      numberOfRuns: 3,
    },
    assert: {
      assertions: {
        'categories:performance': ['warn', { minScore: 0.9 }],
        'categories:accessibility': ['error', { minScore: 0.9 }],
        'first-contentful-paint': ['warn', { maxNumericValue: 1500 }],
        'largest-contentful-paint': ['warn', { maxNumericValue: 2500 }],
      },
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
```

### Bundle Analysis

```javascript
// webpack-bundle-analyzer
const BundleAnalyzerPlugin =
  require("webpack-bundle-analyzer").BundleAnalyzerPlugin;

module.exports = {
  plugins: [
    new BundleAnalyzerPlugin({
      analyzerMode: "static",
      openAnalyzer: false,
      reportFilename: "bundle-report.html",
    }),
  ],
};
```

## Best Practices Summary

1. **Measure first** - Use performance monitoring tools
2. **Optimize critical path** - Focus on above-the-fold content
3. **Implement caching** - Use appropriate caching strategies
4. **Minimize bundle size** - Code splitting and tree shaking
5. **Optimize images** - Use modern formats and lazy loading
6. **Database optimization** - Proper indexing and query optimization
7. **CDN usage** - Distribute static assets globally
8. **Compression** - Enable gzip/brotli compression
9. **HTTP/2** - Use multiplexing for concurrent requests
10. **Regular testing** - Continuous performance monitoring

Remember: Performance is a feature that affects user experience and should be prioritized from the start of development.
