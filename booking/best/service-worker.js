// 1. Listen for the Push Notification signal sent from the cloud
self.addEventListener('push', function(event) {
    let payload = {
        title: 'New Repair Job!',
        body: 'A new console booking has arrived.',
        icon: 'icon-192.png'
    };

    // If your backend sends custom text data, parse it here
    if (event.data) {
        try {
            payload = event.data.json();
        } catch (e) {
            payload.body = event.data.text();
        }
    }

    const options = {
        body: payload.body,
        icon: payload.icon || 'icon-192.png',
        badge: 'icon-192.png', // Small monochrome icon for the Android status bar
        vibrate: [200, 100, 200], // Haptic vibration pattern (buzz, pause, buzz)
        data: {
            url: self.location.origin // The URL to open when clicked
        },
        actions: [
            { action: 'open', title: 'Open Dashboard' }
        ]
    };

    // Keep the service worker alive until the notification is shown to the OS
    event.waitUntil(
        self.registration.showNotification(payload.title, options)
    );
});

// 2. Handle what happens when you TAP the notification banner
self.addEventListener('notificationclick', function(event) {
    event.notification.close(); // Dismiss the notification banner immediately

    // Open your admin dashboard automatically or focus it if it's already open
    event.waitUntil(
        clients.matchAll({ type: 'window', includeUncontrolled: true }).then(function(windowClients) {
            for (let client of windowClients) {
                if (client.url === event.notification.data.url && 'focus' in client) {
                    return client.focus();
                }
            }
            if (clients.openWindow) {
                return clients.openWindow(event.notification.data.url);
            }
        })
    );
});

// 3. Essential Fetch Listener for PWA Installation
// This empty listener satisfies the browser's requirement that a PWA must have 
// offline capabilities to trigger the native "Install App" prompt.
self.addEventListener('fetch', function(event) {
    // Currently acting as a pass-through. You can expand this later to cache files for true offline mode.
});
