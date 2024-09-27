/**
 * Aggregates sensor data by calculating mean values for EC, TDS, pH, and water level.
 * 
 * @param {Array} data - The array of sensor data entries to be aggregated.
 * @returns {Object} - An object containing the mean values of the sensor data.
 * 
 * @example
 * const aggregatedData = aggregator(dailydata);
 */

exports.aggregator = (data) => {
  if (data.length === 0) return 0; // Return 0 if there are no value
let sumTDS = 0;
let sumPH = 0;
let sumWaterLevel = 0;
let count = data.length;

// Loop through the data to calculate sums
data.forEach(entry => {
  sumTDS += entry.TDS;
  sumPH += entry.pH;
  sumWaterLevel += entry.waterLevel;
});

// Calculate mean values
const meanValues = {
  TDS: sumTDS / count,
  pH: sumPH / count,
  waterLevel: sumWaterLevel / count,
  timestamp: new Date()
};

return meanValues;
}
 
