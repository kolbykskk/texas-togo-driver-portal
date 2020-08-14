namespace :schedule do
    desc 'Perform ExpirationDateWorker'
    task expiration_date_worker: :environment do
        ExpirationDateWorker.perform_async
    end
end
