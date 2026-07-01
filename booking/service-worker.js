// A simple version identifier to force cache updates if needed
const CACHE_NAME = 'essex-repair-v1';

// 1. Install event: Cache essential assets if you want offline support
self.addEventListener('install', (event) => {
    self.skipWaiting(); // Force the new service worker to take control immediately
});

// 2. Activate event: Clean up old caches
self.addEventListener('activate', (event) => {
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cache) => {
                    if (cache !== CACHE_NAME) {
                        return caches.delete(cache);
                    }
                })
            );
        })
    );
});

// 3. Fetch event: The "Check for updates on boot" logic
self.addEventListener('fetch', (event) => {
    // If the request is for the main page, try the network first
    if (event.request.mode === 'navigate') {
        event.respondWith(
            fetch(event.request)
                .then((response) => {
                    // Cache the fresh version
                    const copy = response.clone();
                    caches.open(CACHE_NAME).then((cache) => {
                        cache.put(event.request, copy);
                    });
                    return response;
                })
                .catch(() => {
                    // If network fails (offline), return cached version
                    return caches.match(event.request);
                })
        );
        return;
    }

    // For everything else (CSS, JS, Images), just pass through
    event.respondWith(
        caches.match(event.request).then((response) => {
            return response || fetch(event.request);
        })
    );
});
