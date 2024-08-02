const { firestore } = require("../firebase/firebaseConfig");
const {
  sendNotification,
  addUpdateLog,
} = require("../firebase/firebaseServices");
const { alertBuilder } = require('../utils/alertBuilder');

/**
 * Sends an alert notification
 * @param {Request} req - Express request object
 * @param {Response} res - Express response object
 */
exports.sendAlert = async (req, res) => {
  const { deviceId, message } = req.query;  // Extract device ID and message type from request body
  if (!deviceId || !message) {
    return res.status(400).send({ message: "Missing required parameters" });
  };
  try {
    const userSnapshot = await firestore  //Extract User that have same device registered
      .collection("users")
      .where("devices", "array-contains", deviceId)
      .get();  

    if (userSnapshot.empty) {
      return res
        .status(404)
        .json({ message: "User with the specified deviceId not found" });
    }
    const user = userSnapshot.docs[0].data();
    const token = user.fcmToken;   //Extract User's FCM Token
    if (!token) {
      throw new Error("FCM token is missing for the user.");
    }
    const alert = alertBuilder(deviceId, message); // Construct alert message
    await addUpdateLog(alert);  //Add an update log
    await sendNotification(token, alert); // Send notification
    return res.status(200).json({
      message: "Alert sent successfully",
    });
  } catch (error) {
    console.error("Error fetching user data:", error);
    return res.status(500).send({ message: "Internal server error" });
  }
};
