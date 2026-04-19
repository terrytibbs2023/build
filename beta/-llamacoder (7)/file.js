async function initApp() {
    try {
        const [setsRes, raritiesRes, rateRes] = await Promise.all([
            fetch(`${API_BASE}/sets?orderBy=-releaseDate`),
            fetch(`${API_BASE}/rarities`),
            fetch('https://open.er-api.com/v6/latest/USD')
        ]);
        const setsData = await setsRes.json();
        const raritiesData = await raritiesRes.json();
        const rateData = await rateRes.json();
        state.sets = setsData.data || [];
        state.rarities = raritiesData.data || [];
        APP_CONFIG.pricing.gbpRate = rateData.rates?.GBP || 0.78;
        
        // Add initial history state
        history.pushState({ view: 'search' }, '');
        
        render();
        startBannerSlideshow();
    } catch (error) {
        console.error('Failed to initialize:', error);
    }
}