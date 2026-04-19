import { useState, useCallback } from "react";
import { SearchHeader } from "./components/SearchHeader";
import { CardGrid } from "./components/CardGrid";
import { CardDetails } from "./components/CardDetails";
import { InquiryList } from "./components/InquiryList";
import { CartBar } from "./components/CartBar";
import { SocialStories } from "./components/SocialStories";
import { SponsorCard } from "./components/SponsorCard";
import { LoadingSpinner } from "./components/LoadingSpinner";
import { useAppState } from "./hooks/useAppState";
import { useShoppingList } from "./hooks/useShoppingList";
import { useTheme } from "./hooks/useTheme";

export type View = "search" | "details" | "list";

export default function App() {
  const { theme, cycleTheme } = useTheme();
  const {
    state,
    updateState,
    sets,
    rarities,
    gbpRate,
    isLoading,
    hasSearched,
    executeSearch,
    resetHome,
  } = useAppState();

  const {
    shoppingList,
    addToList,
    removeFromList,
    sendWhatsApp,
    getListCount,
  } = useShoppingList();

  const [view, setView] = useState<View>("search");
  const [selectedCard, setSelectedCard] = useState<any>(null);
  const [showAd, setShowAd] = useState(true);

  const handleCardClick = useCallback((card: any) => {
    setSelectedCard(card);
    setView("details");
    window.scrollTo(0, 0);
  }, []);

  const handleBack = useCallback(() => {
    if (view === "details") {
      setView("search");
      setSelectedCard(null);
    } else if (view === "list") {
      setView("search");
    } else {
      resetHome();
      setShowAd(true);
    }
  }, [view, resetHome]);

  const handleSearch = useCallback(() => {
    setShowAd(false);
    executeSearch();
  }, [executeSearch]);

  const handleAddToList = useCallback(
    (card: any, type: string, price: string) => {
      addToList(card, type, price, gbpRate);
    },
    [addToList, gbpRate]
  );

  const handleOpenList = useCallback(() => {
    setView("list");
    window.scrollTo(0, 0);
  }, []);

  return (
    <div className={`min-h-screen transition-colors duration-500 ${theme.bg}`}>
      {view === "search" && (
        <>
          <SearchHeader
            searchTerm={state.searchTerm}
            selectedSet={state.selectedSet}
            selectedRarity={state.selectedRarity}
            sets={sets}
            rarities={rarities}
            theme={theme}
            onSearchChange={(val) => updateState("searchTerm", val)}
            onSetChange={(val) => {
              updateState("selectedSet", val);
              handleSearch();
            }}
            onRarityChange={(val) => {
              updateState("selectedRarity", val);
              handleSearch();
            }}
            onSearch={handleSearch}
            onReset={resetHome}
            onCycleTheme={cycleTheme}
          />
          {showAd && (
            <>
              <SocialStories theme={theme} />
              <SponsorCard theme={theme} />
            </>
          )}
          {isLoading ? (
            <LoadingSpinner theme={theme} />
          ) : (
            <CardGrid
              cards={state.cards}
              hasSearched={hasSearched}
              onCardClick={handleCardClick}
              theme={theme}
            />
          )}
          <CartBar count={getListCount()} onClick={handleOpenList} theme={theme} />
        </>
      )}

      {view === "details" && selectedCard && (
        <CardDetails
          card={selectedCard}
          gbpRate={gbpRate}
          shoppingList={shoppingList}
          theme={theme}
          onBack={handleBack}
          onAddToList={handleAddToList}
        />
      )}

      {view === "list" && (
        <InquiryList
          items={shoppingList}
          theme={theme}
          onBack={handleBack}
          onRemove={removeFromList}
          onSendWhatsApp={sendWhatsApp}
          onCardClick={handleCardClick}
        />
      )}
    </div>
  );
}