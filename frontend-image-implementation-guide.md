# Frontend Image Implementation Guide

## 1. Utility Functions

```javascript
// Image helper functions
export const getMainImage = (guitar) => {
  // Priority: hero_image_url → hero_url → placeholder
  return guitar.hero_image_url ||
         guitar.hero_url ||
         '/images/guitar-placeholder.jpg';
};

export const getImageGallery = (guitar) => {
  const gallery = guitar.image_gallery || [];
  return {
    display: gallery.slice(0, 6),
    hasMore: gallery.length > 6,
    total: gallery.length
  };
};

export const getConditionColor = (condition) => {
  const colors = {
    'Excellent +': 'green',
    'Excellent': 'green',
    'Good': 'yellow',
    'Fair': 'red',
    'Poor': 'red'
  };
  return colors[condition] || 'gray';
};

export const getStatusColor = (status) => {
  const colors = {
    'Available': 'success',
    'Sold': 'danger',
    'On Hold': 'warning',
    'Pending': 'info'
  };
  return colors[status] || 'secondary';
};
```

## 2. React Components

### SafeImage Component
```jsx
import { useState } from 'react';

const SafeImage = ({ src, alt, fallback = '/images/guitar-placeholder.jpg', ...props }) => {
  const [imgSrc, setImgSrc] = useState(src);
  const [hasError, setHasError] = useState(false);

  const handleError = () => {
    if (!hasError) {
      setImgSrc(fallback);
      setHasError(true);
    }
  };

  return (
    <img
      src={imgSrc}
      alt={alt}
      onError={handleError}
      {...props}
    />
  );
};
```

### GuitarCard Component
```jsx
const GuitarCard = ({ guitar }) => {
  const mainImage = getMainImage(guitar);
  const gallery = getImageGallery(guitar);

  return (
    <div className="guitar-card">
      {/* Hero Image */}
      <div className="hero-image-container">
        <SafeImage
          src={mainImage}
          alt={`${guitar.brand} ${guitar.model}`}
          loading="lazy"
        />

        {/* Condition Badge */}
        {guitar.condition && (
          <span className={`condition-badge condition-${getConditionColor(guitar.condition)}`}>
            {guitar.condition}
          </span>
        )}

        {/* Status Badge */}
        {guitar.status && (
          <span className={`status-badge status-${getStatusColor(guitar.status)}`}>
            {guitar.status}
          </span>
        )}
      </div>

      {/* Image Gallery Preview */}
      {gallery.display.length > 0 && (
        <div className="gallery-preview">
          {gallery.display.slice(0, 3).map((image, index) => (
            <SafeImage
              key={index}
              src={image}
              alt={`${guitar.brand} ${guitar.model} - Image ${index + 1}`}
              className="gallery-thumbnail"
            />
          ))}
          {gallery.hasMore && (
            <div className="more-images">
              +{gallery.total - 3} more
            </div>
          )}
        </div>
      )}

      {/* Guitar Info */}
      <div className="guitar-info">
        <h3>{guitar.brand} {guitar.model}</h3>
        <p>{guitar.body_style} • {guitar.year_reference}</p>
        <p className="guitar-weight">{guitar.weight}</p>
      </div>
    </div>
  );
};
```

### Lazy Loading Hook
```jsx
import { useState, useEffect, useRef } from 'react';

export const useLazyImage = (src) => {
  const [isLoaded, setIsLoaded] = useState(false);
  const [isInView, setIsInView] = useState(false);
  const imgRef = useRef();

  useEffect(() => {
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setIsInView(true);
          observer.disconnect();
        }
      },
      { threshold: 0.1 }
    );

    if (imgRef.current) {
      observer.observe(imgRef.current);
    }

    return () => observer.disconnect();
  }, []);

  useEffect(() => {
    if (isInView && src) {
      const img = new Image();
      img.onload = () => setIsLoaded(true);
      img.src = src;
    }
  }, [isInView, src]);

  return { imgRef, isLoaded, isInView };
};
```

## 3. CSS Styles

```css
/* Guitar Card Styles */
.guitar-card {
  display: flex;
  flex-direction: column;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  overflow: hidden;
  transition: all 0.3s ease;
  background: white;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.guitar-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0,0,0,0.15);
}

/* Hero Image Container */
.hero-image-container {
  position: relative;
  width: 100%;
  height: 200px;
  overflow: hidden;
  border-radius: 8px;
}

.hero-image-container img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.hero-image-container:hover img {
  transform: scale(1.05);
}

/* Gallery Preview */
.gallery-preview {
  display: flex;
  gap: 4px;
  margin-top: 8px;
  height: 60px;
}

.gallery-thumbnail {
  width: 60px;
  height: 60px;
  object-fit: cover;
  border-radius: 4px;
  border: 1px solid #e0e0e0;
}

.more-images {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 60px;
  height: 60px;
  background: #f5f5f5;
  border: 1px solid #e0e0e0;
  border-radius: 4px;
  font-size: 0.8rem;
  color: #666;
}

/* Condition Badges */
.condition-badge {
  position: absolute;
  top: 8px;
  right: 8px;
  padding: 4px 8px;
  border-radius: 6px;
  font-size: 0.75rem;
  font-weight: 600;
  color: white;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.condition-green { background: #28a745; }
.condition-yellow { background: #ffc107; color: #212529; }
.condition-red { background: #dc3545; }
.condition-gray { background: #6c757d; }

/* Status Badges */
.status-badge {
  position: absolute;
  top: 8px;
  left: 8px;
  padding: 4px 8px;
  border-radius: 6px;
  font-size: 0.75rem;
  font-weight: 600;
  color: white;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.status-success { background: #28a745; }
.status-danger { background: #dc3545; }
.status-warning { background: #ffc107; color: #212529; }
.status-info { background: #17a2b8; }

/* Guitar Info */
.guitar-info {
  padding: 16px;
}

.guitar-info h3 {
  margin: 0 0 8px 0;
  font-size: 1.1rem;
  font-weight: 600;
  color: #333;
}

.guitar-info p {
  margin: 4px 0;
  color: #666;
  font-size: 0.9rem;
}

.guitar-weight {
  font-weight: 500;
  color: #888;
}

/* Grid Layout */
.guitars-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 24px;
  max-width: 1200px;
  margin: 0 auto;
}

@media (max-width: 768px) {
  .guitars-grid {
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 16px;
  }
}
```

## 4. AstroJS Component

```astro
---
// components/GuitarCard.astro
const { guitar } = Astro.props;

const getMainImage = (guitar) => {
  return guitar.hero_image_url || guitar.hero_url || '/images/guitar-placeholder.jpg';
};

const getConditionColor = (condition) => {
  const colors = {
    'Excellent +': 'green',
    'Excellent': 'green',
    'Good': 'yellow',
    'Fair': 'red'
  };
  return colors[condition] || 'gray';
};

const getStatusColor = (status) => {
  const colors = {
    'Available': 'success',
    'Sold': 'danger',
    'On Hold': 'warning',
    'Pending': 'info'
  };
  return colors[status] || 'secondary';
};
---

<div class="guitar-card">
  <div class="hero-image-container">
    <img
      src={getMainImage(guitar)}
      alt={`${guitar.brand} ${guitar.model}`}
      loading="lazy"
    />
    {guitar.condition && (
      <span class={`condition-badge condition-${getConditionColor(guitar.condition)}`}>
        {guitar.condition}
      </span>
    )}
    {guitar.status && (
      <span class={`status-badge status-${getStatusColor(guitar.status)}`}>
        {guitar.status}
      </span>
    )}
  </div>

  <div class="guitar-info">
    <h3>{guitar.brand} {guitar.model}</h3>
    <p>{guitar.body_style} • {guitar.year_reference}</p>
  </div>
</div>
```

## 5. API Integration

```javascript
// API call to fetch guitars with image fields
const fetchGuitars = async () => {
  try {
    const response = await fetch('/api/guitars');
    const data = await response.json();
    return data.guitars; // Should include hero_image_url, image_gallery, etc.
  } catch (error) {
    console.error('Error fetching guitars:', error);
    return [];
  }
};

// Expected API response structure
const expectedApiResponse = {
  "guitars": [
    {
      "id": "guitars:123",
      "brand": "Gibson",
      "model": "Flying V Custom 1958",
      "hero_image_url": "https://retrofret.com/images/guitar-hero.jpg",
      "image_gallery": [
        "https://retrofret.com/images/guitar-1.jpg",
        "https://retrofret.com/images/guitar-2.jpg"
      ],
      "image_source": "scraped",
      "condition": "Excellent +",
      "status": "Sold",
      "slug": "gibson-flying-v-custom-1958"
    }
  ]
};
```

## 6. Usage Examples

```javascript
// Example 1: Basic guitar card
<GuitarCard guitar={guitar} />

// Example 2: With lazy loading
const LazyGuitarCard = ({ guitar }) => {
  const { imgRef, isLoaded, isInView } = useLazyImage(guitar.hero_image_url);

  return (
    <div ref={imgRef} className="guitar-card">
      {isInView && isLoaded ? (
        <GuitarCard guitar={guitar} />
      ) : (
        <div className="loading-placeholder">Loading...</div>
      )}
    </div>
  );
};

// Example 3: Grid layout
const GuitarsList = ({ guitars }) => {
  return (
    <div className="guitars-grid">
      {guitars.map((guitar) => (
        <GuitarCard key={guitar.id} guitar={guitar} />
      ))}
    </div>
  );
};
```

## 7. Implementation Checklist

- [ ] Update API to return new image fields
- [ ] Create image helper functions
- [ ] Implement GuitarCard component
- [ ] Add CSS styling for cards and badges
- [ ] Implement error handling for images
- [ ] Add lazy loading for performance
- [ ] Test with different image sources
- [ ] Test fallback scenarios
- [ ] Optimize for mobile devices

## 8. Testing Scenarios

1. **Guitar with hero_image_url** - Should display scraped image
2. **Guitar with only hero_url** - Should fallback to legacy field
3. **Guitar with image_gallery** - Should show gallery preview
4. **Guitar with no images** - Should show placeholder
5. **Broken image URLs** - Should fallback gracefully
6. **Different conditions** - Should show appropriate badge colors
7. **Different statuses** - Should show appropriate status indicators
8. **Mobile devices** - Should display properly on small screens

## 9. Database Schema Fields

Your database now includes these image fields:
- `hero_image_url` - Primary image from scraped websites
- `image_gallery` - Array of additional images
- `image_source` - Where images came from (scraped, direct, proxy)
- `condition` - Guitar condition (Excellent +, Mint, Good)
- `status` - Listing status (Sold, Available, On Hold)
- `hero_url` - Legacy field (use as fallback)

## 10. Priority Order for Image Display

```javascript
// Image priority: hero_image_url → hero_url → placeholder
const getDisplayImage = (guitar) => {
  return guitar.hero_image_url ||
         guitar.hero_url ||
         '/images/guitar-placeholder.jpg';
};
```

This guide provides everything you need to implement the image usage features from your schema!
