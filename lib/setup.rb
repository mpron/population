require_relative 'cvs_reader'
require_relative 'area'

class Setup
  attr_accessor :areas

  def initialize
    @areas = []
    csv = CSVReader.new("./free-zipcode-database.csv")
    
    cvs.read do |item|
      @areas << Area.new(item)
    end

    self
  end

end