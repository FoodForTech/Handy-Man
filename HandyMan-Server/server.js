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
   
});

function handleQuery(req, res, query, callback) {
    
    pool.getConnection(function(err, connection) {
        if (err) {
          if (connection) connection.release();
          res.json({"code" : 100, "status" : "Error in connection database"});
          return;
        }   

        console.log("Query: " + query + "\nConnection: " + connection.threadId);
        
        connection.query(query, function(err, rows) {
            if (connection) connection.release();
            console.log(err);
            if(!err) {
                callback(rows);
            }      
        });

        connection.on('error', function(err) {  
            if (connection) connection.release();  
            console.log(err);  
            res.json({"code" : 422, "message" : err});
            return;     
        });
  });
}

// Root path
app.all('/', function(req, res, next) {
    res.send('Handy Man - Helping family achieve more than a simple man can do.');
});

// registration 
app.post("/v1/registration", function(req, res) {
  var query = "INSERT INTO HandyMan.User (type, email_address, password, first_name, last_name, phone_number) VALUES (1, '" + req.body.emailAddress + "', '" + req.body.password + "', '" + req.body.firstName + "', '" + req.body.lastName + "', '" + req.body.phoneNumber + "');";
  handleQuery(req, res, query, function(rows) {
    res.json(rows);
  });
});

// authorization end point

app.post("/v1/auth/token", function(req, res) {
	var query = "SELECT id, type, email_address, first_name, last_name, phone_number FROM User WHERE email_address = '" + req.body.emailAddress + "' and password = '" + req.body.password + "'";
	handleQuery(req, res, query, function(rows) {
    //[{"id":2,"type":2,"email_address":"john@gmail.com","first_name":"John","last_name":"Doe","phone_number":"6301233212"}]

    res.append("BasicAuth", "ABCD1234");

    var userData = rows[0] // there can only be one user
    var user = {
      "id": userData.id,
      "type": userData.type,
      "emailAddress": userData.email_address,
      "firstName": userData.first_name,
      "lastName": userData.last_name,
      "phoneNumber": userData.phone_number
    };

    res.json(user);
  });
});

// handyDo end point

app.get("/v1/handyDo/:user_id/assignee", function(req, res) {
	var query = "SELECT hd.id, title, description, status, date_time, assign_to_user_id, u.first_name, u.last_name FROM HandyDo hd left join User u on hd.assign_to_user_id = u.id WHERE assignee_user_id = " + req.params.user_id + " ORDER BY u.last_name, status asc";
   	handleQuery(req, res, query, function(rows) {
    res.json(rows);
  });
});

app.get("/v1/handyDo/:user_id/assign_to", function(req, res) {
  var query = "SELECT id, title, description, status, date_time, assignee_user_id FROM HandyDo WHERE assign_to_user_id = " + req.params.user_id + " ORDER BY assignee_user_id, status asc";
    handleQuery(req, res, query, function(rows) {
    res.json(rows);
  });
});

app.post("/v1/handyDo", function(req, res) {
	var query = "INSERT INTO HandyDo (title, description, status, date_time, assignee_user_id, assign_to_user_id) VALUES ('" + req.body.title + "', '" + req.body.description + "', '" + req.body.status + "', NOW(), " + req.body.id + ", 2)";																																		
   	handleQuery(req, res, query, function(rows) {
    res.json(rows);
  });
});

app.put("/v1/handyDo", function(req, res) {
	var query = "UPDATE HandyDo SET title = '" + req.body.title + "', description = '" + req.body.description + "', status = '" + req.body.status + "' WHERE id = " + req.body.id;
   	handleQuery(req, res, query, function(rows) {
    res.json(rows);
  });
});

app.delete("/v1/handyDo/:id", function(req, res) {
	var query = "DELETE FROM HandyDo WHERE id = " + req.params.id;
   	handleQuery(req, res, query, function(rows) {
    res.json(rows);
  });
});

// server port listening
var port = 3000;
app.listen(port, function() {
    console.log('Success: Express server now listening on port ' + port);
    console.log('env = ' + app.get('env') +
        '\n__dirname = ' + __dirname  +
        '\nprocess.cwd = ' + process.cwd());
});
