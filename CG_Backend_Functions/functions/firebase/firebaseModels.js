const yup = require("yup");

// User schema
const userSchema = yup.object().shape({
  userId: yup.string().required(),
  fcmToken: yup.string().required(),
  deviceIds: yup
    .array()
    .of(yup.string().required())
    .default(() => []),
});

// Device schema
const sensorDataSchema = yup.object().shape({
  timestamp: yup
    .date()
    .default(() => new Date())
    .required(),
  pH: yup.number().required(),
  waterLevel: yup.number().required(),
  TDS: yup.number().required(),
  EC: yup.number().required(),
});

const deviceSchema = yup.object().shape({
  sensorData: yup.array().of(sensorDataSchema).required(),
});

module.exports = { userSchema, deviceSchema, sensorDataSchema };
