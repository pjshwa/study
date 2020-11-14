# Prerequisite: graphviz

require_relative 'config/environment'

ids = Brand.pluck(:id).sample(5)

relation_no_sanitize = Brand.where(id: ids)
File.binwrite 'no_sanitize.dot', relation_no_sanitize.arel.to_dot
`dot -Tpng -o no_sanitize.png no_sanitize.dot`

relation_sanitize = Brand.where(ActiveRecord::Base.sanitize_sql(["id in (?)", ids]))
File.binwrite 'sanitize.dot', relation_sanitize.arel.to_dot
`dot -Tpng -o sanitize.png sanitize.dot`
