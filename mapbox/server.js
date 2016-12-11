// server.js for mapbox
//
// Copyright 2016 Mac Radigan
// All Rights Reserved

  var express = require('express'),
      restify = require('restify'),
      app = express(),
      http = require('http'),
      server = http.createServer(app),
      io = require('socket.io').listen(server);

  var rest = restify.createServer();

  function respond(req, res, next) {
    res.send('id: ' + req.params.id);
  }

  rest.get('/test/:id', respond);
  rest.head('/test/:id', respond);

  rest.listen(process.env.LIVE__REST_PORT || 8888, function() {
    console.log('%s listening at %s', rest.name, rest.url);
  });

// *EOF*
