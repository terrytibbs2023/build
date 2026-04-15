export interface PokemonCard {
  id: string;
  name: string;
  number: string;
  set: {
    id: string;
    name: string;
    printedTotal: number;
  };
  images: {
    small: string;
    large: string;
  };
  rarity?: string;
  tcgplayer?: {
    prices: {
      [variant: string]: {
        market?: number;
      };
    };
  };
}

export interface ListItem {
  uid: string;
  name: string;
  set: string;
  num: string;
  type: string;
  price: string;
  imageUrl: string;
  fullData: PokemonCard;
}

export interface AppConfig {
  logoUrl: string;
  appTitle: string;
  storeUrl: string;
  adTitle: string;
  adDescription: string;
  phoneNumber: string;
  buttonText: string;
  addedText: string;
}