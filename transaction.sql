mysql> create database bank;
Query OK, 1 row affected (0.01 sec)

mysql> use bank;
Database changed

mysql> CREATE TABLE accounts
    -> (
    -> id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    -> account_no INT,
    -> balance INT
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (1.14 sec)

mysql> INSERT INTO accounts
    -> VALUES (NULL, 1, 0),
    -> (NULL, 2, 0);
Query OK, 2 rows affected (0.11 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> CREATE TABLE users
    -> (
    -> id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    -> name VARCHAR(20),
    -> email VARCHAR(50),
    -> account_no INT
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (1.18 sec)

mysql> INSERT INTO users
    -> VALUES (NULL, 'userA', 'userA@gmail.com', 1),
    -> (NULL, 'userB', 'userB@gmail.com', 2);
Query OK, 2 rows affected (0.70 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
Query OK, 0 rows affected (0.00 sec)

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE accounts
    -> SET balance=balance+1000
    -> WHERE account_no=
    -> (
    -> SELECT account_no
    -> FROM users
    -> WHERE name='userA'
    -> );
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  2 |          1 |    1000 |
|  3 |          2 |       0 |
+----+------------+---------+
2 rows in set (0.00 sec)

mysql> UPDATE accounts
    -> SET balance=balance-500
    -> WHERE account_no=
    -> (
    -> SELECT account_no
    -> FROM users
    -> where name='userA'
    -> );
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM accounts;                                                 +----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  2 |          1 |     500 |
|  3 |          2 |       0 |
+----+------------+---------+
2 rows in set (0.00 sec)

mysql> UPDATE accounts
    -> SET balance=balance-200
    -> WHERE account_no=
    -> (
    -> SELECT account_no
    -> FROM users
    -> WHERE name='userA'
    -> );
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0


mysql> SELECT * FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  2 |          1 |     300 |
|  3 |          2 |       0 |
+----+------------+---------+
2 rows in set (0.00 sec)


mysql> UPDATE accounts
    -> SET balance=balance+200
    -> WHERE account_no=
    -> (
    -> SELECT account_no
    -> FROM users
    -> WHERE name='userB'
    -> );
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM accounts;
+----+------------+---------+
| id | account_no | balance |
+----+------------+---------+
|  2 |          1 |     300 |
|  3 |          2 |     200 |
+----+------------+---------+
2 rows in set (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.39 sec)

