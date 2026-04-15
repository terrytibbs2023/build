import { Search, Moon, Sun } from 'lucide-react';

interface SearchHeaderProps {
  title: string;
  searchTerm: string;
  onSearchChange: (value: string) => void;
  selectedSet: string;
  onSetChange: (value: string) => void;
  selectedRarity: string;
  onRarityChange: (value: string) => void;
  sets: { id: string; name: string }[];
  rarities: string[];
  isDark: boolean;
  onToggleTheme: () => void;
}

export function SearchHeader({
  title,
  searchTerm,
  onSearchChange,
  selectedSet,
  onSetChange,
  selectedRarity,
  onRarityChange,
  sets,
  rarities,
  isDark,
  onToggleTheme,
}: SearchHeaderProps) {
  return (
    <header className="sticky top-0 z-50 bg-white/90 dark:bg-slate-900/90 backdrop-blur-xl border-b border-slate-200 dark:border-slate-700">
      <div className="flex items-center justify-between px-4 py-3">
        <h1 className="text-2xl font-extrabold text-slate-900 dark:text-white tracking-tight">
          {title}
        </h1>
        <button
          onClick={onToggleTheme}
          className="p-2 rounded-full hover:bg-slate-100 dark:hover:bg-slate-800"
        >
          {isDark ? (
            <Sun className="w-5 h-5 text-slate-600 dark:text-slate-300" />
          ) : (
            <Moon className="w-5 h-5 text-slate-600" />
          )}
        </button>
      </div>

      <div className="px-4 pb-3">
        <div className="relative bg-slate-100 dark:bg-slate-800 rounded-xl flex items-center px-4 h-12">
          <Search className="w-5 h-5 text-slate-400 mr-3" />
          <input
            type="text"
            value={searchTerm}
            onChange={(e) => onSearchChange(e.target.value)}
            placeholder="Card name or number..."
            className="w-full bg-transparent border-none outline-none text-slate-900 dark:text-white placeholder-slate-400"
          />
        </div>
      </div>

      <div className="flex gap-2 px-4 pb-4 overflow-x-auto scrollbar-hide">
        <div className="flex items-center bg-white dark:bg-slate-800 rounded-lg px-3 py-2 border border-slate-200 dark:border-slate-700 min-w-[140px]">
          <label className="text-xs font-bold text-slate-500 uppercase mr-2">Set</label>
          <select
            value={selectedSet}
            onChange={(e) => onSetChange(e.target.value)}
            className="bg-transparent border-none outline-none text-sm font-semibold text-slate-900 dark:text-white flex-1"
          >
            <option value="">All</option>
            {sets.map((set) => (
              <option key={set.id} value={set.name}>
                {set.name}
              </option>
            ))}
          </select>
        </div>

        <div className="flex items-center bg-white dark:bg-slate-800 rounded-lg px-3 py-2 border border-slate-200 dark:border-slate-700 min-w-[140px]">
          <label className="text-xs font-bold text-slate-500 uppercase mr-2">Rarity</label>
          <select
            value={selectedRarity}
            onChange={(e) => onRarityChange(e.target.value)}
            className="bg-transparent border-none outline-none text-sm font-semibold text-slate-900 dark:text-white flex-1"
          >
            <option value="">All</option>
            {rarities.map((rarity) => (
              <option key={rarity} value={rarity}>
                {rarity}
              </option>
            ))}
          </select>
        </div>
      </div>
    </header>
  );
}