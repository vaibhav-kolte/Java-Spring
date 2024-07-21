My own API
Student CRUD operation API using Spring Boot

Student API
﻿

GET
Get all
http://localhost:8080/student/getAll
﻿

GET
get student
http://localhost:8080/student/6
﻿

POST
add student
http://localhost:8080/student/add
﻿Body
raw (json)
json
{
    "name":"Mahesh",
    "address":"Malkapur"
}


PUT
update student
http://localhost:8080/student/6

Body
raw (json)
json
{
    "id":6,
    "name":"Sharad",
    "address":"Jalgaon"
}


DELETE
delete student
http://localhost:8080/student/7
