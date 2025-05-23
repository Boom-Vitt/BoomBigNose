const http = require("http");

// Create a simple HTTP server
const server = http.createServer((req, res) => {
  console.log(`Received request for: ${req.url}`);

  // Handle ping endpoint for health checks
  if (req.url === "/ping") {
    console.log("Responding to /ping with OK");
    res.writeHead(200, { "Content-Type": "text/plain" });
    res.end("OK");
    return;
  }

  // Handle root endpoint
  console.log("Responding to / with HTML");
  res.writeHead(200, { "Content-Type": "text/html" });
  res.end("<html><body><h1>BoomBigNose</h1><p>Railway deployment successful!</p></body></html>");
});

// Start the server
const PORT = process.env.PORT || 8000;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`Health check endpoint available at: http://localhost:${PORT}/ping`);
});
