import { Button } from "./ui/button";
import { Theme } from "../hooks/useTheme";

interface ThemeButtonProps {
  theme: Theme;
  onCycle: () => void;
}

export function ThemeButton({ theme, onCycle }: ThemeButtonProps) {
  return (
    <Button
      variant="ghost"
      size="icon"
      onClick={onCycle}
      className={`rounded-full ${theme.button} ${theme.buttonHover} transition-all duration-300`}
      title={`Theme: ${theme.label}`}
    >
      <svg
        className={`w-5 h-5 ${theme.text} transition-all duration-300`}
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
      >
        <circle cx="12" cy="12" r="3" />
        <path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42" />
      </svg>
    </Button>
  );
}