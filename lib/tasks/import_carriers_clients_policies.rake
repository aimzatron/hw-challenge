require_relative "../carrier_importer.rb"
require_relative "../client_importer.rb"
require_relative "../policy_importer.rb"

namespace :import_carriers_clients_policies do
  task :import_all do

    puts "starting Carrier Import..."
    CarrierImporter.import("lib/tasks/Carriers.csv")
    puts "Starting Client Import..."
    ClientImporter.import("lib/tasks/Clients.csv")
    puts "Starting Policy Import..."
    PolicyImporter.import("lib/tasks/Policies.csv")

  end

end
