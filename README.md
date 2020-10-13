##My Implementation:##
Initially, I looked through the CSV's to see what data needed to be imported and what tables could be shared.
I came up with the following structure:
`carriers` which has_many `policies` and has_one `address`
`clients` which `belongs_to` `client_divisions` and has_many `policies` and has_one `address`
`policies` which `belongs_to` `clients` and `carriers` and `policy_types` and `policy_divisions`
`addresses`
`policy_divisions` which has_many `policies`
`client_divisions` which has many `clients`
`policy_types` which has_many `policies`

I wanted to make a shared address table to be able to have all of the address data in one place. I considered doing this for `divisions` or making it a polymorphic table but ultimately went with a simpler structure. If I had more time, I would likely go back and make divisions a polymorphic table called `divisionable` that would be shared between `policies` and `clients`.

After I was done setting up the structure, I added importers for each of the file types: `carriers_importer`, `clients_importer` and `policies_importer` and their corresponding specs. I created these using `CSV.foreach` which can be slow with the amount of records (especially for policies) that exist. If I could change anything, I would use the `active_model_importer` gem to batch the import and make it run more efficiently. I was also not using Rails 6 which if I was, I could have utilized the handy `import_all` ActiveRecord method.

Another thing I would have added is more tests around bad data in the imports. I handled the data issues in the importer but normally I would write tests for each of the issues I found. Things like quotes inside of the csv rows, id's being passed as floats, one of the CSV's had no zipcodes, some states are being passed as abbreviations and some aren't and some of the CSV's have two address fields but put all of the address data into one field so I had to break that out. 

Something I wanted to implement but didn't have enough time to was exporting all of the errors from the imports into a CSV so the user importing the data could have feedback on things that did not import correctly. As of now, there is error logging in the console but that doesn't really help the end user who may not know that their CSV is missing data. That is a feedback loop I would like to make shorter.

I decided to put all of the importers into a rake task for ease of use because it seems like logically these would be imported all together quite often. Something I could have done to make this easier for the person running the import is passing the file names as params to the rake task instead of hard coding them.

For the API endpoints, I added the gem `active_model_serilizers` to serialize the models for simple json rendering and `will_paginate` to add pagination to the nested client policies endpoint. I also added corresponding specs.

##To run locally##
`git clone` the repo
run `bundle install`
run `bundle exec rake db:setup`
run `bundle exec rails s`

##Available endpoints##
`/clients/count_all` returns the count for all of the clients
`/carriers/count_all` returns the count for all of the carriers
`/policies/count_all` returns the count for all of the policies
`/clients/*id*/policies` returns paginated index of all policies for clients

##To run the importer:##
Copy the CSV's to the 'lib/tasks' dir
run `bundle exec rake import import_carriers_clients_policies:import_all`

##To run specs:##
run `bundle exec rspec spec`

