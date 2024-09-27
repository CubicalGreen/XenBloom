const { firestore } = require("../firebase/firebaseConfig");
const { getCSV } = require("../utils/getDailyDataCSV");
const { aggregator } = require("../utils/dataAggregator");
/**
 * Processes daily sensor data for each device, calculates mean values, deletes the old daily data,
 * and saves the aggregated data back to the Firestore. Also generates a CSV file for the day's data.
 *
 * @example
 * processDailyData();
 */

exports.processDailyData = async (req, res) => {
  // Define the start and end of the current day
  const today = new Date();
  const startOfDay = new Date(today);
  startOfDay.setHours(0, 0, 0, 0);
  const endOfDay = new Date(today);
  endOfDay.setHours(23, 59, 59, 999);

  const todaysData = [];
  const devicesRef = firestore.collection("devices");

  try {
    const dailySchedulesSnapshot = await firestore
      .collection("schedules")
      .where("frequency", "==", "daily")
      .where("status", "==", true)
      .get();

    const updatePromises = [];
    dailySchedulesSnapshot.forEach((scheduleDoc) => {
      const scheduleRef = scheduleDoc.ref;
      updatePromises.push(scheduleRef.update({ status: false }));
    });
    await Promise.all(updatePromises);
    console.log("Daily schedules refreshed successfully");

    const snapshot = await devicesRef.get();

    if (snapshot.empty) {
      console.log("No devices found.");
      return;
    }

    snapshot.forEach((doc) => {
      const deviceData = doc.data();
      const sensorData = deviceData.sensorData;
      const deviceDailyData = { deviceId: doc.id };

      const dailydata = sensorData.filter((data) => {
        let timestamp;
        if (data.timestamp) {
          if (data.timestamp._seconds !== undefined) {
            timestamp = new Date(
              data.timestamp._seconds * 1000 +
              data.timestamp._nanoseconds / 1000000
            );
          } else {
            timestamp = new Date(data.timestamp);
          }
          return timestamp >= startOfDay && timestamp <= endOfDay;
        }
        return false;
      });

      if (dailydata.length === 0) {
        console.log("No daily data for device:", doc.id);
        return;
      }

      deviceDailyData.dailydata = dailydata;
      todaysData.push(deviceDailyData);

      const aggregatedData = aggregator(dailydata);
      const prevData = sensorData.filter((item) => !dailydata.includes(item) && item != 0);
      prevData.push(aggregatedData);

      firestore
        .collection("devices")
        .doc(doc.id)
        .update({ sensorData: prevData });
    });

    await getCSV(todaysData, today);
    console.log(`Data Aggregated Successfully for ${today}`);
    return res.status(201).send( `Data Aggregated Successfully for ${today}`)

    
  } catch (error) {
    console.error("Error processing daily data:", error);
    return res.status(501).send("Error processing daily data:", error)
  }
};
