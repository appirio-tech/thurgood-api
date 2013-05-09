readme 

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

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"account": {"name": "jeffdonthemic", "email": "jeff@jeffdougals.com"}}'  http://localhost:3000/v1/loggers/account/create

optionally pass a papertrail_id if you want a specific id for the account. when creating a papertrail acccount, the passed id is what makes it uniqui

id isanalphanumericvalueofyourchoosing;aslongasit'suniqueamongaccountsyou'vecreated,theIDvalueisuptoyou.Inatypical Web service where a top-level company includes multiple users, we recommend using your company database ID. If you do not have a company/organization and just have individual users, use the individual user ID. If you have a freeform permissions system, use a new ID created for this purpose (such as a UUID).

name isthehuman-readablenameofthisaccount,typicallyacompanyororganizationname.Avalueisrequired.Spacesandpunctuation are accepted.

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"account": {"name": "jeffdonthemic", "email": "jeff@jeffdouglas3.com", "papertrail_id": "123456789"}}'  http://localhost:3000/v1/loggers/account/create

Logger System

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"system": {"name": "mysystem",  "logger_account_id": "4"}}'  http://localhost:3000/v1/loggers/system/create
