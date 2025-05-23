const http = require("http");

const server = http.createServer((req, res) => {
  console.log(`Received request for ${req.url}`);
  
  if (req.url === "/ping") {
    res.writeHead(200, { "Content-Type": "text/plain" });
    res.end("OK");
  } else {
    res.writeHead(200, { "Content-Type": "text/html" });
    res.end(`
      <html>
        <head>
          <title>BoomBigNose - Railway Deployment</title>
          <style>
            body {
              font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
              max-width: 800px;
              margin: 0 auto;
              padding: 20px;
              line-height: 1.6;
            }
            h1 {
              color: #333;
              border-bottom: 2px solid #eee;
              padding-bottom: 10px;
            }
            .card {
              background: #f9f9f9;
              border-radius: 8px;
              padding: 20px;
              margin-bottom: 20px;
              box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
          </style>
        </head>
        <body>
          <h1>BoomBigNose</h1>
          <div class="card">
            <h2>Railway Deployment Successful!</h2>
            <p>This is a minimal deployment to verify Railway connectivity.</p>
            <p>Environment: Railway</p>
            <p>Time: ${new Date().toISOString()}</p>
          </div>
        </body>
      </html>
    `);
  }
});

const PORT = process.env.PORT || 8000;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
