# desc "Explaining what the task does"
# task :enju_purchase_request do
#   # Task goes here
# end
namespace :enju_purchase_request do
  desc "upgrade enju_purchase_request"
  task :upgrade => :environment do
    Rake::Task['statesman:backfill_most_recent'].invoke('OrderList')
    puts 'enju_purchase_request: The upgrade completed successfully.'
  end
end

