export function LoadingSpinner() {
  return (
    <div className="flex flex-col items-center justify-center py-20 text-slate-400">
      <div className="w-10 h-10 border-4 border-slate-200 dark:border-slate-700 border-t-blue-500 rounded-full animate-spin" />
      <p className="mt-4 font-medium">Searching...</p>
    </div>
  );
}