const { firestore } = require('../firebase/firebaseConfig');
const { getCSV } = require('../utils/getDailyDataCSV');
const { aggregator} = require('../utils/dataAggregator');
/**
 * Processes daily sensor data for each device, calculates mean values, deletes the old daily data,
 * and saves the aggregated data back to the Firestore. Also generates a CSV file for the day's data.
 * 
 * @example
 * processDailyData();
 */

exports.processDailyData = async () => {
  // Define the start and end of the current day
    const today = new Date();
    const startOfDay = new Date(today.setHours(0, 0, 0, 0));
    const endOfDay = new Date(today.setHours(23, 59, 59, 999));
    const todaysData = [];
    const devicesRef = firestore.collection('devices'); // Reference to devices collection
  
    try {
      // Fetch all devices
      const snapshot = await devicesRef.get();
  
      if (snapshot.empty) {
        console.log('No devices found.');
        return;
      }
  
      // Process each device's data
    snapshot.forEach(doc => {
        const deviceData = doc.data();
        let sensorData = deviceData.sensorData;
        let deviceDailyData ={}
        deviceDailyData.deviceId= doc.id;

        // Filter daily data for the current day
        const dailydata = sensorData.filter(data =>{
            let timestamp;
            // Handle timestamp object
            if (data.timestamp._seconds !== undefined) {
                console.log(data.timestamp._seconds)
                timestamp = new Date(data.timestamp._seconds * 1000 + data.timestamp._nanoseconds / 1000000);
            } else {
                // Handle timestamp string
                timestamp = new Date(data.timestamp);
            }
            
            return timestamp >= startOfDay && timestamp < endOfDay;
        });
        if(!dailydata){
            return
        }
        deviceDailyData.dailydata=dailydata;
        todaysData.push(deviceDailyData);

         // Aggregate daily data and update sensor data
        const aggregatedData = aggregator(dailydata);
        const prevData = sensorData.filter(item => !dailydata.includes(item));
        prevData.push(aggregatedData)
        firestore.collection('devices').doc(doc.id).update({sensorData:prevData})
      });

      // Generate CSV for today's data
      await getCSV(todaysData, today)

      console.log(`Data Aggregated Sucessfully for ${today}`);
    } catch (error) {
      console.error('Error processing daily data:', error);
    }
  };
  
  