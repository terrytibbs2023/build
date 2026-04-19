import { Theme } from "../hooks/useTheme";

interface LoadingSpinnerProps {
  theme: Theme;
}

export function LoadingSpinner({ theme }: LoadingSpinnerProps) {
  return (
    <div className="flex flex-col items-center justify-center py-20">
      <div className={`w-10 h-10 border-4 ${theme.border} border-t-blue-500 rounded-full animate-spin`}></div>
      <p className={`mt-4 font-medium uppercase text-xs ${theme.textMuted}`}>
        Searching...
      </p>
    </div>
  );
}