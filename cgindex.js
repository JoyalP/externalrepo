// Require the use of the prom-client by adding it to our variable list:

var express = require('express');
var bodyParser = require('body-parser');
var app = express();
const prom = require('prom-client');

// Enable default metrics scraping

const collectDefaultMetrics = prom.collectDefaultMetrics;
collectDefaultMetrics({ prefix: 'forethought_' });

// Use Express to create the /metrics endpoint and call in the Prometheus data

 app.get('/metrics', function (req, res) {
   res.set('Content-Type', prom.register.contentType);
   res.end(prom.register.metrics());
 });

