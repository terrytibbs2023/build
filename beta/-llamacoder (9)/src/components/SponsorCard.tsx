import { Theme } from "../hooks/useTheme";

interface SponsorCardProps {
  theme: Theme;
}

const APP_CONFIG = {
  storeUrl: "https://essexconsolerepair.co.uk",
  adTitle: "Essex Console Repair",
  adDescription: "Ps5/Xbox/Switch/Hdmi Ports",
};

export function SponsorCard({ theme }: SponsorCardProps) {
  return (
    <div className="p-4">
      <a
        href={APP_CONFIG.storeUrl}
        target="_blank"
        rel="noopener noreferrer"
        className={`block ${theme.card} rounded-2xl overflow-hidden shadow-md border ${theme.border}`}
      >
        <div className="p-4">
          <span className="text-xs font-bold text-blue-600 uppercase tracking-widest">
            Advertisement
          </span>
          <h3 className={`text-lg font-bold ${theme.text} mt-1`}>
            {APP_CONFIG.adTitle}
          </h3>
          <p className={`text-xs ${theme.textMuted} mt-1`}>
            {APP_CONFIG.adDescription}
          </p>
        </div>
      </a>
    </div>
  );
}