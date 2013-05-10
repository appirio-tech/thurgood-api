The Thurgood API...

## Quick Start



return codes:

200 - OK
404 - Not Found - The given resource could not be found.
401 - Unauthorized
400 Bad Request - The given request was not as expected.
500 Internal server error

304 - Not Modified ???

Include the Papertrail docs 

Job

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"job": {"code_url": "http://www.cloudspokes.com/code.zip", "language": "Apex", "platform": "Salesforce.com", "email": "jeff@cloudspokes.com", "user_id": "jeffdonthemic"}}'  http://localhost:3000/v1/jobs

Logger Account

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"account": {"name": "jeffdonthemic", "email": "jeff@cloudspokes.com"}}'  http://localhost:3000/v1/loggers/account/create

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"account": {"name": "jeffdonthemic", "email": "jeff@jeffdouglas3.com", "papertrail_id": "123456789"}}'  http://localhost:3000/v1/loggers/account/create

Logger System

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"system": {"name": "mysystem",  "logger_account_id": "4"}}'  http://localhost:3000/v1/loggers/system/create

Delete System

curl -v -X DELETE http://localhost:3000/v1/loggers/system/9f27754db302bf6ae686d46396132a30
