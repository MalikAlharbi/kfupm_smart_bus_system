// const functions = require("firebase-functions");
// const admin = require("firebase-admin");

// // Initialize Firebase Admin SDK
// admin.initializeApp();
// const db = admin.firestore();

// // Constants for delivery configuration
// const MAX_PICKUPS_PER_DAY = 10;
// const START_HOUR = 10; // Start pickup time (10 AM)
// const END_HOUR = 20; // End pickup time (8 PM)
// const DRIVER_NAMES = [
//   "John Smith",
//   "Emily Johnson",
//   "Michael Brown",
//   "Sarah Davis",
//   "James Wilson",
//   "Jessica Garcia",
//   "David Martinez",
//   "Sophia Anderson",
//   "Robert Thomas",
//   "Emma Lee",
// ]; // List of real names for drivers

// function convertToRiyadhTime(date) {
//   const riyadhOffset = 180 * 60 * 1000; // UTC+3 in milliseconds
//   return new Date(date.getTime() + riyadhOffset);
// }

// exports.scheduleDonations = functions.pubsub
//   .schedule("every day 09:00")
//   .timeZone("Asia/Riyadh")
//   .onRun(async (context) => {
//     try {
//       const today = new Date();
//       const todayRiyadh = convertToRiyadhTime(today);
//       todayRiyadh.setHours(0, 0, 0, 0); // Reset time to midnight
//       const todayString = todayRiyadh.toISOString().split("T")[0]; // Format as YYYY-MM-DD

//       console.log(`Fetching pending and postponed DonationBags for today: ${todayString}`);

//       const donationBagsSnapshot = await db
//         .collection("DonationBags")
//         .where("status", "==", "Pending")
//         .get();

//       if (donationBagsSnapshot.empty) {
//         console.log("No pending donations to schedule for today.");
//         return null;
//       }

//       const pendingDonations = [];
//       donationBagsSnapshot.forEach((doc) => {
//         const data = doc.data();

//         if (data.estimated_pickup_time && data.estimated_pickup_time.toDate) {
//           const estimatedPickupTime = convertToRiyadhTime(data.estimated_pickup_time.toDate());
//           const pickupDateString = estimatedPickupTime.toISOString().split("T")[0];

//           // Include postponed donations and those scheduled for today
//           if (pickupDateString === todayString || data.postponed) {
//             pendingDonations.push({ id: doc.id, ...data, estimated_pickup_time: estimatedPickupTime });
//           }
//         } else {
//           console.warn(`Skipping DonationBag ID: ${doc.id} due to missing or invalid estimated_pickup_time.`);
//         }
//       });

//       console.log(`Total donations to schedule for today: ${pendingDonations.length}`);

//       let pickupsAssignedToday = 0;
//       const batch = db.batch();

//       for (const donation of pendingDonations) {
//         console.log(`Processing DonationBag ID: ${donation.id}`);

//         if (pickupsAssignedToday >= MAX_PICKUPS_PER_DAY) {
//           console.log(`Daily limit reached. Marking DonationBag ID: ${donation.id} as postponed.`);
//           batch.update(db.collection("DonationBags").doc(donation.id), {
//             postponed: true,
//             updated_at: new Date().toISOString(),
//           });
//           continue;
//         }

//         const scheduledPickupTime = new Date(todayRiyadh);
//         scheduledPickupTime.setHours(
//           START_HOUR + pickupsAssignedToday,
//           0,
//           0,
//           0
//         );

//         // Add an estimated delivery time (1 or 2 days after pickup)
//         const estimatedDeliveryTime = new Date(scheduledPickupTime);
//         estimatedDeliveryTime.setDate(estimatedDeliveryTime.getDate() + Math.floor(Math.random() * 2) + 1);

//         batch.update(db.collection("DonationBags").doc(donation.id), {
//           scheduled_pickup_time: scheduledPickupTime.toISOString(),
//           postponed: false, // Reset postponed flag
//           estimated_delivery_time: estimatedDeliveryTime.toISOString(),
//           updated_at: new Date().toISOString(),
//           last_scheduled_at: new Date().toISOString(),
//         });

//         console.log(
//           `DonationBag ID: ${donation.id} scheduled at ${scheduledPickupTime.toISOString()} with estimated delivery at ${estimatedDeliveryTime.toISOString()}`
//         );

//         pickupsAssignedToday++;
//       }

//       console.log(`Committing batch update for scheduled donations...`);
//       await batch.commit();
//       console.log("Scheduling complete.");
//       return null;
//     } catch (error) {
//       console.error("Error scheduling donations:", error);
//       throw new functions.https.HttpsError(
//         "internal",
//         "Failed to schedule donations."
//       );
//     }
//   });

// exports.updateInTransitStatus = functions.pubsub
//   .schedule("every 1 minutes")
//   .timeZone("Asia/Riyadh")
//   .onRun(async (context) => {
//     try {
//       console.log("Checking for donations ready for pickup...");

//       const now = new Date();
//       const nowRiyadh = convertToRiyadhTime(now);
//       const nowISOString = nowRiyadh.toISOString();

//       console.log(`Current Riyadh time: ${nowRiyadh.toISOString()}`);

//       const donationBagsSnapshot = await db
//         .collection("DonationBags")
//         .where("status", "==", "Pending")
//         .where("scheduled_pickup_time", "<=", nowISOString)
//         .get();

//       if (donationBagsSnapshot.empty) {
//         console.log("No donations ready for pickup.");
//         return null;
//       }

//       const batch = db.batch();
//       console.log(`Donations ready for pickup: ${donationBagsSnapshot.size}`);

//       donationBagsSnapshot.forEach((doc) => {
//         const trackingNumber = `TRK${Math.floor(100000 + Math.random() * 900000)}`; // Generate a random 6-digit tracking number
//         const driverName = DRIVER_NAMES[Math.floor(Math.random() * DRIVER_NAMES.length)]; // Random driver name

//         // Retrieve scheduled pickup time to calculate estimated delivery
//         const scheduledPickupTime = new Date(doc.data().scheduled_pickup_time);
//         const estimatedDeliveryTime = new Date(scheduledPickupTime);
//         estimatedDeliveryTime.setDate(estimatedDeliveryTime.getDate() + Math.floor(Math.random() * 2) + 1);

//         console.log(
//           `Updating DonationBag ID: ${doc.id} to InTransit with tracking number: ${trackingNumber}, driver: ${driverName}, estimated delivery: ${estimatedDeliveryTime.toISOString()}`
//         );

//         batch.update(db.collection("DonationBags").doc(doc.id), {
//           status: "InTransit",
//           tracking_number: trackingNumber,
//           driver_name: driverName,
//           estimated_delivery_time: estimatedDeliveryTime.toISOString(),
//           updated_at: new Date().toISOString(),
//         });
//       });

//       console.log("Committing batch update for donations ready for pickup...");
//       await batch.commit();
//       console.log("Update complete.");
//       return null;
//     } catch (error) {
//       console.error("Error updating donations to InTransit:", error);
//       throw new functions.https.HttpsError(
//         "internal",
//         "Failed to update donations to InTransit."
//       );
//     }
//   });

// exports.updateToInStorageStatus = functions.pubsub
//   .schedule("every day 22:00")
//   .timeZone("Asia/Riyadh")
//   .onRun(async (context) => {
//     try {
//       console.log("Checking for donations ready to be marked as InStorage...");

//       const now = new Date();
//       const nowRiyadh = convertToRiyadhTime(now);
//       const nowISOString = nowRiyadh.toISOString();

//       console.log(`Current Riyadh time: ${nowISOString}`);

//       // Query for donation bags with status 'InTransit' and past estimated_delivery_time
//       const donationBagsSnapshot = await db
//         .collection("DonationBags")
//         .where("status", "==", "InTransit")
//         .where("estimated_delivery_time", "<=", nowISOString)
//         .get();

//       if (donationBagsSnapshot.empty) {
//         console.log("No donations to update to InStorage.");
//         return null;
//       }

//       console.log(`Donations ready to be marked as InStorage: ${donationBagsSnapshot.size}`);

//       const batch = db.batch();

//       donationBagsSnapshot.forEach((doc) => {
//         console.log(`Updating DonationBag ID: ${doc.id} to InStorage`);

//         batch.update(db.collection("DonationBags").doc(doc.id), {
//           status: "InStorage",
//           updated_at: new Date().toISOString(),
//         });
//       });

//       console.log("Committing batch update for donations marked as InStorage...");
//       await batch.commit();
//       console.log("Update complete.");
//       return null;
//     } catch (error) {
//       console.error("Error updating donations to InStorage:", error);
//       throw new functions.https.HttpsError(
//         "internal",
//         "Failed to update donations to InStorage."
//       );
//     }
//   });




//   const functions = require("firebase-functions");
// const admin = require("firebase-admin");

// // Initialize Firebase Admin SDK
// admin.initializeApp();
// const db = admin.firestore();

// // Constants for order configuration
// const MAX_ORDERS_PER_DAY = 10;
// const START_HOUR = 10; // Start pickup time (10 AM)
// const END_HOUR = 20; // End pickup time (8 PM)
// const DRIVER_NAMES = [
//   "John Smith",
//   "Emily Johnson",
//   "Michael Brown",
//   "Sarah Davis",
//   "James Wilson",
//   "Jessica Garcia",
//   "David Martinez",
//   "Sophia Anderson",
//   "Robert Thomas",
//   "Emma Lee",
// ]; // List of real names for drivers

// function convertToRiyadhTime(date) {
//   const riyadhOffset = 180 * 60 * 1000; // UTC+3 in milliseconds
//   return new Date(date.getTime() + riyadhOffset);
// }

// // Schedule Fulfilled Orders Function
// exports.scheduleFulfilledOrders = functions.pubsub
//   .schedule("every day 09:00")
//   .timeZone("Asia/Riyadh")
//   .onRun(async (context) => {
//     try {
//       const today = new Date();
//       const todayRiyadh = convertToRiyadhTime(today);
//       todayRiyadh.setHours(0, 0, 0, 0); // Reset time to midnight
//       const todayString = todayRiyadh.toISOString().split("T")[0]; // Format as YYYY-MM-DD

//       console.log(`Fetching fulfilled orders for today: ${todayString}`);

//       const ordersSnapshot = await db
//         .collection("Orders")
//         .where("status", "==", "InStorage")
//         .where("pickup_date", "==", todayString)
//         .get();

//       if (ordersSnapshot.empty) {
//         console.log("No orders to schedule for today.");
//         return null;
//       }

//       const ordersToSchedule = [];
//       ordersSnapshot.forEach((doc) => {
//         ordersToSchedule.push({ id: doc.id, ...doc.data() });
//       });

//       console.log(`Total orders to schedule for today: ${ordersToSchedule.length}`);

//       let ordersAssignedToday = 0;
//       const batch = db.batch();

//       for (const order of ordersToSchedule) {
//         console.log(`Processing Order ID: ${order.id}`);

//         if (ordersAssignedToday >= MAX_ORDERS_PER_DAY) {
//           console.log(`Daily limit reached. Postponing Order ID: ${order.id}`);
//           const nextPickupDate = new Date(todayRiyadh);
//           nextPickupDate.setDate(nextPickupDate.getDate() + 1);
//           const nextPickupDateString = nextPickupDate.toISOString().split("T")[0];

//           batch.update(db.collection("Orders").doc(order.id), {
//             pickup_date: nextPickupDateString,
//             updated_at: new Date().toISOString(),
//           });
//           continue;
//         }

//         const scheduledPickupTime = new Date(todayRiyadh);
//         scheduledPickupTime.setHours(
//           START_HOUR + ordersAssignedToday,
//           0,
//           0,
//           0
//         );

//         batch.update(db.collection("Orders").doc(order.id), {
//           scheduled_pickup_time: scheduledPickupTime.toISOString(),
//           updated_at: new Date().toISOString(),
//         });

//         console.log(
//           `Order ID: ${order.id} scheduled at ${scheduledPickupTime.toISOString()}`
//         );

//         ordersAssignedToday++;
//       }

//       console.log(`Committing batch update for scheduled orders...`);
//       await batch.commit();
//       console.log("Scheduling complete.");
//       return null;
//     } catch (error) {
//       console.error("Error scheduling orders:", error);
//       throw new functions.https.HttpsError(
//         "internal",
//         "Failed to schedule orders."
//       );
//     }
//   });

// // Update Orders to InTransit Function
// exports.updateOrdersToInTransit = functions.pubsub
//   .schedule("every 1 minutes")
//   .timeZone("Asia/Riyadh")
//   .onRun(async (context) => {
//     try {
//       console.log("Checking for orders ready for pickup...");

//       const now = new Date();
//       const nowRiyadh = convertToRiyadhTime(now);
//       const nowISOString = nowRiyadh.toISOString();

//       console.log(`Current Riyadh time: ${nowRiyadh.toISOString()}`);

//       const ordersSnapshot = await db
//         .collection("Orders")
//         .where("status", "==", "InStorage")
//         .where("scheduled_pickup_time", "<=", nowISOString)
//         .get();

//       if (ordersSnapshot.empty) {
//         console.log("No orders ready for pickup.");
//         return null;
//       }

//       const batch = db.batch();
//       console.log(`Orders ready for pickup: ${ordersSnapshot.size}`);

//       ordersSnapshot.forEach((doc) => {
//         const trackingNumber = `TRK${Math.floor(100000 + Math.random() * 900000)}`; // Generate a random 6-digit tracking number
//         const driverName = DRIVER_NAMES[Math.floor(Math.random() * DRIVER_NAMES.length)]; // Random driver name

//         console.log(
//           `Updating Order ID: ${doc.id} to InTransit with tracking number: ${trackingNumber}, driver: ${driverName}`
//         );

//         batch.update(db.collection("Orders").doc(doc.id), {
//           status: "InTransit",
//           tracking_number: trackingNumber,
//           driver_name: driverName,
//           updated_at: new Date().toISOString(),
//         });
//       });

//       console.log("Committing batch update for orders ready for pickup...");
//       await batch.commit();
//       console.log("Update complete.");
//       return null;
//     } catch (error) {
//       console.error("Error updating orders to InTransit:", error);
//       throw new functions.https.HttpsError(
//         "internal",
//         "Failed to update orders to InTransit."
//       );
//     }
//   });

// // Update Orders to Delivered Function
// exports.updateOrdersToDelivered = functions.pubsub
//   .schedule("every day 23:00")
//   .timeZone("Asia/Riyadh")
//   .onRun(async (context) => {
//     try {
//       console.log("Checking for orders to be marked as Delivered...");

//       const now = new Date();
//       const nowRiyadh = convertToRiyadhTime(now);
//       const nowISOString = nowRiyadh.toISOString();

//       console.log(`Current Riyadh time: ${nowISOString}`);

//       // Query for orders with status 'InTransit'
//       const ordersSnapshot = await db
//         .collection("Orders")
//         .where("status", "==", "InTransit")
//         .get();

//       if (ordersSnapshot.empty) {
//         console.log("No orders to update to Delivered.");
//         return null;
//       }

//       console.log(`Orders ready to be marked as Delivered: ${ordersSnapshot.size}`);

//       const batch = db.batch();

//       ordersSnapshot.forEach((doc) => {
//         console.log(`Updating Order ID: ${doc.id} to Delivered`);

//         batch.update(db.collection("Orders").doc(doc.id), {
//           status: "Delivered",
//           updated_at: new Date().toISOString(),
//         });
//       });

//       console.log("Committing batch update for orders marked as Delivered...");
//       await batch.commit();
//       console.log("Update complete.");
//       return null;
//     } catch (error) {
//       console.error("Error updating orders to Delivered:", error);
//       throw new functions.https.HttpsError(
//         "internal",
//         "Failed to update orders to Delivered."
//       );
//     }
//   });
