class Analytics
  attr_accessor :options

  def initialize (areas)
    @areas = areas
    set_options
  end

  def set_options
    @options = []
    @options << { menu_id: 1, menu_title: 'Areas count', method: :how_many }
    @options << { menu_id: 2, menu_title: 'Smallest Population (non 0)', method: :smallest_pop }
    @options << { menu_id: 3, menu_title: 'Larest Population', method: :largest_pop }
    @options << { menu_id: 4, menu_title: 'How many zips in California?', method: :california_zips }
    @options << { menu_id: 5, menu_title: 'Information for a given zip', method: :zip_info }
    @options << { menu_id: 6, menu_title: 'Exit', method: :exit }
  end

  def run (choice)
    opt = @options.select {|x| x[:menu_id] == choice}.first
    if opt.nil?
      puts "Invalid choice"
    elsif opt[:method] != :exit
      #I got this line below without looking
      self.send opt[:method]
      :done
      #what's the :done for?
    else
      opt[:method]
    end
  end

#1. Areas count
  def how_many
    #I got the @areas.length right.
    p "There are #{@areas.length} areas"
  end

#2. Smallest Population (non 0)
  def smallest_pop
    sorted = @areas.sort do |x, y| 
      x.estimated_population <=> y.estimated_population
    end
    smallest = sorted.drop_while { |i| i.estimated_population == 0 }.first
    p "#{smallest.city}, #{smallest.state} has the smallest population of #{smallest.estimated_population}"
  end

#3. Larest Population
  def largest_pop
    sorted = @areas.sort do |x, y| 
      x.estimated_population <=> y.estimated_population
    end
    largest = sorted.reverse.drop_while { |i| i.estimated_population == 0 }.first

    p "#{largest.city}, #{largest.state} has the largest population of #{largest.estimated_population}"
  end
  #But why not this?  If we sort descending, can't we just take the first one?
  #def largest_pop
    #sorted = @areas.sort do |x, y| 
      #y.estimated_population <=> x.estimated_population
    #end
    #largest = sorted.first
    #p "#{largest.city}, #{largest.state} has the largest population of #{largest.estimated_population}"
  #end

#4. How many zips in California?
  def california_zips
    c = @areas.count {|x| x.state == "CA"}
    puts "There are #{c} zip code matches in California"
  end

#5. Information for a given zip
  def zip_info
    print "Enter zip: "
    zip = gets.strip.to_i
    zips = @areas.select {|x| x.zipcode == zip}
    unless zips.empty?
      puts ""
      #could we use the "to_s" method from Areas below instead of 'p'?
      zips.each { |z| puts z }
    else
      puts "Zip not found"
    end
  end

#6. Exit
  #def exit

  #end

end

