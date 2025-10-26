# Frontend API Integration Guide

## Overview
This guide provides comprehensive instructions for frontend developers to integrate with the Guitar API, including accessing documentation, generating TypeScript types, and implementing API calls.

## API Documentation Access

### Interactive Swagger UI
- **URL**: `http://localhost:8080/swagger-ui/`
- **Description**: Interactive API documentation with live testing capabilities
- **Features**:
  - Test endpoints directly from the browser
  - View request/response schemas
  - See example data for all models

### Programmatic Access
- **OpenAPI JSON**: `http://localhost:8080/api-docs/openapi.json`
- **Schema JSON**: `http://localhost:8080/api-docs/schema.json`
- **Static Documentation**: `docs/api-documentation.json`

## TypeScript Type Generation

### Generate Types from Live API
```bash
# Install openapi-typescript globally
npm install -g openapi-typescript

# Generate types from running server
npx openapi-typescript http://localhost:8080/api-docs/openapi.json -o types/api.ts
```

### Generate Types from Static File
```bash
# Generate types from static documentation
npx openapi-typescript docs/api-documentation.json -o types/api.ts
```

## API Endpoints

### 1. Health Check
```typescript
GET /health
Response: { "ok": boolean }
```

### 2. List All Guitars
```typescript
GET /api/guitars
Response: Array<GuitarWithEnhancedData>
```

**Enhanced Data Fields** (automatically added by backend):
- `slug`: URL-friendly identifier
- `display_title`: Formatted title (e.g., "Banker 58' Spec V")
- `formatted_price`: Human-readable price (e.g., "$4,699.00")
- `main_image`: Primary image URL with fallback strategy
- `has_images`: Boolean indicating if guitar has any images
- `image_count`: Number of images in gallery
- `condition_color`: CSS color class for condition styling
- `status_color`: CSS color class for status styling

### 3. Get Guitar by ID
```typescript
GET /api/guitars/{id}
Parameters:
  - id: string (e.g., "guitars:123" or "123")
Response: GuitarWithEnhancedData
```

### 4. Get Guitar by Slug
```typescript
GET /api/guitars/slug/{slug}
Parameters:
  - slug: string (e.g., "banker-58-spec-v")
Response: GuitarWithEnhancedData
```

### 5. Update Guitar Images
```typescript
PUT /api/guitars/{id}/images
Parameters:
  - id: string (e.g., "guitars:123" or "123")
Body: ImageUpdateRequest
Response: GuitarWithEnhancedData
```

## Data Models

### Guitar Model
```typescript
interface Guitar {
  id?: string;                    // SurrealDB record ID
  brand: string;                  // Guitar brand
  model: string;                  // Guitar model
  slug?: string;                  // URL-friendly identifier
  body_style: string;             // Body style (e.g., "V", "Les Paul")
  line: string;                   // Product line
  variant: string;                // Model variant
  year_reference: string;         // Year reference
  weight: string;                 // Weight description
  price_cents: number;            // Price in cents
  price_currency: string;         // Currency code (e.g., "USD")
  serial_number: string;          // Serial number

  // Image fields
  hero_image_url?: string;        // Primary image URL
  image_gallery?: string[];       // Array of image URLs
  image_source?: string;          // Source of images (e.g., "scraped")
  hero_url?: string;              // Legacy image field

  // Condition and status
  condition?: string;             // Condition (e.g., "Excellent +")
  status?: string;                // Status (e.g., "Available")

  // Year tracking
  production_year?: number;       // Actual build year
  spec_version_year?: number;     // Catalog/spec year

  // External source
  external_source?: string;       // External source name
  external_id?: string;           // External source ID
  listing_url?: string;           // Original listing URL
  shop_name?: string;             // Shop name
  shop_slug?: string;             // Shop slug
}
```

### ImageUpdateRequest Model
```typescript
interface ImageUpdateRequest {
  hero_image_url?: string;        // Primary image URL
  image_gallery?: string[];       // Array of image URLs
  image_source?: string;          // Source of images
  condition?: string;             // Condition
  status?: string;                // Status
}
```

### ErrorResponse Model
```typescript
interface ErrorResponse {
  error: string;                  // Error message
  status: string;                 // Error status
}
```

## Frontend Implementation Examples

### React/AstroJS API Client
```typescript
// api/guitarApi.ts
const API_BASE = 'http://localhost:8080';

export class GuitarApi {
  static async getGuitars(): Promise<GuitarWithEnhancedData[]> {
    const response = await fetch(`${API_BASE}/api/guitars`);
    if (!response.ok) throw new Error('Failed to fetch guitars');
    return response.json();
  }

  static async getGuitarById(id: string): Promise<GuitarWithEnhancedData> {
    const response = await fetch(`${API_BASE}/api/guitars/${id}`);
    if (!response.ok) throw new Error('Failed to fetch guitar');
    return response.json();
  }

  static async getGuitarBySlug(slug: string): Promise<GuitarWithEnhancedData> {
    const response = await fetch(`${API_BASE}/api/guitars/slug/${slug}`);
    if (!response.ok) throw new Error('Failed to fetch guitar');
    return response.json();
  }

  static async updateGuitarImages(
    id: string,
    data: ImageUpdateRequest
  ): Promise<GuitarWithEnhancedData> {
    const response = await fetch(`${API_BASE}/api/guitars/${id}/images`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    });
    if (!response.ok) throw new Error('Failed to update guitar images');
    return response.json();
  }
}
```

### Image Display Component
```typescript
// components/GuitarImage.tsx
interface GuitarImageProps {
  guitar: GuitarWithEnhancedData;
  className?: string;
}

export function GuitarImage({ guitar, className }: GuitarImageProps) {
  const mainImage = guitar.main_image || '/images/placeholder-guitar.jpg';
  const hasImages = guitar.has_images;
  const imageCount = guitar.image_count;

  return (
    <div className={`guitar-image ${className}`}>
      <img
        src={mainImage}
        alt={guitar.display_title}
        className={`guitar-hero-image ${!hasImages ? 'placeholder' : ''}`}
      />
      {hasImages && imageCount > 1 && (
        <div className="image-count-badge">
          +{imageCount - 1} more
        </div>
      )}
    </div>
  );
}
```

### Condition and Status Styling
```css
/* CSS for condition colors */
.condition-excellent { color: #22c55e; } /* green */
.condition-good { color: #eab308; }      /* yellow */
.condition-fair { color: #ef4444; }      /* red */
.condition-poor { color: #ef4444; }      /* red */
.condition-default { color: #6b7280; }   /* gray */

/* CSS for status colors */
.status-available { color: #22c55e; }    /* success */
.status-sold { color: #ef4444; }         /* danger */
.status-on-hold { color: #f59e0b; }      /* warning */
.status-pending { color: #3b82f6; }      /* info */
.status-default { color: #6b7280; }      /* secondary */
```

## Error Handling

### Standard Error Responses
All endpoints return consistent error responses:

```typescript
// 400 Bad Request
{
  "error": "No valid image fields provided",
  "status": "error"
}

// 404 Not Found
{
  "error": "Guitar not found",
  "status": "error"
}

// 500 Internal Server Error
{
  "error": "Database connection failed",
  "status": "error"
}
```

### Error Handling Example
```typescript
async function fetchGuitar(id: string) {
  try {
    const guitar = await GuitarApi.getGuitarById(id);
    return guitar;
  } catch (error) {
    if (error.message.includes('404')) {
      // Handle not found
      console.error('Guitar not found:', id);
    } else if (error.message.includes('500')) {
      // Handle server error
      console.error('Server error:', error.message);
    } else {
      // Handle other errors
      console.error('Unexpected error:', error.message);
    }
    throw error;
  }
}
```

## Development Workflow

### 1. Backend Changes
When the backend developer adds new fields:
1. New fields are automatically added to the OpenAPI schema
2. Documentation updates on server restart
3. Frontend developers can see changes in Swagger UI

### 2. Frontend Updates
When new fields are added:
1. Regenerate TypeScript types: `npx openapi-typescript http://localhost:8080/api-docs/openapi.json -o types/api.ts`
2. Update components to use new fields
3. Test with Swagger UI to verify behavior

### 3. Testing
- Use Swagger UI to test endpoints manually
- Verify TypeScript types match API responses
- Test error scenarios (404, 500, etc.)

## Best Practices

### 1. Type Safety
- Always use generated TypeScript types
- Validate API responses at runtime if needed
- Use proper error handling

### 2. Performance
- Cache API responses when appropriate
- Use pagination for large datasets (when implemented)
- Optimize image loading with lazy loading

### 3. User Experience
- Show loading states during API calls
- Display meaningful error messages
- Provide fallback images for guitars without photos

### 4. SEO and Accessibility
- Use proper alt text for images
- Implement proper meta tags for guitar pages
- Ensure keyboard navigation works

## Troubleshooting

### Common Issues

1. **CORS Errors**: Ensure the backend is running and CORS is configured
2. **Type Mismatches**: Regenerate types after backend changes
3. **Image Loading**: Check image URLs and implement fallbacks
4. **Slug Mismatches**: Verify slugs match between frontend routes and API

### Debug Tools
- Browser DevTools Network tab
- Swagger UI for endpoint testing
- TypeScript compiler for type checking

## Support

For questions or issues:
1. Check the Swagger UI documentation
2. Review this guide
3. Contact the backend development team
4. Check the project's issue tracker
