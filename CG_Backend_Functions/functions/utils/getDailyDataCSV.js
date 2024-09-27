const { Parser } = require("json2csv");
const axios = require("axios");

/**
 * Generates a CSV file from the provided data and saves it with today's date as the filename.
 *
 * @param {Array} data - The data to be converted to CSV. It should be an array of objects where each object contains a deviceId and an array of dailydata.
 * @param {Date} today - The date object representing today's date.
 *
 * @example
 * const data = [
 *   {
 *     deviceId: 'device1',
 *     dailydata: [
 *       { EC: 1.2, TDS: 300, pH: 7, timestamp: 1625140800000, waterLevel: 50 },
 *       // ... more daily data
 *     ]
 *   },
 *   // ... more devices
 * ];
 *
 * getCSV(data, new Date());
 */

exports.getCSV = async (data, today) => {
  // Flatten the data for CSV conversion
  const flattenedData = data.flatMap((item) =>
    item.dailydata.map((daily) => ({
      deviceId: item.deviceId,
      TDS: daily.TDS,
      pH: daily.pH,
      timestamp: daily.timestamp,
      waterLevel: daily.waterLevel,
    }))
  );

  // Define fields for CSV
  const fields = ["deviceId", "TDS", "pH", "timestamp", "waterLevel"];
  const opts = { fields };

  try {
    // Convert to CSV
    const parser = new Parser(opts);
    const csv = parser.parse(flattenedData);

    // Format the date as YYYY-MM-DD for the filename
    const formattedDate = today.toISOString().split("T")[0];
    const fileName = `${formattedDate}.csv`;

    // Encode the CSV data in base64 (required by GitHub API)
    const base64Content = Buffer.from(csv).toString('base64');

    const payload = JSON.stringify({
      message: `Add CSV file for ${formattedDate}`, // Commit message
      content: base64Content, // Base64 encoded content
    });

    const config = {
      method: "put",
      url: `https://api.github.com/repos/${process.env.REPO_OWNER}/${process.env.REPO_NAME}/contents/${fileName}`,
      headers: {
        Authorization: `Bearer ${process.env.GITHUB_TOKEN}`,
        "Content-Type": "application/json",
      },
      data: payload,
    };

    const response = await axios(config);
    console.log("File successfully uploaded:", response.data.content.html_url);

  } catch (err) {
    console.error("Error converting JSON to CSV:", err);
  }
};
