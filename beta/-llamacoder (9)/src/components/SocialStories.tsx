import { useState, useEffect } from "react";
import { Theme } from "../hooks/useTheme";

interface SocialStoriesProps {
  theme: Theme;
}

const APP_CONFIG = {
  bannerImages: [
    "https://images.pokemontcg.io/swsh12pt5/1_hires.png",
    "https://images.pokemontcg.io/swsh12/1_hires.png",
    "https://images.pokemontcg.io/svp/1_hires.png",
  ],
};

const socials = [
  { name: "TikTok", color: "bg-black", icon: "📱", url: "https://www.tiktok.com/@east.coast.collec1" },
  { name: "Facebook", color: "bg-blue-600", icon: "👥", url: "https://www.facebook.com/p/East-Coast-Collectables-61583954579869/" },
  { name: "WhatsApp", color: "bg-green-500", icon: "💬", url: "https://wa.me/447749893611" },
  { name: "Web", color: "bg-slate-700", icon: "🌐", url: "https://share.google/U7aWnYjaMe3HzClcR" },
];

export function SocialStories({ theme }: SocialStoriesProps) {
  const [currentBannerIndex, setCurrentBannerIndex] = useState(0);
  const [opacity, setOpacity] = useState(1);

  useEffect(() => {
    const interval = setInterval(() => {
      setOpacity(0);
      setTimeout(() => {
        setCurrentBannerIndex((prev) => (prev + 1) % APP_CONFIG.bannerImages.length);
        setOpacity(1);
      }, 500);
    }, 8000);

    return () => clearInterval(interval);
  }, []);

  return (
    <>
      <div className="px-4 pt-4">
        <div className={`block w-full aspect-[4/3] ${theme.card} rounded-2xl overflow-hidden shadow-md border ${theme.border} mb-4`}>
          <img
            src={APP_CONFIG.bannerImages[currentBannerIndex]}
            style={{ opacity, transition: "opacity 0.5s ease-in-out" }}
            className="w-full h-full object-cover"
            alt="TCG Featured"
          />
        </div>
      </div>

      <div className="px-2 pb-4 flex justify-around items-center">
        {socials.map((s) => (
          <a
            key={s.name}
            href={s.url}
            target="_blank"
            rel="noopener noreferrer"
            className="flex flex-col items-center gap-1"
          >
            <div className="w-16 h-16 rounded-full p-[2px] bg-gradient-to-tr from-blue-500 to-green-400">
              <div className={`${theme.card} w-full h-full rounded-full p-1`}>
                <div className={`${s.color} w-full h-full rounded-full flex items-center justify-center text-xl shadow-inner`}>
                  {s.icon}
                </div>
              </div>
            </div>
            <span className={`text-xs font-bold ${theme.textMuted} uppercase tracking-tighter`}>
              {s.name}
            </span>
          </a>
        ))}
      </div>
    </>
  );
}