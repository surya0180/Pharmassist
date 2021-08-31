/* eslint-disable linebreak-style */
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.chatMessage = functions.firestore
    .document("chatMessages/{bucketId}/messages/{msgId}")
    .onCreate((snapshot, context) => {
      console.log(snapshot.data());
      admin.messaging().sendToDevice(snapshot.data().token, {
        notification: {
          tag: "chat",
          title: snapshot.data().username,
          body: snapshot.data().text,
          bodyLocArgs: JSON.stringify([
            snapshot.data().notificationArgs[2],
            snapshot.data().notificationArgs[3],
            snapshot.data().notificationArgs[1],
            snapshot.data().notificationArgs[0],
            snapshot.data().notificationArgs[4],
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
            // chatData
            snapshot.data().chatData["username"],
            snapshot.data().chatData["uid"],
            snapshot.data().chatData["bucketId"],
            snapshot.data().chatData["participants"][0],
            snapshot.data().chatData["participants"][1],
            snapshot.data().chatData["unreadMessages"],
          ]),
        },
      });
      return;
    });
exports.sendRequestMedic = functions.firestore
    .document("medical requests/{reqId}")
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
            // chatData
            snapshot.data().chatData["username"],
            snapshot.data().chatData["uid"],
            snapshot.data().chatData["bucketId"],
            snapshot.data().chatData["participants"][0],
            snapshot.data().chatData["participants"][1],
            snapshot.data().chatData["unreadMessages"],
          ]),
        },
      });
      return;
    });

exports.feedPosts = functions.firestore
    .document("feed/{feedId}")
    .onCreate((snapshot, context) => {
      console.log(snapshot.data());
      admin.messaging().sendToTopic("feed", {
        notification: {
          tag: "feed",
          title: "New feed posted",
          body: "Title: " + snapshot.data().title,
          bodyLocArgs: JSON.stringify([
            snapshot.data().id,
            snapshot.data().title,
            snapshot.data().content,
            snapshot.data().likes,
            snapshot.data().likedUsers,
            snapshot.data().uid,
          ]),
        },
      });
      return;
    });
