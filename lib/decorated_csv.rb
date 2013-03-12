# encoding: utf-8
require 'csv'

module DecoratedCSV

  def self.generate(decorator_class, collection)
    raise NameError, 'CSV_HEADER_ROW is undefined on the decorator class' unless decorator_class.constants.include? :CSV_HEADER_ROW
    raise NoMethodError, '#as_csv_row is undefined on the decorator class' unless decorator_class.instance_methods.include? :as_csv_row
    CSV.generate do |csv|
      csv << decorator_class::CSV_HEADER_ROW
      collection.each do | row_item |
        csv << decorator_class.decorate(row_item).as_csv_row
      end
    end
  end

end