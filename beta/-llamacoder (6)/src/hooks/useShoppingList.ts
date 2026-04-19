import { useState, useEffect, useCallback } from "react";
import { formatPrice } from "../utils/pricing";

export interface ShoppingListItem {
  uid: string;
  name: string;
  set: string;
  num: string;
  type: string;
  price: string;
  imageUrl: string;
  fullData: any;
}

const APP_CONFIG = {
  phoneNumber: "447749893611",
};

export function useShoppingList() {
  const [shoppingList, setShoppingList] = useState<ShoppingListItem[]>(() => {
    const stored = localStorage.getItem("tcgInquiryList");
    return stored ? JSON.parse(stored) : [];
  });

  useEffect(() => {
    localStorage.setItem("tcgInquiryList", JSON.stringify(shoppingList));
  }, [shoppingList]);

  const addToList = useCallback(
    (card: any, type: string, price: string, gbpRate: number) => {
      const uid = `${card.id}-${type}`;
      if (shoppingList.some((item) => item.uid === uid)) return;

      const getCardCode = (c: any): string => {
        const number = String(c.number);
        const total = String(c.set.printedTotal || c.set.total);
        if (!isNaN(Number(number)) && !isNaN(Number(total))) {
          return `${number.padStart(total.length, "0")}/${total}`;
        }
        return `${number}/${total}`;
      };

      const newItem: ShoppingListItem = {
        uid,
        name: card.name,
        set: card.set.name,
        num: getCardCode(card),
        type,
        price,
        imageUrl: card.images.large,
        fullData: JSON.parse(JSON.stringify(card)),
      };

      setShoppingList((prev) => [...prev, newItem]);
    },
    [shoppingList]
  );

  const removeFromList = useCallback((index: number) => {
    setShoppingList((prev) => prev.filter((_, i) => i !== index));
  }, []);

  const sendWhatsApp = useCallback(() => {
    if (shoppingList.length === 0) return;

    let message =
      "Hi Dave, I'm checking if you have these cards. I understand prices are guides:\n\n";

    shoppingList.forEach((item, i) => {
      message += `*${i + 1}. ${item.name}*\nSet: ${item.set} (${item.num})\nVariant: ${item.type} | Guide: ${item.price}\nImage: ${item.imageUrl}\n\n`;
    });

    window.open(
      `https://wa.me/${APP_CONFIG.phoneNumber}?text=${encodeURIComponent(message)}`,
      "_blank"
    );
  }, [shoppingList]);

  const getListCount = useCallback(() => shoppingList.length, [shoppingList]);

  return {
    shoppingList,
    addToList,
    removeFromList,
    sendWhatsApp,
    getListCount,
  };
}