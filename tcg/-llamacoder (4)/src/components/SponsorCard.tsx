import { APP_CONFIG } from '../utils/constants';

export function SponsorCard() {
  return (
    <div className="p-4">
      <a
        href={APP_CONFIG.storeUrl}
        target="_blank"
        rel="noopener noreferrer"
        className="block bg-white dark:bg-slate-800 rounded-2xl overflow-hidden shadow-md border border-slate-100 dark:border-slate-700"
      >
        <div className="bg-slate-100 dark:bg-slate-700 h-40 flex items-center justify-center p-4">
          <img
            src={APP_CONFIG.logoUrl}
            alt="Sponsor"
            className="max-w-[80%] max-h-[80%] object-contain"
          />
        </div>
        <div className="p-4 border-t border-slate-100 dark:border-slate-700">
          <span className="text-xs font-bold text-blue-600 dark:text-blue-400 uppercase tracking-wider">
            Official Sponsor
          </span>
          <h3 className="text-lg font-bold text-slate-900 dark:text-white mt-1">
            {APP_CONFIG.adTitle}
          </h3>
          <p className="text-sm text-slate-500 dark:text-slate-400 mt-1">
            {APP_CONFIG.adDescription}
          </p>
        </div>
      </a>
    </div>
  );
}