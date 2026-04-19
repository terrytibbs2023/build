import { Theme } from "../hooks/useTheme";

interface CartBarProps {
  count: number;
  onClick: () => void;
  theme: Theme;
}

export function CartBar({ count, onClick, theme }: CartBarProps) {
  if (count === 0) return null;

  return (
    <button
      onClick={onClick}
      className={`fixed bottom-8 left-1/2 -translate-x-1/2 w-[90%] max-w-md ${theme.accent} text-white h-16 rounded-3xl flex items-center justify-between px-6 shadow-2xl z-50 font-black transition-all duration-300 hover:scale-105 active:scale-95`}
    >
      <span>Inquiry List</span>
      <span className={`bg-white ${theme.accentText} px-3 py-1 rounded-xl font-bold`}>
        {count}
      </span>
    </button>
  );
}