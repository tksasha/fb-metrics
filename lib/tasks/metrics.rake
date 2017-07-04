task :metrics, [:uri, :depth] => :environment do |task, attributes|
  MetricFactory.create uri: attributes[:uri], depth: attributes[:depth]
end
