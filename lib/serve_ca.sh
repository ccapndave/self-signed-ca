#!/usr/bin/env node

const http = require('http');
const fs = require('fs');

const hostname = '0.0.0.0';
const port = 3000;

const cert = fs.readFileSync("./ca.crt");

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/x-x509-ca-cert' });
  res.end(cert, "utf-8");
});

server.listen(port, hostname, () => {
        console.log(`Server running at http://${hostname}:${port}/`);
});