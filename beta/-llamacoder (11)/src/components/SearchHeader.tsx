import { Button } from "./ui/button";
import { Input } from "./ui/input";
import { Home } from "lucide-react";
import { Theme } from "../hooks/useTheme";
import { ThemeButton } from "./ThemeButton";

interface SearchHeaderProps {
  searchTerm: string;
  selectedSet: string;
  selectedRarity: string;
  sets: any[];
  rarities: string[];
  theme: Theme;
  onSearchChange: (value: string) => void;
  onSetChange: (value: string) => void;
  onRarityChange: (value: string) => void;
  onSearch: () => void;
  onReset: () => void;
  onCycleTheme: () => void;
}

export function SearchHeader({
  searchTerm,
  selectedSet,
  selectedRarity,
  sets,
  rarities,
  theme,
  onSearchChange,
  onSetChange,
  onRarityChange,
  onSearch,
  onReset,
  onCycleTheme,
}: SearchHeaderProps) {
  return (
    <header
      className={`sticky top-0 z-50 backdrop-blur-xl border-b ${theme.card}/90 ${theme.border}`}
    >
      <div className="flex items-center justify-between px-4 py-3">
        <div className="flex items-center gap-3">
          <Button
            variant="ghost"
            size="icon"
            onClick={onReset}
            className={`rounded-xl ${theme.button} ${theme.buttonHover}`}
          >
            <Home className={`w-5 h-5 ${theme.text}`} />
          </Button>
          <div>
            <h1 className={`text-xl font-extrabold tracking-tight ${theme.text}`}>
              Card Inquiry
            </h1>
            <p className={`text-xs font-medium ${theme.textMuted}`}>
              East Coast Collectibles
            </p>
          </div>
        </div>
        <ThemeButton theme={theme} onCycle={onCycleTheme} />
      </div>

      <div className="px-4 pb-3">
        <form
          onSubmit={(e) => {
            e.preventDefault();
            onSearch();
          }}
          className={`relative rounded-xl flex items-center px-4 h-12 ${theme.input}`}
        >
          <svg
            className={`w-5 h-5 mr-3 ${theme.textMuted}`}
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
            />
          </svg>
          <Input
            type="search"
            value={searchTerm}
            onChange={(e) => onSearchChange(e.target.value)}
            placeholder="Type card name or number..."
            className={`w-full bg-transparent border-none text-base font-medium ${theme.text} placeholder:${theme.textMuted}`}
          />
        </form>
      </div>

      <div className="flex gap-2 px-4 pb-4">
        <div
          className={`flex-1 rounded-lg px-3 h-11 flex items-center border ${theme.card} ${theme.border}`}
        >
          <select
            value={selectedSet}
            onChange={(e) => onSetChange(e.target.value)}
            className={`w-full bg-transparent text-sm font-bold outline-none ${theme.text}`}
          >
            <option value="">Set...</option>
            {sets.map((s) => (
              <option key={s.id} value={s.name} className="bg-slate-800">
                {s.name}
              </option>
            ))}
          </select>
        </div>

        <div
          className={`flex-1 rounded-lg px-3 h-11 flex items-center border ${theme.card} ${theme.border}`}
        >
          <select
            value={selectedRarity}
            onChange={(e) => onRarityChange(e.target.value)}
            className={`w-full bg-transparent text-sm font-bold outline-none ${theme.text}`}
          >
            <option value="">Rarity...</option>
            {rarities.map((r) => (
              <option key={r} value={r} className="bg-slate-800">
                {r}
              </option>
            ))}
          </select>
        </div>
      </div>
    </header>
  );
}