import { Theme } from "../hooks/useTheme";

interface CardGridProps {
  cards: any[];
  hasSearched: boolean;
  onCardClick: (card: any) => void;
  theme: Theme;
}

export function CardGrid({ cards, hasSearched, onCardClick, theme }: CardGridProps) {
  if (cards.length === 0 && hasSearched) {
    return (
      <div className="flex flex-col items-center justify-center py-20">
        <p className={`text-lg font-medium ${theme.textMuted}`}>No cards found</p>
      </div>
    );
  }

  return (
    <div className="grid grid-cols-2 gap-4 p-4">
      {cards.map((card) => (
        <button
          key={card.id}
          onClick={() => onCardClick(card)}
          className={`${theme.card} rounded-2xl p-3 shadow-md border ${theme.border} text-left hover:scale-[1.02] transition-all duration-300`}
        >
          <div className={`aspect-[1/1.4] ${theme.input} rounded-xl mb-2 flex items-center justify-center overflow-hidden`}>
            <img
              src={card.images.small}
              alt={card.name}
              loading="lazy"
              className="max-w-[90%] max-h-[90%] object-contain"
            />
          </div>
          <h3 className={`font-bold text-sm ${theme.text} line-clamp-2`}>
            {card.name}
          </h3>
          <p className={`text-xs ${theme.textMuted} mt-1`}>
            {card.set.name}
          </p>
        </button>
      ))}
    </div>
  );
}