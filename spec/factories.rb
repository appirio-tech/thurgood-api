FactoryGirl.define do

  factory :server do
    sequence(:name) { |n| "server#{n}" }
    instance_url 'https://login.salesforce.com'
    password 'password1'
    platform 'salesforce.com'
    repo_name 'server1'
    status 'available'
    languages 'apex'
    username 'server1'
  end

  factory :api_key do
    description 'testing'
  end

  factory :logger_account do
    name 'test-rails1'
    email 'test-rails@cloudspokes.com'

    factory :account_with_unique_email do
      email "test-rails#{Random.rand(100)}@cloudspokes.com"
    end
  end

  factory :logger_system do
    name 'system1'
    papertrail_id 'testsystem1'
    logger_account
  end 

  factory :job do
    email 'jeff@cloudspokes.com'
    language 'apex'
    platform 'salesforce.com'
  end 

end