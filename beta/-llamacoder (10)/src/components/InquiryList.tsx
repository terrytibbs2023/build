import { Button } from "./ui/button";
import { X } from "lucide-react";
import { Theme } from "../hooks/useTheme";

interface ShoppingItem {
  uid: string;
  name: string;
  set: string;
  num: string;
  type: string;
  price: string;
  imageUrl: string;
  fullData: any;
}

interface InquiryListProps {
  items: ShoppingItem[];
  theme: Theme;
  onBack: () => void;
  onRemove: (index: number) => void;
  onSendWhatsApp: () => void;
  onCardClick: (card: any) => void;
}

export function InquiryList({
  items,
  theme,
  onBack,
  onRemove,
  onSendWhatsApp,
  onCardClick,
}: InquiryListProps) {
  return (
    <div className={`fixed inset-0 z-50 overflow-y-auto ${theme.bg} transition-colors duration-500`}>
      <div className="max-w-md mx-auto p-4 pb-32">
        <div className="flex items-center justify-between mb-6">
          <h2 className={`text-2xl font-black ${theme.text}`}>
            Inquiry List
          </h2>
          <Button
            variant="ghost"
            size="icon"
            onClick={onBack}
            className={`rounded-full shadow-md ${theme.card}`}
          >
            <X className={`w-6 h-6 ${theme.text}`} />
          </Button>
        </div>

        {items.length === 0 ? (
          <div className={`text-center py-20 ${theme.textMuted} font-bold uppercase tracking-widest text-xs`}>
            No cards in list
          </div>
        ) : (
          <div className="space-y-3">
            {items.map((item, index) => (
              <div
                key={item.uid}
                onClick={() => onCardClick(item.fullData)}
                className={`${theme.card} rounded-2xl p-4 border ${theme.border} shadow-sm flex gap-4 cursor-pointer hover:border-blue-500 transition-colors`}
              >
                <img
                  src={item.imageUrl}
                  alt={item.name}
                  className="w-16 h-auto rounded-lg pointer-events-none"
                />
                <div className="flex-1 pointer-events-none">
                  <h3 className={`font-black text-sm ${theme.text}`}>
                    {item.name}
                  </h3>
                  <p className={`text-xs ${theme.textMuted} font-bold`}>
                    {item.set} ({item.num})
                  </p>
                  <p className={`${theme.accentText} font-black text-sm mt-1`}>
                    {item.price}
                  </p>
                </div>
                <button
                  onClick={(e) => {
                    e.stopPropagation();
                    onRemove(index);
                  }}
                  className="text-red-500 self-start p-2 relative z-10"
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
                      d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-4v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                    />
                  </svg>
                </button>
              </div>
            ))}
          </div>
        )}
      </div>

      {items.length > 0 && (
        <div className={`fixed bottom-0 left-0 right-0 p-4 ${theme.bg}`}>
          <Button
            onClick={onSendWhatsApp}
            className="w-full max-w-md mx-auto h-16 bg-green-500 text-white rounded-2xl font-black flex items-center justify-center gap-3 shadow-xl shadow-green-500/20"
          >
            Send Inquiry to Dave
          </Button>
        </div>
      )}
    </div>
  );
}