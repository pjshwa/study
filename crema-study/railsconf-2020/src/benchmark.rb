require 'benchmark/ips'
require_relative 'config/environment'

ids = Brand.pluck(:id).sample(1000)

# Warming up --------------------------------------
#       where with ids    60.000  i/100ms
#  where with sanitize    87.000  i/100ms
# Calculating -------------------------------------
#       where with ids    625.371  (± 2.1%) i/s -      3.180k in   5.087476s
#  where with sanitize    878.706  (± 4.6%) i/s -      4.437k in   5.063297s

# Comparison:
#  where with sanitize:      878.7 i/s
#       where with ids:      625.4 i/s - 1.41x  (± 0.00) slower

Benchmark.ips do |x|
  x.report("where with ids") do
    Brand.where(id: ids)
  end

  x.report("where with sanitize") do
    Brand.where(ActiveRecord::Base.sanitize_sql(["id in (?)", ids]))
  end

  x.compare!
end

# SELECT `brands`.* FROM `brands`
Brand.all.to_a; nil

# No query executed
Brand.all

# SELECT  `brands`.* FROM `brands` LIMIT 11
# IRB will do this for you.
Brand.all.inspect


# Fixed benchmark!

# Warming up --------------------------------------
#       where with ids     2.000  i/100ms
#  where with sanitize     3.000  i/100ms
# Calculating -------------------------------------
#       where with ids     35.121  (± 8.5%) i/s -    174.000  in   5.005230s
#  where with sanitize     42.088  (± 2.4%) i/s -    213.000  in   5.064063s

# Comparison:
#  where with sanitize:       42.1 i/s
#       where with ids:       35.1 i/s - 1.20x  (± 0.00) slower

Benchmark.ips do |x|
  x.report("where with ids") do
    Brand.where(id: ids).load
  end

  x.report("where with sanitize") do
    Brand.where(ActiveRecord::Base.sanitize_sql(["id in (?)", ids])).load
  end

  x.compare!
end
