interface CartBarProps {
  count: number;
  onClick: () => void;
}

export function CartBar({ count, onClick }: CartBarProps) {
  if (count === 0) return null;

  return (
    <button
      onClick={onClick}
      className="fixed bottom-8 left-1/2 -translate-x-1/2 w-[90%] max-w-md bg-blue-600 text-white h-16 rounded-full flex items-center justify-between px-6 shadow-2xl z-50"
    >
      <span className="font-bold">View Inquiry List</span>
      <span className="bg-white text-blue-600 px-3 py-1 rounded-lg font-bold">
        {count}
      </span>
    </button>
  );
}