import { useState, useEffect, useCallback } from "react";

const API_BASE = "https://api.pokemontcg.io/v2";

interface AppState {
  searchTerm: string;
  selectedSet: string;
  selectedRarity: string;
  cards: any[];
}

export function useAppState() {
  const [state, setState] = useState<AppState>({
    searchTerm: "",
    selectedSet: "",
    selectedRarity: "",
    cards: [],
  });

  const [sets, setSets] = useState<any[]>([]);
  const [rarities, setRarities] = useState<string[]>([]);
  const [gbpRate, setGbpRate] = useState<number>(0.78);
  const [isLoading, setIsLoading] = useState(false);
  const [hasSearched, setHasSearched] = useState(false);

  useEffect(() => {
    async function init() {
      try {
        const [setsRes, raritiesRes, rateRes] = await Promise.all([
          fetch(`${API_BASE}/sets?orderBy=-releaseDate`),
          fetch(`${API_BASE}/rarities`),
          fetch("https://open.er-api.com/v6/latest/USD"),
        ]);
        const setsData = await setsRes.json();
        const raritiesData = await raritiesRes.json();
        const rateData = await rateRes.json();
        setSets(setsData.data || []);
        setRarities(raritiesData.data || []);
        setGbpRate(rateData.rates?.GBP || 0.78);
      } catch (error) {
        console.error("Failed to initialize:", error);
      }
    }
    init();
  }, []);

  const updateState = useCallback((key: keyof AppState, value: any) => {
    setState((prev) => ({ ...prev, [key]: value }));
  }, []);

  const executeSearch = useCallback(async () => {
    const { searchTerm, selectedSet, selectedRarity } = state;
    if (!searchTerm && !selectedSet && !selectedRarity) return;

    setIsLoading(true);
    setHasSearched(true);

    const queryParts: string[] = [];
    if (searchTerm) {
      const term = searchTerm.trim();
      if (term.includes("/")) {
        const parts = term.split("/");
        const num = parts[0].replace(/^0+/, "");
        const total = parts[1];
        queryParts.push(
          `number:${num} AND (set.printedTotal:${total} OR set.total:${total})`
        );
      } else {
        queryParts.push(`name:"${term}*"`);
      }
    }
    if (selectedSet) queryParts.push(`set.name:"${selectedSet}"`);
    if (selectedRarity) queryParts.push(`rarity:"${selectedRarity}"`);

    const query = queryParts.join(" AND ");

    try {
      const url = `${API_BASE}/cards?q=${encodeURIComponent(
        query
      )}&orderBy=-set.releaseDate,number&pageSize=96`;
      const res = await fetch(url);
      const data = await res.json();
      setState((prev) => ({ ...prev, cards: data.data || [] }));
    } catch (error) {
      console.error("Search failed:", error);
      setState((prev) => ({ ...prev, cards: [] }));
    } finally {
      setIsLoading(false);
    }
  }, [state]);

  const resetHome = useCallback(() => {
    setState({
      searchTerm: "",
      selectedSet: "",
      selectedRarity: "",
      cards: [],
    });
    setHasSearched(false);
  }, []);

  const fetchCardDetails = useCallback(async (cardId: string) => {
    try {
      const res = await fetch(`${API_BASE}/cards/${cardId}`);
      const data = await res.json();
      return data.data;
    } catch (error) {
      console.error("Failed to fetch card:", error);
      return null;
    }
  }, []);

  return {
    state,
    updateState,
    sets,
    rarities,
    gbpRate,
    isLoading,
    hasSearched,
    executeSearch,
    resetHome,
    fetchCardDetails,
  };
}