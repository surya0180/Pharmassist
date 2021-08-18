const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.myFunction = functions.firestore
    .document("Chat/{uid}/messages/{msgId}")
    .onCreate((snapshot, context) => {
      console.log(snapshot.data());
      admin.messaging().sendToDevice(snapshot.data().token, {
        notification: {
          title: snapshot.data().username,
          body: snapshot.data().text,
          bodyLocArgs: JSON.stringify([
            snapshot.data().notificationArgs[0],
            snapshot.data().notificationArgs[1],
          ]),
        },
      });
      return;
    });
exports.sendRequest = functions.firestore
    .document("pharmacist requests/{reqId}")
    .onCreate((snapshot, context) => {
      console.log(snapshot.data());
      admin.messaging().sendToDevice(snapshot.data().token, {
        notification: {
          tag: "request",
          title: snapshot.data().username,
          body: snapshot.data().about,
          bodyLocArgs: JSON.stringify([
            snapshot.data().userId,
            snapshot.data().createdOn,
            snapshot.data().request,
            snapshot.data().PhotoUrl,
          ]),
        },
      });
      return;
    });
