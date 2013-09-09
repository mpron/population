

class CSVReader
  attr_accessor :fname, :headers

  def initialize (filename)
    @fname = filename

  def headers=(str)
    @headers = str.split(',')
    @headers.map! do |x|

      #remove quotes
      x.gsub!('"', '')

      #remove new line
      x.strip!

      #convert to snake case symbol
      x.underscore.to_sym
    end
  end

  def create_hash (values)
    #**need this explained**
    h = {}
    @headers.each_with_index do |header, i|
      value = values[i]strip.gsub('"', '')
      h[header] = value unless value.empty?
    end
    h
  end

end

class String
  def underscore
    #*a little explaination about this... regex?*
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end
