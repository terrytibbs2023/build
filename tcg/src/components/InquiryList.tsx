import { X, MessageCircle } from 'lucide-react';
import { ListItem } from '../types';
import { APP_CONFIG } from '../utils/constants';

interface InquiryListProps {
  items: ListItem[];
  onRemove: (index: number) => void;
  onItemClick: (index: number) => void;
  onClose: () => void;
  onSendWhatsApp: () => void;
}

export function InquiryList({ items, onRemove, onItemClick, onClose, onSendWhatsApp }: InquiryListProps) {
  return (
    <div className="fixed inset-0 bg-slate-100 dark:bg-slate-900 z-50 overflow-y-auto">
      <div className="max-w-md mx-auto p-4">
        <div className="flex items-center justify-between mb-6">
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">Your Inquiry List</h2>
          <button
            onClick={onClose}
            className="p-2 rounded-full hover:bg-slate-200 dark:hover:bg-slate-800"
          >
            <X className="w-6 h-6 text-slate-600 dark:text-slate-300" />
          </button>
        </div>

        {items.length === 0 ? (
          <div className="text-center py-20 text-slate-400">
            <p className="text-lg">Your list is empty</p>
          </div>
        ) : (
          <div className="space-y-3">
            {items.map((item, index) => (
              <div
                key={item.uid}
                onClick={() => onItemClick(index)}
                className="bg-white dark:bg-slate-800 rounded-2xl p-4 shadow-md border border-slate-100 dark:border-slate-700 cursor-pointer hover:bg-slate-50 dark:hover:bg-slate-700/50"
              >
                <div className="flex justify-between items-start">
                  <div className="flex-1">
                    <h3 className="font-bold text-slate-900 dark:text-white">{item.name}</h3>
                    <p className="text-sm text-slate-500 dark:text-slate-400">{item.set} (#{item.num})</p>
                    <p className="font-bold text-blue-600 dark:text-blue-400 mt-1">
                      {item.price === 'TBC' ? 'TBC' : item.price} ({item.type})
                    </p>
                  </div>
                  <button
                    onClick={(e) => {
                      e.stopPropagation();
                      onRemove(index);
                    }}
                    className="text-red-500 font-semibold text-sm px-3 py-1 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg"
                  >
                    Remove
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {items.length > 0 && (
          <div className="mt-8 space-y-3">
            <button
              onClick={onSendWhatsApp}
              className="w-full h-14 bg-green-500 hover:bg-green-600 text-white rounded-xl font-bold flex items-center justify-center gap-2"
            >
              <MessageCircle className="w-5 h-5" />
              Send List to WhatsApp
            </button>
            <button
              onClick={onClose}
              className="w-full h-12 bg-slate-200 dark:bg-slate-700 text-slate-700 dark:text-slate-200 rounded-xl font-semibold"
            >
              Close & Continue Searching
            </button>
          </div>
        )}
      </div>
    </div>
  );
}