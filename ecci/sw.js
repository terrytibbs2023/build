const CACHE_NAME = 'ecc-cache-v3';
const urlsToCache = [
  './',
  './index.html',
  './manifest.json',
  './icon.jpeg'
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
