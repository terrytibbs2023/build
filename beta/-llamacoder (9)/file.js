// History listener to handle phone hardware 'back' buttons
window.addEventListener('popstate', (event) => {
    // If on search/home view, refresh the app instead of exiting
    if (state.view === 'search') {
        // Push state back so browser stays on page
        history.pushState({ view: 'search' }, '');
        
        // Reset state and re-initialize (simulates refresh)
        state.cards = [];
        state.searchTerm = '';
        state.selectedSet = '';
        state.selectedRarity = '';
        state.selectedCard = null;
        state.showAd = true;
        state.hasSearched = false;
        state.isLoading = false;
        
        // Re-fetch data from APIs
        initApp();
        
        return;
    }
    
    // Normal back behavior for other views
    state.view = (event.state && event.state.view) ? event.state.view : 'search';
    state.selectedCard = (event.state && event.state.card) ? event.state.card : null;
    render();
});