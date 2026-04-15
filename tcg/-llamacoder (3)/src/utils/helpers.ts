import { ListItem } from '../types';

export function formatPrice(price: string | number): string {
  if (price === 'TBC' || price === 0) return 'TBC';
  const num = typeof price === 'string' ? parseFloat(price) : price;
  if (isNaN(num)) return 'TBC';
  return `£${num.toFixed(2)}`;
}

export function generateWhatsAppMessage(items: ListItem[]): string {
  if (items.length === 0) return '';
  let message = "Hi Dave, I'm checking if you have these cards. I understand prices are guides:\n\n";
  items.forEach((item, i) => {
    message += `*${i + 1}. ${item.name}*\nSet: ${item.set} (#${item.num})\nVariant: ${item.type} | Guide: ${formatPrice(item.price)}\nImage: ${item.imageUrl}\n\n`;
  });
  return message;
}

export function calculateCollectionStats(items: ListItem[]) {
  const totalCards = items.reduce((sum, item) => sum + (item.quantity || 1), 0);
  const totalValue = items.reduce((sum, item) => {
    const price = typeof item.price === 'string' ? parseFloat(item.price) : item.price;
    return sum + (isNaN(price) ? 0 : price);
  }, 0);

  const bySet: Record<string, { count: number; value: number }> = {};
  items.forEach((item) => {
    if (!bySet[item.set]) {
      bySet[item.set] = { count: 0, value: 0 };
    }
    bySet[item.set].count += item.quantity || 1;
    const price = typeof item.price === 'string' ? parseFloat(item.price) : item.price;
    bySet[item.set].value += isNaN(price) ? 0 : price;
  });

  const sortedByValue = [...items].sort((a, b) => {
    const priceA = typeof a.price === 'string' ? parseFloat(a.price) : a.price;
    const priceB = typeof b.price === 'string' ? parseFloat(b.price) : b.price;
    return (priceB || 0) - (priceA || 0);
  });

  return {
    totalCards,
    totalValue,
    bySet,
    topValueCards: sortedByValue.slice(0, 5),
  };
}