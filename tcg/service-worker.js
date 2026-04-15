const CACHE_NAME = 'card-inquiry-cache-v1';
const urlsToCache = [
  '/',
  '/index.html',
  // add other static assets if necessary
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => cache.addAll(urlsToCache))
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request).then(response => response || fetch(event.request))
  );
});
