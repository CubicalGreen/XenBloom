const { firestore, messaging} = require('./firebaseConfig');
const {userSchema, deviceSchema} = require("./firebaseModels")

/**
 * Sends a notification to a specified token.
 *
 * @param {string} token - The device token to send the notification to.
 * @param {Object} message - The message object containing the title and body.
 * @param {string} message.title - The title of the notification.
 * @param {string} message.body - The body of the notification.
 * @returns {Promise<string>} - A promise that resolves to the response from the messaging service.
 * @throws {Error} - Throws an error if the notification fails to send.
 */
exports.sendNotification= async (token, message) => {  
  try {
    // Send the notification using the messaging service
    const response = await messaging.send({
      token,
      notification: {
        title: message.title,
        body: message.body,
      },
    });
    console.log('Notification sent successfully: ' + response);
    return response;  // Return the response from the messaging service
  } catch (error) {
    // Throw an error if sending the notification fails
    throw new Error(`Failed to send notification: ${error.message}`);
  }
};


/**
 * Adds an update log to the Firestore database.
 *
 * @param {Object} log - The log object containing update information.
 * @returns {Promise<void>} - A promise that resolves when the log is added.
 * @throws {Error} - Throws an error if the log fails to add.
 */
exports.addUpdateLog = async (log) => {
  try {
    //await logSchema.validate(log);
    // Add the log to the update_log collection in Firestore
    await firestore.collection('update_log').add(log);
    console.log('Log added successfully');
  } catch (error) {
    // Log validation error if it occurs
    console.error('Log validation failed:', error);
  }
};

/**
 * Adds a user to the Firestore database after validating the user data.
 *
 * @param {Object} user - The user object to add.
 * @returns {Promise<void>} - A promise that resolves when the user is added.
 * @throws {Error} - Throws an error if the user validation fails.
 */
exports.addUser = async (user) => {
  try {
    // Validate the user object against the user schema
    await userSchema.validate(user);
    // Add the user to the users collection in Firestore
    await firestore.collection('users').add(user);
    console.log('User added successfully');
  } catch (error) {
    // Log validation error if it occurs
    console.error('User validation failed:', error);
  }
};

/**
 * Adds a device to the Firestore database after validating the device data.
 *
 * @param {Object} device - The device object to add.
 * @returns {Promise<void>} - A promise that resolves when the device is added.
 * @throws {Error} - Throws an error if the device validation fails.
 */
exports.addDevice = async (device) => {
  try {
    // Validate the device object against the device schema
    await deviceSchema.validate(device);
     // Add the device to the devices collection in Firestore
    await firestore.collection('devices').add(device);
    console.log('Device added successfully');
  } catch (error) {
     // Log validation error if it occurs
    console.error('Device validation failed:', error);
  }
};

/**
 * Adds settings data to the Firestore database.
 *
 * @param {Object} data - The settings data to add.
 * @returns {Promise<void>} - A promise that resolves when the settings are added.
 * @throws {Error} - Throws an error if adding settings fails.
 */
exports.addSettings= async (data)=>{
  try {
    // Add the settings data to the settings collection in Firestore
    await firestore.collection('settings').add(data);
    console.log('Device added successfully');
}catch (error) {
  // Log error if adding settings fails
  console.error('Device validation failed:', error);
}};
