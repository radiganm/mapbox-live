// server.js for mapbox
//
// Copyright 2016 Mac Radigan
// All Rights Reserved

  var express = require('express'),
      restify = require('restify'),
      cons = require('consolidate'),
      app = express(),
      http = require('http'),
      server = http.createServer(app),
      io = require('socket.io').listen(server);

  var rest = restify.createServer();

  function respond(req, res, next) {
    res.send('id: ' + req.params.id);
  }

  rest.get('/api/keys/:id', respond);
  rest.head('/api/keys/:id', respond);

  rest.listen(process.env.LIVE__REST_PORT || 8001, function() {
    console.log('%s listening at %s', rest.name, rest.url);
  });

  app.engine('html', cons.swig);
  app.set('view engine', 'html');
  app.set('views', __dirname + '/views');

  var MAPBOX_API_KEY = process.env.LIVE__MAPBOX_API_KEY;

  app.get('/', function(req, res) {
    res.render('index', {
      title: 'index',
      MAPBOX_API_KEY: MAPBOX_API_KEY
    });
  });

  app.get('/map', function(req, res) {
    res.render('map', {
      title: 'map',
      MAPBOX_API_KEY: MAPBOX_API_KEY
    });
  });

  var app_listener = app.listen(process.env.LIVE__WEB_PORT || 8000, function() {
    console.log('%s listening at %s', 'app', app_listener.address().port);
  });

// *EOF*
