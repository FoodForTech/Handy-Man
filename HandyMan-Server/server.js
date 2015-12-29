"use strict";

var express = require("express");
var mysql = require("mysql");
var bodyParser = require("body-parser");
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

        console.log("Query: " + query + "\n Connection: " + connection.threadId);
        
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
	var query = "SELECT id, type, email_address, first_name, last_name, phone_number FROM User WHERE email_address = '" + req.body.emailAddress + "' and password = '" + req.body.password + "'";
	handle_database(req, res, query);
});

// handyDo end point

app.get("/v1/handyDo/:user_id/assignee", function(req, res) {
	var query = "SELECT hd.id, title, description, status, date_time, assign_to_user_id, u.first_name, u.last_name FROM HandyDo hd left join User u on hd.assign_to_user_id = u.id WHERE assignee_user_id = " + req.params.user_id + " ORDER BY u.last_name, status asc";
   	handle_database(req, res, query);
});

app.get("/v1/handyDo/:user_id/assign_to", function(req, res) {
  var query = "SELECT id, title, description, status, date_time, assignee_user_id FROM HandyDo WHERE assign_to_user_id = " + req.params.user_id + " ORDER BY assignee_user_id, status asc";
    handle_database(req, res, query);
});

app.post("/v1/handyDo", function(req, res) {
	var query = "INSERT INTO HandyDo (title, description, status, date_time, assignee_user_id, assign_to_user_id) VALUES ('" + req.body.title + "', '" + req.body.description + "', '" + req.body.status + "', NOW(), " + req.body.id + ", 2)";																																		
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