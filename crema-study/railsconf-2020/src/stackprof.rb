require 'stackprof'
require_relative 'config/environment'

ids = Brand.pluck(:id).sample(1000)

StackProf.run(mode: :wall, out: "no_sanitize.dump") do |x|
  200.times do
    Brand.where(id: ids).load
  end
end

StackProf.run(mode: :wall, out: "sanitize.dump") do |x|
  200.times do
    Brand.where(ActiveRecord::Base.sanitize_sql(["id in (?)", ids])).load
  end
end
