// Handles clicking a card to view details
function handleCardClick(card) {
    state.selectedCard = card;
    state.view = 'details';
    // Push state with 'fromSearch: true' to track we came from search results
    history.pushState({ view: 'details', card: card, fromSearch: true }, '');
    window.scrollTo(0, 0);
    render();
}

// History listener to handle phone hardware 'back' buttons
window.addEventListener('popstate', (event) => {
    const eventView = (event.state && event.state.view) ? event.state.view : 'search';
    const fromSearch = (event.state && event.state.fromSearch) ? event.state.fromSearch : false;
    
    // Going back from details
    if (eventView === 'details' && fromSearch) {
        // Return to search results (keep cards in state)
        state.view = 'search';
        state.selectedCard = null;
        state.showAd = false; // Keep showing results, not ads
        render();
        return;
    }
    
    // Going back from search results (or list view)
    if (state.view === 'search' && state.cards.length > 0) {
        // Reset to home page (clear search results)
        state.cards = [];
        state.searchTerm = '';
        state.selectedSet = '';
        state.selectedRarity = '';
        state.selectedCard = null;
        state.showAd = true;
        state.hasSearched = false;
        state.view = 'search';
        render();
        return;
    }
    
    // Default: normal back behavior
    state.view = eventView;
    state.selectedCard = (event.state && event.state.card) ? event.state.card : null;
    render();
});