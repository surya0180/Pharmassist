const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.myFunction = functions.firestore.document("Chat/{uid}/messages/{msgId}")
    .onCreate((snapshot, context) => {
      console.log(snapshot.data());
      admin.messaging().sendToDevice(snapshot.data().token, {
        notification: {
          title: snapshot.data().username,
          body: snapshot.data().text,
          bodyLocArgs: JSON.stringify([snapshot.data().notificationArgs[0],
            snapshot.data().notificationArgs[1]]),
        },
      });
      return;
    });
