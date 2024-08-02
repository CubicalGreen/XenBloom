/**
 * Utility function to build alert messages based on device ID and message type
 * @param {string} deviceId - The ID of the device
 * @param {string} message - The type of alert message
 * @returns {Object} alert - The constructed alert message
 */
exports.alertBuilder = (deviceId, message) => {
    var alert = {};
    alert.deviceId = deviceId;
  
    switch (message) {
      case "WaterRefill":
        alert.title = "Water Level: Low";
        alert.message = "Please refill the reservoir.";
        break;
      case "SystemOnline":
        alert.title = "System Status";
        alert.message = "System is Online. All systems are operational.";
        break;
      case "NutrientLevelLow":
        alert.title = "Nutrient Levels: Low";
        alert.message = "Please refill the container.";
        break;
      case "pHLevelLow":
        alert.title = "pH Levels: Low";
        alert.message = "Please refill the container.";
        break;
      default:
        alert.title = "Unknown Alert";
        alert.message = "An unknown alert has occurred.";
        break;
    }
  
    return alert;
  };
  