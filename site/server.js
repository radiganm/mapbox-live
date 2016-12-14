// server.js for mapbox
//
// Copyright 2016 Mac Radigan
// All Rights Reserved

  var express = require('express'),
      restify = require('restify'),
      cons = require('consolidate'),
      app = express(),
      http = require('http'),
      mongoose = require('mongoose'),
      db = mongoose.connect('mongodb://127.0.0.1/local', {server: {auto_reconnect: true}}),
      Schema = mongoose.Schema,
      server = http.createServer(app),
      io = require('socket.io').listen(server);

  var rest = restify.createServer();

  function respond(req, res, next) {
    res.send('id: ' + req.params.id);
  }

  rest.get('/api/keys/:id', respond);
  rest.head('/api/keys/:id', respond);
  rest.head('/api/show', function(req, res) {
    Criteria.find(function(err, criteria, fres) {
      if(err) return res.sendStatus(500);
      res.send(criteria);
    });
  });

  rest.listen(process.env.LIVE__REST_PORT || 8001, function() {
    console.log('%s listening at %s', rest.name, rest.url);
  });

  app.engine('html', cons.swig);
  app.set('view engine', 'html');
  app.set('views', __dirname + '/views');
  app.use(express.static(__dirname + '/static'));

  var MAPBOX_API_KEY = process.env.LIVE__MAPBOX_API_KEY;

  var criteriaSchema = new Schema({}, {strict: false});
  var Criteria = db.model('Criteria', criteriaSchema);

  app.get('/', function(req, res) {
//  Criteria.find(function(err, criteria, fres) {
//    if(err) return res.sendStatus(500);
      res.render('index', {
        title: 'index',
        editor: 'http://' + req.get('host').split(':')[0] + ':8002',
//      criteria: criteria,
        MAPBOX_API_KEY: MAPBOX_API_KEY
      });
//  });
  });

  app.get('/map', function(req, res) {
    res.render('map.html', {
      title: 'map',
      MAPBOX_API_KEY: MAPBOX_API_KEY
    });
  });

  app.get('/view', function(req, res) {
    res.render('map.html', {
      title: 'map',
      MAPBOX_API_KEY: MAPBOX_API_KEY
    });
  });

  app.get('/list', function(req, res) {
    res.render('list.html', {
      title: 'list',
      editor: 'http://' + req.get('host').split(':')[0] + ':8002',
      MAPBOX_API_KEY: MAPBOX_API_KEY
    });
  });

  var app_listener = app.listen(process.env.LIVE__WEB_PORT || 8000, function() {
    console.log('%s listening at %s', 'app', app_listener.address().port);
  });

// *EOF*
