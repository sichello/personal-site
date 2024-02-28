  document.addEventListener('DOMContentLoaded', () => {
    // Function to make the PUT request
    const updateVisitorsCount = async () => {
      try {
        const response = await fetch('https://api.sichello.com/visitors', {
          method: 'POST'
        });

        const data = await response.json();
        const count = data.count.N;

        // Update the DOM with the count
        document.getElementById('visitorsCount').innerText = `You are visitor number ${count} to my site. Thanks for stopping by.`;
    } catch (error) {
        console.error('Error updating visitors count:', error);
      }
    };

    // Call the function on page load
    updateVisitorsCount();
  });