// Import Firebase modules
import { initializeApp } from "firebase/app";
import {  getFirestore, } from "firebase/firestore";
import { getAuth } from "firebase/auth";
import { getStorage } from "firebase/storage";

// Firebase configuration from your Firebase console
const firebaseConfig = {
  apiKey: "AIzaSyCDdsVMPbDJmE2BhdOHbh1cFnD4XrOzlIk",
  authDomain: "kfupm-smart-bus.firebaseapp.com",
  databaseURL: "https://kfupm-smart-bus-default-rtdb.europe-west1.firebasedatabase.app",
  projectId: "kfupm-smart-bus",
  storageBucket: "kfupm-smart-bus.firebasestorage.app",
  messagingSenderId: "949319058910",
  appId: "1:949319058910:web:f1ca1f36d78bc2d5c7894f"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Export Firebase services for use in your app
export const db = getFirestore(app);
export const auth = getAuth(app);
export const storage = getStorage(app);

