# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Server.create(name: 'sfdc-deploy1', instance_url: 'https://login.salesforce.com', 
	password: '7Z8{Io28JiG7mvOEFXjXgmSVTauITbliqFC', platform: 'Salesforce.com', 
	repo_name: 'sfdc-deploy1', status: 'available', username: 'squirrel1@deploy.cloudspokes.com',
	languages: 'Apex')

Server.create(name: 'sfdc-deploy2', instance_url: 'https://login.salesforce.com', 
	password: '4$6^46[>hksLTxNUW78MTD8jGXNpjCRr7e', platform: 'Salesforce.com', 
	repo_name: 'sfdc-deploy2', status: 'available', username: 'squirrel2@deploy.cloudspokes.com',
	languages: 'Apex')

Server.create(name: 'sfdc-deploy3', instance_url: 'https://login.salesforce.com', 
	password: '[9%/98U8*iaBnGJj9TFfEjIGb35QoRPnJo', platform: 'Salesforce.com', 
	repo_name: 'sfdc-deploy3', status: 'available', username: 'squirrel3@deploy.cloudspokes.com',
	languages: 'Apex')


Server.create(name: 'java-deploy1', instance_url: 'http://www.heroku.com', 
	password: '[9%/98U8*iaBnGJj9TFfEjIGb35QoRPnJo', platform: 'Heroku', 
	repo_name: 'java-deploy1', status: 'available', username: 'java1@deploy.cloudspokes.com',
	languages: 'Java')

Server.create(name: 'java-deploy1', instance_url: 'http://www.cloudfoundry.com', 
	password: '[9%/98U8*iaBnGJj9TFfEjIGb35QoRPnJo', platform: 'Cloud Foundry', 
	repo_name: 'java-deploy2', status: 'available', username: 'java2@deploy.cloudspokes.com',
	languages: 'Java')