const mysql = require('mysql');

const params = {
    host: '127.0.0.1',
    user: 'root',
    password: '',
    database: 'practicaMIA',
    multipleStatements: true
};

const mysqlConnection = mysql.createConnection(params);

mysqlConnection.connect(err => {
    if (err) {
        console.error(err);
        return;
    }
    console.log('Database is connected');
});

module.exports = mysqlConnection;