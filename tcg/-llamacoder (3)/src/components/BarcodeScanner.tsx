import { useEffect, useRef, useState } from 'react';
import { X, Camera } from 'lucide-react';

interface BarcodeScannerProps {
  onDetected: (value: string) => void;
  onClose: () => void;
}

export function BarcodeScanner({ onDetected, onClose }: BarcodeScannerProps) {
  const videoRef = useRef<HTMLVideoElement>(null);
  const [error, setError] = useState<string | null>(null);
  const [manualInput, setManualInput] = useState('');

  useEffect(() => {
    let stream: MediaStream | null = null;

    async function startCamera() {
      try {
        stream = await navigator.mediaDevices.getUserMedia({
          video: { facingMode: 'environment' },
        });
        if (videoRef.current) {
          videoRef.current.srcObject = stream;
        }
      } catch (err) {
        setError('Camera access denied. Please enable camera permissions or enter barcode manually.');
      }
    }

    startCamera();

    return () => {
      if (stream) {
        stream.getTracks().forEach((track) => track.stop());
      }
    };
  }, []);

  const handleManualSubmit = () => {
    if (manualInput.trim()) {
      onDetected(manualInput.trim());
    }
  };

  return (
    <div className="fixed inset-0 z-50 bg-black">
      <div className="absolute top-0 left-0 right-0 z-10 flex items-center justify-between p-4 bg-black/50">
        <h2 className="text-white font-bold">Scan Barcode</h2>
        <button onClick={onClose} className="p-2 rounded-full bg-white/20 hover:bg-white/30">
          <X className="w-6 h-6 text-white" />
        </button>
      </div>

      {error ? (
        <div className="flex flex-col items-center justify-center h-full p-6">
          <Camera className="w-16 h-16 text-white/50 mb-4" />
          <p className="text-white/70 text-center mb-6">{error}</p>
          <div className="w-full max-w-sm space-y-4">
            <input
              type="text"
              value={manualInput}
              onChange={(e) => setManualInput(e.target.value)}
              placeholder="Enter card number (e.g. 123/165)"
              className="w-full h-12 px-4 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/50 outline-none focus:ring-2 focus:ring-blue-500"
            />
            <button
              onClick={handleManualSubmit}
              disabled={!manualInput.trim()}
              className="w-full h-12 bg-blue-500 hover:bg-blue-600 disabled:bg-white/20 disabled:text-white/50 rounded-xl font-bold text-white"
            >
              Search
            </button>
          </div>
        </div>
      ) : (
        <video
          ref={videoRef}
          autoPlay
          playsInline
          className="w-full h-full object-cover"
        />
      )}

      <div className="absolute bottom-0 left-0 right-0 p-6 bg-gradient-to-t from-black/80 to-transparent">
        <p className="text-white/70 text-center text-sm">
          Position the card number/barcode within the camera view
        </p>
        <div className="mt-4 flex justify-center">
          <div className="w-64 h-1 bg-white/30 rounded-full overflow-hidden">
            <div className="h-full w-1/2 bg-white animate-pulse" />
          </div>
        </div>
      </div>
    </div>
  );
}