/**
 * Server Controller
 * Handles the logic for server routes related to device management.
 */

const { FieldValue } = require('firebase-admin/firestore');
const { firestore } = require('../firebase/firebaseConfig');
const { addDevice } = require('../firebase/firebaseServices');

/**
 * Gets device data
 * @param {Request} req - Express request object
 * @param {Response} res - Express response object
 */
exports.getDeviceData = async (req, res) => {
  try {
    const deviceId = req.body.deviceId; // Extract device ID from request body
    if (!deviceId) {
      return res.status(400).json({ Error: 'Invalid request' });
    }
    const deviceDoc = await firestore.collection('devices').doc(deviceId).get(); // Fetch device document
    const deviceData = deviceDoc.data(); // Get device data
    if (deviceDoc.exists) {
      // Check if device is offline
      if (deviceData.status == false) {
        return res.status(400).json({ Error: 'System is Offline. Please check your connection.', deviceData });
      }
      return res.status(200).json(deviceData); // Return device data
    } else {
      console.log('No such device!');
      return res.status(400).json({ Error: 'Device Not Found' });
    }
  } catch (error) {
    console.error('Error fetching device:', error);
    return res.status(500).json({ Error: `Internal Server Error, ${error.message}` });
  }
};

/**
 * Adds sensor data to a device
 * @param {Request} req - Express request object
 * @param {Response} res - Express response object
 */
exports.addSensorData = async (req, res) => {
  try {
    const deviceId = req.body.deviceid; // Extract device ID from request body
    const newSensorData = req.body.sensorData; // Extract sensor data from request body
    if (!deviceId || !newSensorData) {
      return res.status(400).json({ Error: 'Invalid request' });
    }
    newSensorData.timestamp = new Date(); // Add timestamp to sensor data
    const deviceDoc = firestore.collection("devices").doc(deviceId); // Reference to device document
    const deviceData = await deviceDoc.get(); // Fetch device document

    if (deviceData.exists) {
      // Update device sensor data
      await deviceDoc.update({
        sensorData: FieldValue.arrayUnion(newSensorData)
      });
      return res.status(200).json({ message: "New Data Added Successfully" });
    } else {
      console.log("No such device!");
      return res.status(400).json({ Error: "Device Not Found" });
    }
  } catch (error) {
    console.error("Error fetching device:", error);
    return res.status(500).json({ Error: `Internal Server Error, ${error.message}` });
  }
};

/**
 * Changes the default range settings
 * @param {Request} req - Express request object
 * @param {Response} res - Express response object
 */
exports.changeDefault = async (req, res) => {
  const newDefault = req.body; // New default settings from request body
  try {
    const docRef = firestore.collection("settings").doc("default"); // Reference to settings document
    await docRef.update(newDefault); // Update settings

    res.status(200).json({ message: "Default Range updated successfully" });
  } catch (error) {
    console.error("Error updating Ranges:", error);
    res.status(500).json({ error: "Error updating Ranges:" });
  }
};

/**
 * Changes the range settings for a specific device
 * @param {Request} req - Express request object
 * @param {Response} res - Express response object
 */
exports.changeDeviceRange = async (req, res) => {
  const { newRange, deviceId } = req.body; // Extract new range and device ID from request body
  if (!newRange || !deviceId) {
    return res.status(400).json({ Error: "Invalid Request" });
  }
  try {
    const docRef = firestore.collection("devices").doc(deviceId); // Reference to device document
    const deviceData = await docRef.get(); // Fetch device document

    if (deviceData.exists) {
      const settings = firestore.collection("devices").doc(deviceData.data().settings); // Reference to device settings
      await settings.update(newRange); // Update settings
      return res.status(200).json({ message: "Range updated successfully" });
    } else {
      return res.status(400).json({ Error: "Device Not Found" });
    }
  } catch (error) {
    console.error("Error updating Ranges:", error);
    res.status(500).json({ error: "Error updating Ranges:" });
  }
};

/**
 * Adds a new device to the system
 * @param {Request} req - Express request object
 * @param {Response} res - Express response object
 */
exports.addDevice = async (req, res) => {
  const device = req.body; // New device data from request body
  device.sensorData = []; // Initialize sensor data as an empty array
  if (!device) {
    return res.status(400).json({ Error: "Invalid Request" });
  }
  await addDevice(device); // Add device to database
  return res.status(200).json({ message: "Device Added Successfully" });
};

/**
 * Gets settings for a specific device
 * @param {Request} req - Express request object
 * @param {Response} res - Express response object
 */
exports.getSettings = async (req, res) => {
  const { settings } = req.body; // Extract settings ID from request body
  if (!settings) {
    return res.status(400).json({ Error: "Invalid Request" });
  }
  try {
    const settingsDoc = await firestore.collection("settings").doc(settings).get(); // Fetch settings document
    if (settingsDoc.exists) {
      const data = settingsDoc.data(); // Get settings data
      res.status(200).json({ data }); // Return settings data
    } else {
      return res.status(400).json({ Error: "Device Not Found" });
    }
  } catch (error) {
    console.error("Error Getting Settings", error);
    res.status(500).json({ error: "Internal Server" });
  }
};
