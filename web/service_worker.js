self.addEventListener('subscribeToTopicWeb', (event) => {
    const topic = event.data.topic;
  
    if (topic) {
      console.log(`Subscribing to topic: ${topic}`);
      // Add your subscription logic here (e.g., storing it or notifying a server)
      event.ports[0].postMessage(`Successfully subscribed to topic: ${topic}`);
    } else {
      console.log('No topic specified.');
      event.ports[0].postMessage('Failed: No topic specified.');
    }
  });

  self.addEventListener('message', (event) => {
    const topic = event.data.topic;
  
    if (topic) {
      console.log(`Subscribing to topic message: ${topic}`);
      // Add your subscription logic here (e.g., storing it or notifying a server)
      event.ports[0].postMessage(`Successfully subscribed message to topic: ${topic}`);
    } else {
      console.log('No topic specified.');
      event.ports[0].postMessage('Failed: No topic specified.');
    }
  });
  