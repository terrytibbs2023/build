import { useEffect, useRef } from 'react';
import { generateBarcodeData, renderBarcode, getBarcodeDisplayText, BarcodeParams } from '../utils/barcode';

interface BarcodeDisplayProps {
  cardName: string;
  cardNumber: string;
  setTotal: string;
  setName: string;
  cardType: string;
}

export function BarcodeDisplay({ cardName, cardNumber, setTotal, setName, cardType }: BarcodeDisplayProps) {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  
  const params: BarcodeParams = {
    cardName,
    cardNumber,
    setTotal,
    setName,
    cardType
  };
  
  const barcodeData = generateBarcodeData(params);
  const displayText = getBarcodeDisplayText(params);

  useEffect(() => {
    if (canvasRef.current) {
      renderBarcode(canvasRef.current, barcodeData);
    }
  }, [barcodeData]);

  return (
    <div className="bg-white dark:bg-slate-100 rounded-xl p-4 flex flex-col items-center border border-slate-200 dark:border-slate-600">
      <p className="text-xs font-bold text-slate-500 uppercase mb-2 tracking-wider">
        Card Identifier
      </p>
      <canvas
        ref={canvasRef}
        width={320}
        height={60}
        className="w-full max-w-[320px] h-auto"
      />
      <p className="mt-2 text-sm font-mono font-bold text-slate-700 tracking-widest">
        {displayText}
      </p>
    </div>
  );
}