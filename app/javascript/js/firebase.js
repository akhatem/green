//   // Import the functions you need from the SDKs you need
// import { initializeApp } from "firebase/app";
// import { getAnalytics } from "firebase/analytics";
// import { getMessaging, getToken } from "firebase/messaging";


// // TODO: Add SDKs for Firebase products that you want to use
// // https://firebase.google.com/docs/web/setup#available-libraries

// // Your web app's Firebase configuration
// // For Firebase JS SDK v7.20.0 and later, measurementId is optional
// const firebaseConfig = {
//   apiKey: "AIzaSyAxatUBepBN33j3mtwW78WoH1VdSXW4pr4",
//   authDomain: "green-bbd80.firebaseapp.com",
//   projectId: "green-bbd80",
//   storageBucket: "green-bbd80.appspot.com",
//   messagingSenderId: "620111448956",
//   appId: "1:620111448956:web:5ef05149731c198e8db2f9",
//   measurementId: "G-PBJBTCDWVD"
// };

// // Initialize Firebase
// const app = initializeApp(firebaseConfig);
// const analytics = getAnalytics(app);


// // Add the public key generated from the console here.
// // messaging.getToken({vapidKey: "BBXQdvztBlrlEojILLpv3DN0vNKVv6qe8QibZHvQqCoFR-EGc_uPeP8o9b7EKCy_nsDH8UXIMNckB26hoMtBSUw"});

// // Get registration token. Initially this makes a network call, once retrieved
// // subsequent calls to getToken will return from cache.
// const messaging = getMessaging();
// getToken(messaging, { vapidKey: 'BBXQdvztBlrlEojILLpv3DN0vNKVv6qe8QibZHvQqCoFR-EGc_uPeP8o9b7EKCy_nsDH8UXIMNckB26hoMtBSUw' }).then((currentToken) => {
//   if (currentToken) {
//     // Send the token to your server and update the UI if necessary
//     // ...
//     console.log("Current token")
//   } else {
//     // Show permission request UI
//     console.log('No registration token available. Request permission to generate one.');
//     // ...
//   }
// }).catch((err) => {
//   console.log('An error occurred while retrieving token. ', err);
//   // ...
// });