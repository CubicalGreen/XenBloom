/**
 * Firebase Configuration
 * Initializes Firestore and other Firebase services.
 */
const firebaseAdmin = require("firebase-admin");

require("dotenv").config();

const firebaseConfig = {
  type: process.env.TYPE,
  project_id: process.env.PROJECT_ID,
  private_key_id: process.env.PRIVATE_KEY_ID,
  private_key: process.env.PRIVATE_KEY, 
  client_email: process.env.CLIENT_EMAIL,
  client_id: process.env.CLIENT_ID,
  auth_uri: process.env.AUTH_URI,
  token_uri: process.env.TOKEN_URI,
  auth_provider_x509_cert_url: process.env.AUTH_PROVIDER_X509_CERT_URL,
  client_x509_cert_url: process.env.CLIENT_X509_CERT_URL,
  universe_domain: process.env.UNIVERSE_DOMAIN
};

// Initialize Firebase Admin SDK
firebaseAdmin.initializeApp({credential: firebaseAdmin.credential.cert(firebaseConfig)}); 

const auth = firebaseAdmin.auth();// Get Firebase Auth instance
const firestore = firebaseAdmin.firestore();// Get Firestore instance
const messaging = firebaseAdmin.messaging();// Get Firebase in-app messaging instance

module.exports = { auth, firestore, messaging};
