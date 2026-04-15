import { ArrowLeft, Plus, Check, ExternalLink } from 'lucide-react';
import { PokemonCard, ListItem } from '../types';
import { APP_CONFIG } from '../utils/constants';

interface CardDetailsProps {
  card: PokemonCard;
  gbpRate: number;
  shoppingList: ListItem[];
  onAdd: (card: PokemonCard, type: string, price: string) => void;
  onBack: () => void;
}

// Generate unique barcode string for a card + variant
function generateBarcodeString(card: PokemonCard, variantType: string): string {
  // First 3 letters of card name (uppercase)
  const namePrefix = card.name.substring(0, 3).toUpperCase();
  
  // Set ID
  const setId = card.set.id;
  
  // Card number with padding
  const cardNum = card.number.padStart(3, '0');
  
  // First 2 letters of variant type
  const typePrefix = variantType.substring(0, 2).toUpperCase();
  
  // Combine: PIK-swsh1-025-HO
  return `${namePrefix}-${setId}-${cardNum}-${typePrefix}`;
}

// Generate consistent bar widths from barcode string
function generateBarWidths(barcodeString: string): number[] {
  // Create numeric seed from string
  let seed = 0;
  for (let i = 0; i < barcodeString.length; i++) {
    seed += barcodeString.charCodeAt(i) * (i + 1);
  }
  
  // Generate 30 bar widths using seeded pseudo-random
  const bars: number[] = [];
  let current = seed;
  for (let i = 0; i < 30; i++) {
    current = (current * 9301 + 49297) % 233280;
    bars.push((current % 5) + 1); // Width 1-5
  }
  return bars;
}

export function CardDetails({ card, gbpRate, shoppingList, onAdd, onBack }: CardDetailsProps) {
  const displayNum = `${card.number}/${card.set.printedTotal}`;
  const ebayLink = `https://www.ebay.co.uk/sch/i.html?_from=R40&_nkw=${encodeURIComponent(card.name + ' ' + displayNum + ' ' + card.set.name + ' sold')}&LH_Sold=1&LH_Complete=1`;
  const prices = card.tcgplayer?.prices || {};

  const formatPrice = (usd: number) => {
    const gbp = usd * gbpRate * 1.10;
    return `£${gbp.toFixed(2)}`;
  };

  return (
    <div className="min-h-screen bg-slate-100 dark:bg-slate-900 p-4">
      <div className="max-w-md mx-auto">
        <button
          onClick={onBack}
          className="flex items-center gap-2 text-slate-600 dark:text-slate-300 mb-4 hover:text-slate-900 dark:hover:text-white"
        >
          <ArrowLeft className="w-5 h-5" />
          <span className="font-medium">Back</span>
        </button>

        <div className="bg-white dark:bg-slate-800 rounded-3xl p-6 shadow-lg">
          <img
            src={card.images.large}
            alt={card.name}
            className="w-full rounded-2xl shadow-md mb-6"
          />

          <h1 className="text-2xl font-bold text-center text-slate-900 dark:text-white mb-2">
            {card.name}
          </h1>

          <p className="text-slate-500 dark:text-slate-400 text-center text-sm mb-4">
            {card.set.name}
          </p>

          {/* Card Number Display */}
          <div className="bg-slate-100 dark:bg-slate-700 rounded-2xl p-4 mb-6">
            <div className="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase text-center mb-2">
              Card Number
            </div>
            <div className="text-3xl font-bold text-center text-slate-900 dark:text-white tracking-wider">
              {displayNum}
            </div>
          </div>

          <div className="bg-amber-50 dark:bg-amber-900/30 border border-amber-200 dark:border-amber-700 rounded-xl p-4 mb-6">
            <p className="text-sm text-amber-800 dark:text-amber-200 text-center">
              <strong>Please Note:</strong> Market guides only. Final valuations confirmed by <strong>Ellis TCG</strong>.
            </p>
          </div>

          {Object.keys(prices).length > 0 ? (
            Object.entries(prices).map(([type, priceData]) => {
              const market = priceData.market;
              if (!market) return null;
              const priceDisplay = formatPrice(market);
              const uid = `${card.id}-${type}`;
              const isAdded = shoppingList.some((item) => item.uid === uid);

              // Generate unique barcode for this card + variant
              const barcodeString = generateBarcodeString(card, type);
              const barWidths = generateBarWidths(barcodeString);

              return (
                <div key={type} className="bg-slate-50 dark:bg-slate-700/50 rounded-2xl p-5 mb-4">
                  <div className="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase text-center mb-1">
                    {type} - Guide Price
                  </div>
                  <div className="text-4xl font-bold text-center text-blue-600 dark:text-blue-400 mb-4">
                    {priceDisplay}
                  </div>

                  {/* Unique Barcode */}
                  <div className="bg-white dark:bg-slate-800 rounded-xl p-4 mb-4">
                    <div className="flex justify-center items-end gap-px h-14">
                      {barWidths.map((width, i) => (
                        <div
                          key={i}
                          className="bg-slate-900 dark:bg-white"
                          style={{ width: `${width}px`, height: i % 3 === 0 ? '100%' : '85%' }}
                        />
                      ))}
                    </div>
                    <div className="text-xs font-mono text-center text-slate-600 dark:text-slate-300 mt-2 tracking-widest font-bold">
                      {barcodeString}
                    </div>
                  </div>

                  <button
                    onClick={() => onAdd(card, type, priceDisplay)}
                    disabled={isAdded}
                    className={`w-full h-14 rounded-xl font-bold flex items-center justify-center gap-2 ${
                      isAdded
                        ? 'bg-slate-300 dark:bg-slate-600 text-slate-500 dark:text-slate-400 cursor-not-allowed'
                        : 'bg-green-500 hover:bg-green-600 text-white'
                    }`}
                  >
                    {isAdded ? (
                      <>
                        <Check className="w-5 h-5" />
                        {APP_CONFIG.addedText}
                      </>
                    ) : (
                      <>
                        <Plus className="w-5 h-5" />
                        {APP_CONFIG.buttonText}
                      </>
                    )}
                  </button>
                  <a
                    href={ebayLink}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="w-full h-10 mt-3 rounded-xl font-semibold flex items-center justify-center gap-2 border-2 border-blue-600 text-blue-600 dark:border-blue-400 dark:text-blue-400 hover:bg-blue-50 dark:hover:bg-blue-900/30"
                  >
                    <ExternalLink className="w-4 h-4" />
                    View eBay Sold
                  </a>
                </div>
              );
            })
          ) : (
            <div className="bg-slate-50 dark:bg-slate-700/50 rounded-2xl p-5">
              <div className="text-4xl font-bold text-center text-slate-400 mb-4">TBC</div>
              
              {/* Barcode for TBC cards */}
              <div className="bg-white dark:bg-slate-800 rounded-xl p-4 mb-4">
                <div className="flex justify-center items-end gap-px h-14">
                  {generateBarWidths(generateBarcodeString(card, 'Standard')).map((width, i) => (
                    <div
                      key={i}
                      className="bg-slate-900 dark:bg-white"
                      style={{ width: `${width}px`, height: i % 3 === 0 ? '100%' : '85%' }}
                    />
                  ))}
                </div>
                <div className="text-xs font-mono text-center text-slate-600 dark:text-slate-300 mt-2 tracking-widest font-bold">
                  {generateBarcodeString(card, 'Standard')}
                </div>
              </div>
              
              <button
                onClick={() => onAdd(card, 'Standard', 'TBC')}
                className="w-full h-14 rounded-xl font-bold flex items-center justify-center gap-2 bg-green-500 hover:bg-green-600 text-white"
              >
                <Plus className="w-5 h-5" />
                {APP_CONFIG.buttonText}
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}