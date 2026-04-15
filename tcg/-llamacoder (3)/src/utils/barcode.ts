// Code 128 barcode generator
const CODE128_PATTERNS: Record<string, string> = {
  ' ': '11011001100', '!': '11001101100', '"': '11001100110', '#': '10010011000',
  '$': '10010001100', '%': '10001001100', '&': '10011001000', "'": '10011000100',
  '(': '10001101000', ')': '10001100100', '*': '11010001000', '+': '11010000100',
  ',': '11010001000', '-': '11010000100', '.': '11001001000', '/': '11001000100',
  '0': '10110011100', '1': '10011011100', '2': '10011001110', '3': '10111001100',
  '4': '10011101100', '5': '10011100110', '6': '11001011100', '7': '11001101110',
  '8': '11001001110', '9': '11011100100', ':': '11000110100',
  '<': '10100011000', '=': '10001011000', '>': '10001000110', '?': '10110001000',
  '@': '10001101000', 'A': '10010110000', 'B': '10010000110', 'C': '11000010010',
  'D': '11001010000', 'E': '11110111010', 'F': '11000010100', 'G': '10001111010',
  'H': '10100111100', 'I': '10010111100', 'J': '10010011110', 'K': '10111100100',
  'L': '10011110100', 'M': '10011110010', 'N': '110111111010', 'O': '11000011100',
  'P': '11001111100', 'Q': '11000111110', 'R': '10110011110', 'S': '10111101100',
  'T': '10111100110', 'U': '11100011000', 'V': '11100100100', 'W': '11100111000',
  'X': '11000011000', 'Y': '11000001110', 'Z': '11001111000', '[': '11000111010',
  '\\': '11100101000', ']': '11100101110', '^': '11100010110', '_': '11010000110',
  '`': '11000101110', 'a': '10110000100', 'b': '10011000010', 'c': '11011000010',
  'd': '10110011000', 'e': '10011011000', 'f': '10011000110', 'g': '11011000110',
  'h': '11000110110', 'i': '10100011010', 'j': '10001011010', 'k': '11010100100',
  'l': '11010010100', 'm': '11010010010', 'n': '11001010100', 'o': '11001010010',
  'p': '11010110100', 'q': '11010110010', 'r': '11010010110', 's': '11001011010',
  't': '11001101010', 'u': '10110110000', 'v': '10110011000', 'w': '10110001100',
  'x': '10010110000', 'y': '10010100110', 'z': '10010010110', '{': '10100100110',
  '|': '10100110010', '}': '10100101100', '~': '10100100100'
};

const START_CODE_B = '11010010000';
const STOP_CODE = '1100011101011';

export interface BarcodeParams {
  cardName: string;
  cardNumber: string;
  setTotal: string;
  setName: string;
  cardType: string;
}

export function generateBarcodeData(params: BarcodeParams): string {
  const { cardName, cardNumber, setTotal, setName, cardType } = params;
  
  // First 3 letters of card name (uppercase)
  const namePrefix = cardName.substring(0, 3).toUpperCase().padEnd(3, 'X');
  
  // First 3 letters of set name (uppercase)
  const setPrefix = setName.substring(0, 3).toUpperCase().padEnd(3, 'X');
  
  // First 2 letters of card type (uppercase)
  const typePrefix = cardType.substring(0, 2).toUpperCase().padEnd(2, 'X');
  
  // Format: NAM-100/67-SET-TY (full card number with set total)
  return `${namePrefix}-${cardNumber}/${setTotal}-${setPrefix}-${typePrefix}`;
}

export function renderBarcode(canvas: HTMLCanvasElement, data: string): void {
  const ctx = canvas.getContext('2d');
  if (!ctx) return;

  // Build barcode pattern
  let pattern = START_CODE_B;
  for (const char of data) {
    pattern += CODE128_PATTERNS[char] || CODE128_PATTERNS[' '];
  }
  pattern += STOP_CODE;

  // Canvas dimensions
  const width = canvas.width;
  const height = canvas.height;
  const barWidth = width / pattern.length;

  // Clear canvas
  ctx.fillStyle = '#ffffff';
  ctx.fillRect(0, 0, width, height);

  // Draw bars
  ctx.fillStyle = '#000000';
  for (let i = 0; i < pattern.length; i++) {
    if (pattern[i] === '1') {
      ctx.fillRect(i * barWidth, 0, Math.ceil(barWidth), height);
    }
  }
}

export function getBarcodeDisplayText(params: BarcodeParams): string {
  const { cardName, cardNumber, setTotal, setName, cardType } = params;
  
  const namePrefix = cardName.substring(0, 3).toUpperCase();
  const setPrefix = setName.substring(0, 3).toUpperCase();
  const typePrefix = cardType.substring(0, 2).toUpperCase();
  
  // Format: NAM-100/67-SET-TY
  return `${namePrefix}-${cardNumber}/${setTotal}-${setPrefix}-${typePrefix}`;
}