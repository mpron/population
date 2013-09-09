

class CSVReader
  attr_accessor :fname, :headers

  def initialize (filename)
    @fname = filename
  end

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

  def read
    #**'r'**
    f = File.new(@fname, 'r')

    #grab headers
    self.headers = f.readline

    #**Loop over the lines**
    while (!f.eof? && next_line = f.readline)
      values = next_line.split(',')
      hash = create_hash(values)
      yield(hash)
    end
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
