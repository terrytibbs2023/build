// ==========================================
// PRICING CONFIGURATION - MODIFY THESE VALUES TO CHANGE MARKUP RATES
// ==========================================
export const PRICING_CONFIG = {
  // Currency conversion rate (USD to GBP)
  gbpRate: 0.78,

  // Minimum price floor in GBP (no card will be priced below this)
  minPriceGbp: 0.20,

  // Tier 1: Cards under this amount get Tier 1 markup
  tier1Threshold: 5.00, // £5

  // Tier 2: Cards between Tier 1 and this amount get Tier 2 markup
  tier2Threshold: 50.00, // £50

  // Markup multipliers (1.40 = 40% markup, 1.20 = 20% markup, 1.10 = 10% markup)
  tier1Markup: 1.40, // 40% markup for cards under £5
  tier2Markup: 1.20, // 20% markup for cards £5 to £50
  tier3Markup: 1.10, // 10% markup for cards over £50
};
// ==========================================

/**
 * Converts USD price to GBP with tiered markup
 * 
 * MARKUP LOGIC:
 * - Under £5: Adds 40% markup (change tier1Markup above)
 * - £5 to £50: Adds 20% markup (change tier2Markup above)
 * - Over £50: Adds 10% markup (change tier3Markup above)
 * 
 * To modify thresholds:
 * - Change tier1Threshold for the lower boundary (currently £5)
 * - Change tier2Threshold for the upper boundary (currently £50)
 */
export function formatPrice(usd: number, customGbpRate?: number): string {
  const rate = customGbpRate ?? PRICING_CONFIG.gbpRate;
  
  // Convert USD to GBP first
  let gbp = usd * rate;

  // Apply tiered markup based on GBP price
  if (gbp < PRICING_CONFIG.tier1Threshold) {
    // Tier 1: Under £5 - add 40% markup
    gbp = gbp * PRICING_CONFIG.tier1Markup;
  } else if (gbp < PRICING_CONFIG.tier2Threshold) {
    // Tier 2: £5 to £50 - add 20% markup
    gbp = gbp * PRICING_CONFIG.tier2Markup;
  } else {
    // Tier 3: Over £50 - add 10% markup
    gbp = gbp * PRICING_CONFIG.tier3Markup;
  }

  // Apply minimum price floor
  if (gbp < PRICING_CONFIG.minPriceGbp) {
    gbp = PRICING_CONFIG.minPriceGbp;
  }

  return `£${gbp.toFixed(2)}`;
}

/**
 * Gets the markup percentage for display purposes
 */
export function getMarkupPercentage(gbpPrice: number): string {
  if (gbpPrice < PRICING_CONFIG.tier1Threshold) {
    return "40%";
  } else if (gbpPrice < PRICING_CONFIG.tier2Threshold) {
    return "20%";
  } else {
    return "10%";
  }
}

/**
 * Calculates the raw GBP price without markup (for comparison)
 */
export function getBaseGbpPrice(usd: number, customGbpRate?: number): number {
  const rate = customGbpRate ?? PRICING_CONFIG.gbpRate;
  return usd * rate;
}