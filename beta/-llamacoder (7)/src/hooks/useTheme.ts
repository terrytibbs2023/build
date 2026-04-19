import { useState, useEffect, useCallback } from "react";

export type ThemeName = "dark" | "light" | "ocean" | "forest" | "sunset" | "navy" | "berry" | "lavender" | "charcoal" | "rose";

export interface Theme {
  name: ThemeName;
  label: string;
  bg: string;
  card: string;
  text: string;
  textMuted: string;
  border: string;
  accent: string;
  accentText: string;
  button: string;
  buttonHover: string;
  input: string;
}

export const themes: Record<ThemeName, Theme> = {
  dark: {
    name: "dark",
    label: "Dark",
    bg: "bg-slate-900",
    card: "bg-slate-800",
    text: "text-white",
    textMuted: "text-slate-400",
    border: "border-slate-700",
    accent: "bg-blue-600",
    accentText: "text-blue-400",
    button: "bg-slate-800",
    buttonHover: "hover:bg-slate-700",
    input: "bg-slate-800",
  },
  light: {
    name: "light",
    label: "Light",
    bg: "bg-slate-100",
    card: "bg-white",
    text: "text-slate-900",
    textMuted: "text-slate-500",
    border: "border-slate-200",
    accent: "bg-blue-600",
    accentText: "text-blue-600",
    button: "bg-slate-100",
    buttonHover: "hover:bg-slate-200",
    input: "bg-slate-100",
  },
  ocean: {
    name: "ocean",
    label: "Ocean",
    bg: "bg-cyan-950",
    card: "bg-cyan-900",
    text: "text-cyan-50",
    textMuted: "text-cyan-300",
    border: "border-cyan-700",
    accent: "bg-teal-500",
    accentText: "text-teal-400",
    button: "bg-cyan-800",
    buttonHover: "hover:bg-cyan-700",
    input: "bg-cyan-800",
  },
  forest: {
    name: "forest",
    label: "Forest",
    bg: "bg-emerald-950",
    card: "bg-emerald-900",
    text: "text-emerald-50",
    textMuted: "text-emerald-300",
    border: "border-emerald-700",
    accent: "bg-green-500",
    accentText: "text-green-400",
    button: "bg-emerald-800",
    buttonHover: "hover:bg-emerald-700",
    input: "bg-emerald-800",
  },
  sunset: {
    name: "sunset",
    label: "Sunset",
    bg: "bg-orange-950",
    card: "bg-orange-900",
    text: "text-orange-50",
    textMuted: "text-orange-300",
    border: "border-orange-700",
    accent: "bg-amber-500",
    accentText: "text-amber-400",
    button: "bg-orange-800",
    buttonHover: "hover:bg-orange-700",
    input: "bg-orange-800",
  },
  navy: {
    name: "navy",
    label: "Navy",
    bg: "bg-blue-950",
    card: "bg-blue-900",
    text: "text-blue-50",
    textMuted: "text-blue-300",
    border: "border-blue-700",
    accent: "bg-indigo-500",
    accentText: "text-indigo-400",
    button: "bg-blue-800",
    buttonHover: "hover:bg-blue-700",
    input: "bg-blue-800",
  },
  berry: {
    name: "berry",
    label: "Berry",
    bg: "bg-purple-950",
    card: "bg-purple-900",
    text: "text-purple-50",
    textMuted: "text-purple-300",
    border: "border-purple-700",
    accent: "bg-pink-500",
    accentText: "text-pink-400",
    button: "bg-purple-800",
    buttonHover: "hover:bg-purple-700",
    input: "bg-purple-800",
  },
  lavender: {
    name: "lavender",
    label: "Lavender",
    bg: "bg-violet-950",
    card: "bg-violet-900",
    text: "text-violet-50",
    textMuted: "text-violet-300",
    border: "border-violet-700",
    accent: "bg-fuchsia-500",
    accentText: "text-fuchsia-400",
    button: "bg-violet-800",
    buttonHover: "hover:bg-violet-700",
    input: "bg-violet-800",
  },
  charcoal: {
    name: "charcoal",
    label: "Charcoal",
    bg: "bg-neutral-950",
    card: "bg-neutral-900",
    text: "text-neutral-50",
    textMuted: "text-neutral-400",
    border: "border-neutral-700",
    accent: "bg-stone-500",
    accentText: "text-stone-400",
    button: "bg-neutral-800",
    buttonHover: "hover:bg-neutral-700",
    input: "bg-neutral-800",
  },
  rose: {
    name: "rose",
    label: "Rose",
    bg: "bg-rose-950",
    card: "bg-rose-900",
    text: "text-rose-50",
    textMuted: "text-rose-300",
    border: "border-rose-700",
    accent: "bg-red-500",
    accentText: "text-red-400",
    button: "bg-rose-800",
    buttonHover: "hover:bg-rose-700",
    input: "bg-rose-800",
  },
};

const themeOrder: ThemeName[] = [
  "dark",
  "light",
  "ocean",
  "forest",
  "sunset",
  "navy",
  "berry",
  "lavender",
  "charcoal",
  "rose",
];

export function useTheme() {
  const [currentTheme, setCurrentTheme] = useState<ThemeName>(() => {
    const stored = localStorage.getItem("theme") as ThemeName | null;
    return stored && themes[stored] ? stored : "dark";
  });

  useEffect(() => {
    localStorage.setItem("theme", currentTheme);
  }, [currentTheme]);

  const cycleTheme = useCallback(() => {
    setCurrentTheme((prev) => {
      const currentIndex = themeOrder.indexOf(prev);
      const nextIndex = (currentIndex + 1) % themeOrder.length;
      return themeOrder[nextIndex];
    });
  }, []);

  const theme = themes[currentTheme];

  return { theme, currentTheme, cycleTheme, themes, themeOrder };
}