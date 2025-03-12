import 'dart:html';

void callServiceWorkerFunction(String topic) {
  //  html.window.navigator.serviceWorker?.getRegistrations().then((registrations) {
  //   for (final registration in registrations) {
  //     print("the registration ${registration.active.postMessage}");
  //   }
  // });

  if (window.navigator.serviceWorker != null) {
    final controller = window.navigator.serviceWorker!.controller;
    // Ensure the Service Worker controller is active
    if (controller != null) {
      // Create a MessageChannel for two-way communication
      final messageChannel = MessageChannel();
      print("the controller ${controller.state}");

      // Listen for a response from the Service Worker
      messageChannel.port1.onMessage.listen((event) {
        print('Response from Service Worker: ${event.data}');
      });

      // Send a message to the Service Worker
      controller.postMessage({
        'type': 'subscribeToTopic',
        'topic': topic,
      }, [
        messageChannel.port2
      ]);
    } else {
      print(
          'No active Service Worker controller found. Ensure it is properly registered.');
    }
  } else {
    print('Service Worker not supported in this browser.');
  }
}
