require "jobs/pages_publishing_job"
require "dotenv/load"

desc "Publish pages"
task :publish_pages do
  PagesPublishingJob.new.perform
end
