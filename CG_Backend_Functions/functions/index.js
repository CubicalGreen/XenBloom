const functions = require("firebase-functions");
const {
  getDeviceData,
  addSensorData,
  changeDefault,
  changeDeviceRange,
  getSettings,
  addDevice,
} = require("./controllers/serverController");
const { sendAlert } = require("./controllers/notificationController");

exports.getDeviceData = functions.https.onRequest(async (req, res) => {
  await getDeviceData(req, res);
});

exports.addSensorData = functions.https.onRequest(async (req, res) => {
  await addSensorData(req, res);
});

exports.changeDefault = functions.https.onRequest(async (req, res) => {
  await changeDefault(req, res);
});

exports.changeDeviceRange = functions.https.onRequest(async (req, res) => {
  await changeDeviceRange(req, res);
});

exports.getSettings = functions.https.onRequest(async (req, res) => {
  await getSettings(req, res);
});

exports.addDevice = functions.https.onRequest(async (req, res) => {
  await addDevice(req, res);
});

exports.sendAlert = functions.https.onRequest(async (req, res) => {
  await sendAlert(req, res);
});

exports.scheduledProcessDailyData = functions.pubsub.schedule('55 23 * * *').onRun((context) => {
    return processDailyData();
  });