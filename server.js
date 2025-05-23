const http = require("http");

const server = http.createServer((req, res) => {
  console.log(`Received request for ${req.url}`);

  if (req.url === "/ping") {
    res.writeHead(200, { "Content-Type": "text/plain" });
    res.end("OK");
  } else {
    res.writeHead(200, { "Content-Type": "text/html" });
    res.end("<html><body><h1>BoomBigNose</h1><p>Railway deployment successful!</p></body></html>");
  }
});

const PORT = process.env.PORT || 8000;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
