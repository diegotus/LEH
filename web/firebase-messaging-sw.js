importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");


firebase.initializeApp(
    {
        apiKey: 'AIzaSyBsChBk8QJZPPNMgr_k9fuxPEogqLXtDA0',
        appId: '1:883573169106:web:e333e530119d71f981c60b',
        messagingSenderId: '883573169106',
        projectId: 'lotterie-de-l-etat-haitien',
        authDomain: 'lotterie-de-l-etat-haitien.firebaseapp.com',
        storageBucket: 'lotterie-de-l-etat-haitien.firebasestorage.app',
        measurementId: 'G-N56EK36JQ2',
    }
);

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    console.log("new notificaiton", payload)
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});