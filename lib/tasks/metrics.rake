task :metrics, [:url, :depth] => :environment do |task, attributes|
  MetricFactory.create url: attributes[:url], depth: attributes[:depth]
end
