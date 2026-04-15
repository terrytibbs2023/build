import { PokemonCard } from '../types';

interface CardGridProps {
  cards: PokemonCard[];
  onCardClick: (card: PokemonCard) => void;
}

export function CardGrid({ cards, onCardClick }: CardGridProps) {
  if (cards.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-20 text-slate-400">
        <p className="text-lg font-medium">No cards found</p>
      </div>
    );
  }

  return (
    <div className="grid grid-cols-2 gap-4 p-4">
      {cards.map((card) => (
        <button
          key={card.id}
          onClick={() => onCardClick(card)}
          className="bg-white dark:bg-slate-800 rounded-2xl p-3 shadow-md border border-slate-100 dark:border-slate-700 text-left hover:scale-[1.02] transition-transform"
        >
          <div className="aspect-[1/1.4] bg-slate-100 dark:bg-slate-700 rounded-xl mb-2 flex items-center justify-center overflow-hidden">
            <img
              src={card.images.small}
              alt={card.name}
              loading="lazy"
              className="max-w-[90%] max-h-[90%] object-contain"
            />
          </div>
          <h3 className="font-bold text-sm text-slate-900 dark:text-white line-clamp-2">
            {card.name}
          </h3>
          <p className="text-xs text-slate-500 dark:text-slate-400 mt-1">{card.set.name}</p>
        </button>
      ))}
    </div>
  );
}