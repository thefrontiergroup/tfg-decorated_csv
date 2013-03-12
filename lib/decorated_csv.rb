# encoding: utf-8
require 'csv'

module DecoratedCSV

  def self.generate(decorator, collection)
    raise NameError, 'CSV_HEADER_ROW is undefined on the decorator' unless decorator.constants.include? :CSV_HEADER_ROW
    raise NoMethodError, '#as_csv_row is undefined on the decorator' unless decorator.instance_methods.include? :as_csv_row
    CSV.generate do |csv|
      csv << decorator::CSV_HEADER_ROW
      collection.each do | row_item |
        csv << decorator.decorate(row_item).as_csv_row
      end
    end
  end

end