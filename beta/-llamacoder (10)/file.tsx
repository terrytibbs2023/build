// ==========================================
// PRICING CONFIGURATION - MODIFY THESE VALUES TO CHANGE MARKUP RATES
// ==========================================
export const PRICING_CONFIG = {
  gbpRate: 0.78,           // Change this to update USD→GBP conversion rate
  
  minPriceGbp: 0.20,       // Change this to set minimum price floor
  
  tier1Threshold: 5.00,    // Change this to modify Tier 1 upper limit (currently £5)
  tier2Threshold: 50.00,   // Change this to modify Tier 2 upper limit (currently £50)
  
  tier1Markup: 1.40,       // Change this to modify Tier 1 markup (1.40 = 40%)
  tier2Markup: 1.20,       // Change this to modify Tier 2 markup (1.20 = 20%)
  tier3Markup: 1.10,       // Change this to modify Tier 3 markup (1.10 = 10%)
};