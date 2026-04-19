import { Button } from "./ui/button";
import { Card } from "./ui/card";
import { formatPrice, getMarkupPercentage, getBaseGbpPrice } from "../utils/pricing";
import { Theme } from "../hooks/useTheme";
import { ShoppingListItem } from "../hooks/useShoppingList";

interface CardDetailsProps {
  card: any;
  gbpRate: number;
  shoppingList: ShoppingListItem[];
  theme: Theme;
  onBack: () => void;
  onAddToList: (card: any, type: string, price: string) => void;
}

function getFullCardCode(card: any): string {
  const number = String(card.number);
  const total = String(card.set.printedTotal || card.set.total);
  if (!isNaN(Number(number)) && !isNaN(Number(total))) {
    return `${number.padStart(total.length, "0")}/${total}`;
  }
  return `${number}/${total}`;
}

export function CardDetails({
  card,
  gbpRate,
  shoppingList,
  theme,
  onBack,
  onAddToList,
}: CardDetailsProps) {
  const displayNum = getFullCardCode(card);
  const ebayLink = `https://www.ebay.co.uk/sch/i.html?_from=R40&_nkw=${encodeURIComponent(
    card.name + " " + displayNum + " " + card.set.name + " sold"
  )}&LH_Sold=1&LH_Complete=1`;

  const prices = card.tcgplayer?.prices || {};

  const renderPriceBoxes = () => {
    const priceEntries = Object.entries(prices);

    if (priceEntries.length === 0) {
      return (
        <div className={`rounded-2xl p-5 text-center ${theme.card} ${theme.border} border`}>
          <div className={`text-2xl font-black mb-4 ${theme.textMuted}`}>
            PRICE TBC
          </div>
          <Button
            onClick={() => onAddToList(card, "Standard", "TBC")}
            className="w-full h-14 rounded-xl font-bold bg-green-500 hover:bg-green-600 text-white mb-3"
          >
            Add to Inquiry List
          </Button>
          <a
            href={ebayLink}
            target="_blank"
            rel="noopener noreferrer"
          >
            <Button
              variant="outline"
              className={`w-full h-10 rounded-xl font-bold border-2 ${theme.accentText} hover:opacity-80`}
            >
              View eBay Sold
            </Button>
          </a>
        </div>
      );
    }

    return priceEntries.map(([type, priceData]: [string, any]) => {
      if (!priceData?.market) return null;

      const priceDisplay = formatPrice(priceData.market, gbpRate);
      const baseGbp = getBaseGbpPrice(priceData.market, gbpRate);
      const markupPercent = getMarkupPercentage(baseGbp);
      const uid = `${card.id}-${type}`;
      const isAdded = shoppingList.some((item) => item.uid === uid);

      return (
        <div
          key={type}
          className={`rounded-2xl p-5 mb-4 border ${theme.card} ${theme.border}`}
        >
          <div className={`text-xs font-bold uppercase text-center mb-1 ${theme.textMuted}`}>
            {type} - Guide Price
          </div>
          <div className={`text-4xl font-black text-center mb-2 ${theme.accentText}`}>
            {priceDisplay}
          </div>
          <div className={`text-xs text-center mb-4 ${theme.textMuted}`}>
            Base: £{baseGbp.toFixed(2)} • Markup: {markupPercent}
          </div>
          <Button
            onClick={() => onAddToList(card, type, priceDisplay)}
            disabled={isAdded}
            className={`w-full h-14 rounded-xl font-bold transition-all ${
              isAdded
                ? "bg-slate-200 dark:bg-slate-600 text-slate-400 cursor-not-allowed"
                : "bg-green-500 hover:bg-green-600 text-white shadow-lg shadow-green-500/20"
            }`}
          >
            {isAdded ? "Added to List" : "Add to Inquiry List"}
          </Button>
          <a
            href={ebayLink}
            target="_blank"
            rel="noopener noreferrer"
            className="block mt-3"
          >
            <Button
              variant="outline"
              className={`w-full h-10 rounded-xl font-bold border-2 ${theme.accentText} hover:opacity-80`}
            >
              View eBay Sold
            </Button>
          </a>
        </div>
      );
    });
  };

  return (
    <div className={`min-h-screen p-4 ${theme.bg}`}>
      <div className="max-w-md mx-auto">
        <button
          onClick={onBack}
          className={`flex items-center gap-2 mb-4 font-bold ${theme.text}`}
        >
          <svg
            className="w-5 h-5"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M15 19l-7-7 7-7"
            />
          </svg>
          Back
        </button>

        <Card className={`rounded-3xl p-6 shadow-xl border ${theme.card} ${theme.border}`}>
          <img
            src={card.images.large}
            alt={card.name}
            className="w-full rounded-2xl shadow-lg mb-6 border"
          />

          <h1 className={`text-2xl font-black text-center leading-tight ${theme.text}`}>
            {card.name}
          </h1>

          <p className={`text-center font-bold text-sm mb-6 ${theme.textMuted}`}>
            {card.set.name} • {displayNum}
          </p>

          <div className="rounded-2xl p-4 mb-6 bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800">
            <p className="text-xs leading-relaxed text-amber-800 dark:text-amber-200 font-medium text-center">
              <b>Please Note:</b> Prices are for guide only. Prices & Stock will be confirmed by{" "}
              <b>East Coast Collectibles by WhatsApp</b>.
            </p>
          </div>

          {renderPriceBoxes()}
        </Card>
      </div>
    </div>
  );
}