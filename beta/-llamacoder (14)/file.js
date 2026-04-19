function toggleTheme() {
    state.isDark = !state.isDark;
    localStorage.setItem('theme', state.isDark ? 'dark' : 'light');
    document.documentElement.classList.toggle('dark', state.isDark);
    
    const metaTheme = document.querySelector('meta[name="theme-color"]');
    if (metaTheme) {
        metaTheme.setAttribute('content', state.isDark ? '#0f172a' : '#f1f5f9');
    }
    render();
}