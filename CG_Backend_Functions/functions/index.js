const { onRequest } = require("firebase-functions/v2/https");
const { onSchedule } = require("firebase-functions/v2/scheduler");
const {
  getDeviceData,
  addSensorData,
  changeDefault,
  changeDeviceRange,
  getSettings,
  addDevice,
  addSchedule,
  addUser,
  executeScheduledTasks,
  incPump,
  lightStatus
} = require("./controllers/serverController");
const { sendAlert } = require("./controllers/notificationController");

exports.getDeviceData = onRequest(async (req, res) => {
  await getDeviceData(req, res);
});

exports.lightStatus = onRequest(async (req, res) => {
  await lightStatus(req, res);
});

exports.addSchedule = onRequest(async (req, res) => {
  await addSchedule(req, res);
});

exports.executeScheduledTasks = onSchedule("every 5 minutes", (context) => {
  return executeScheduledTasks();
});

exports.addUser = onRequest(async (req, res) => {
  await addUser(req, res);
});

exports.addSensorData = onRequest(async (req, res) => {
  await addSensorData(req, res);
});

exports.changeDefault = onRequest(async (req, res) => {
  await changeDefault(req, res);
});

exports.changeDeviceRange = onRequest(async (req, res) => {
  await changeDeviceRange(req, res);
});

exports.getSettings = onRequest(async (req, res) => {
  await getSettings(req, res);
});

exports.incPump = onRequest(async (req, res) => {
  await incPump(req, res);
});

exports.addDevice = onRequest(async (req, res) => {
  await addDevice(req, res);
});

exports.sendAlert = onRequest(async (req, res) => {
  await sendAlert(req, res);
});

exports.scheduledProcessDailyData = onSchedule("25 18 * * *", (context) => {
  return processDailyData();
});
