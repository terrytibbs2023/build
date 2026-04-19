// History listener to handle phone hardware 'back' buttons
window.addEventListener('popstate', (event) => {
    // If on search/home view, refresh the page instead of exiting
    if (state.view === 'search') {
        // Push state back so browser stays on page
        history.pushState({ view: 'search' }, '');
        
        // Refresh the page - reloads data and resets state
        location.reload();
        
        return;
    }
    
    // Normal back behavior for other views
    state.view = (event.state && event.state.view) ? event.state.view : 'search';
    state.selectedCard = (event.state && event.state.card) ? event.state.card : null;
    render();
});