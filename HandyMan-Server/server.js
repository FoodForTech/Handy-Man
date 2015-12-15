'use strict';

var express = require("express");
var mysql = require('mysql');
var bodyParser = require('body-parser');
var app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
	extended: true
}));

var pool = mysql.createPool({
    connectionLimit: 100, //important
    host: 'localhost',
    user: 'root',
    password: 'Donald!1983',
    database: 'HandyMan',
    debug: false
});

function handle_database(req, res, query) {
    
    pool.getConnection(function(err, connection) {
        if (err) {
          connection.release();
          res.json({"code" : 100, "status" : "Error in connection database"});
          return;
        }   

        console.log('connected as id ' + connection.threadId);
        
        connection.query(query, function(err, rows) {
            connection.release();
            if(!err) {
                res.json(rows);
            }           
        });

        connection.on('error', function(err) {      
              res.json({"code" : 100, "status" : "Error in connection database"});
              return;     
        });
  });
}

// authorization end point

app.post("/v1/auth/token", function(req, res) {
	var query = "SELECT id, type, first_name, last_name, email_address FROM User"
	handle_database(req, res, query);
});

// handyDo endpoint

app.get("/v1/handyDo/:user_id", function(req, res) {
	var query = "SELECT id, title, description, status, date_time FROM HandyDo WHERE assign_to_user_id = " + req.params.user_id + " ORDER BY status asc";
   	handle_database(req, res, query);
});

app.post("/v1/handyDo", function(req, res) {
	var query = "INSERT INTO HandyDo (title, description, status, date_time, assignee_user_id, assign_to_user_id) VALUES ('" + req.body.title + "', '" + req.body.description + "', '" + req.body.status + "', NOW(), '1', '2')";																																		
   	handle_database(req, res, query);
});

app.put("/v1/handyDo", function(req, res) {
	var query = "UPDATE HandyDo SET title = '" + req.body.title + "', description = '" + req.body.description + "', status = '" + req.body.status + "' WHERE id = " + req.body.id;
   	handle_database(req, res, query);
});

app.delete("/v1/handyDo/:id", function(req, res) {
	var query = "DELETE FROM HandyDo WHERE id = " + req.params.id;
   	handle_database(req, res, query);
});

// server port listening
var port = 3000;
app.listen(port, function() {
    console.log('Success: Express server now listening on port ' + port);
    console.log('env = ' + app.get('env') +
        '\n__dirname = ' + __dirname  +
        '\nprocess.cwd = ' + process.cwd());
});