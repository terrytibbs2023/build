import { useState, useEffect } from 'react';
import { SearchHeader } from './components/SearchHeader';
import { CardGrid } from './components/CardGrid';
import { CardDetails } from './components/CardDetails';
import { InquiryList } from './components/InquiryList';
import { SponsorCard } from './components/SponsorCard';
import { CartBar } from './components/CartBar';
import { LoadingSpinner } from './components/LoadingSpinner';
import { useLocalStorage, useDebounce, useTheme } from './utils/hooks';
import { PokemonCard, ListItem } from './types';
import { APP_CONFIG, API_BASE } from './utils/constants';

type View = 'search' | 'details' | 'list';

export default function App() {
  const [view, setView] = useState<View>('search');
  const [cards, setCards] = useState<PokemonCard[]>([]);
  const [selectedCard, setSelectedCard] = useState<PokemonCard | null>(null);
  const [shoppingList, setShoppingList] = useLocalStorage<ListItem[]>('tcgInquiryList', []);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedSet, setSelectedSet] = useState('');
  const [selectedRarity, setSelectedRarity] = useState('');
  const [sets, setSets] = useState<{ id: string; name: string }[]>([]);
  const [rarities, setRarities] = useState<string[]>([]);
  const [gbpRate, setGbpRate] = useState(0.78);
  const [isLoading, setIsLoading] = useState(false);
  const [showAd, setShowAd] = useState(true);

  const { isDark, toggleTheme } = useTheme();
  const debouncedSearch = useDebounce(searchTerm, 500);

  // Fetch sets, rarities, and exchange rate on mount
  useEffect(() => {
    async function init() {
      try {
        const [setsRes, raritiesRes, rateRes] = await Promise.all([
          fetch(`${API_BASE}/sets?orderBy=-releaseDate`),
          fetch(`${API_BASE}/rarities`),
          fetch('https://open.er-api.com/v6/latest/USD')
        ]);
        const setsData = await setsRes.json();
        const raritiesData = await raritiesRes.json();
        const rateData = await rateRes.json();
        setSets(setsData.data || []);
        setRarities(raritiesData.data || []);
        setGbpRate(rateData.rates?.GBP || 0.78);
      } catch (error) {
        console.error('Failed to initialize:', error);
      }
    }
    init();
  }, []);

  // Search for cards
  useEffect(() => {
    async function searchCards() {
      if (!debouncedSearch && !selectedSet && !selectedRarity) {
        setCards([]);
        setShowAd(true);
        return;
      }

      if (!debouncedSearch && debouncedSearch.length < 3 && !selectedSet && !selectedRarity) {
        return;
      }

      setShowAd(false);
      setIsLoading(true);

      const queryParts: string[] = [];
      
      if (debouncedSearch.length >= 3) {
        if (debouncedSearch.includes('/')) {
          const parts = debouncedSearch.split('/');
          queryParts.push(`number:${parts[0]} AND set.printedTotal:${parts[1]}`);
        } else {
          queryParts.push(`name:"${debouncedSearch}*"`);
        }
      }
      if (selectedSet) queryParts.push(`set.name:"${selectedSet}"`);
      if (selectedRarity) queryParts.push(`rarity:"${selectedRarity}"`);

      const query = queryParts.join(' AND ');

      try {
        const res = await fetch(`${API_BASE}/cards?q=${encodeURIComponent(query)}&orderBy=number`);
        const data = await res.json();
        setCards(data.data || []);
      } catch (error) {
        console.error('Search failed:', error);
        setCards([]);
      } finally {
        setIsLoading(false);
      }
    }

    searchCards();
  }, [debouncedSearch, selectedSet, selectedRarity]);

  const handleCardClick = (card: PokemonCard) => {
    setSelectedCard(card);
    setView('details');
  };

  const handleAddToList = (card: PokemonCard, type: string, price: string) => {
    const uid = `${card.id}-${type}`;
    if (shoppingList.some((item) => item.uid === uid)) return;

    const newItem: ListItem = {
      uid,
      name: card.name,
      set: card.set.name,
      num: `${card.number}/${card.set.printedTotal}`,
      type,
      price,
      imageUrl: card.images.large,
      fullData: card
    };
    setShoppingList([...shoppingList, newItem]);
  };

  const handleRemoveItem = (index: number) => {
    const newList = [...shoppingList];
    newList.splice(index, 1);
    setShoppingList(newList);
  };

  const handleSendWhatsApp = () => {
    if (shoppingList.length === 0) return;
    let message = "Hi Dave, I'm checking if you have these cards. I understand prices are guides:\n\n";
    shoppingList.forEach((item, i) => {
      message += `*${i + 1}. ${item.name}*\nSet: ${item.set} (#${item.num})\nVariant: ${item.type} | Guide: ${item.price === 'TBC' ? 'TBC' : item.price}\nImage: ${item.imageUrl}\n\n`;
    });
    window.open(`https://wa.me/${APP_CONFIG.phoneNumber}?text=${encodeURIComponent(message)}`, '_blank');
  };

  return (
    <div className="min-h-screen bg-slate-100 dark:bg-slate-900">
      {view === 'search' && (
        <>
          <SearchHeader
            title={APP_CONFIG.appTitle}
            searchTerm={searchTerm}
            onSearchChange={setSearchTerm}
            selectedSet={selectedSet}
            onSetChange={setSelectedSet}
            selectedRarity={selectedRarity}
            onRarityChange={setSelectedRarity}
            sets={sets}
            rarities={rarities}
            isDark={isDark}
            onToggleTheme={toggleTheme}
          />
          {showAd && <SponsorCard />}
          {isLoading ? <LoadingSpinner /> : <CardGrid cards={cards} onCardClick={handleCardClick} />}
        </>
      )}

      {view === 'details' && selectedCard && (
        <CardDetails
          card={selectedCard}
          gbpRate={gbpRate}
          shoppingList={shoppingList}
          onAdd={handleAddToList}
          onBack={() => setView('search')}
        />
      )}

      {view === 'list' && (
        <InquiryList
          items={shoppingList}
          onRemove={handleRemoveItem}
          onItemClick={(index) => {
            setSelectedCard(shoppingList[index].fullData);
            setView('details');
          }}
          onClose={() => setView('search')}
          onSendWhatsApp={handleSendWhatsApp}
        />
      )}

      <CartBar count={shoppingList.length} onClick={() => setView('list')} />
    </div>
  );
}