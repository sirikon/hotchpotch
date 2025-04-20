import http from "node:http";

const HOST = "0.0.0.0";
const DEV_PROXY_PORT = parseInt(process.env.DEV_PROXY_PORT);
const SERVER_PORT = parseInt(process.env.SERVER_PORT);
const UI_PORT = parseInt(process.env.UI_PORT);

async function main() {
  startHttpServer(async (req, res) => {
    if (req.url.startsWith("/api/") || req.url === "/api") {
      proxyTo(SERVER_PORT, req, res);
    } else if (req.url.startsWith("/_/") || req.url === "/_") {
      proxyTo(SERVER_PORT, req, res);
    } else {
      proxyTo(UI_PORT, req, res);
    }
  });
}

function startHttpServer(handler) {
  http.createServer(handler).listen(DEV_PROXY_PORT, HOST);
}

function proxyTo(port, req, res) {
  const options = {
    hostname: "127.0.0.1",
    port: port,
    path: req.url,
    method: req.method,
    headers: req.headers,
  };

  const proxyReq = http.request(options, (proxyRes) => {
    res.writeHead(proxyRes.statusCode, proxyRes.headers);
    proxyRes.pipe(res, { end: true });
  });

  proxyReq.on("error", () => {
    res.writeHead(502, { "Content-Type": "text/html" });
    res.end("<h1>502: Proxy request failed</h1>");
  });

  req.pipe(proxyReq, { end: true });
}

await main();
