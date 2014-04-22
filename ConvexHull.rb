class Point
  attr_accessor :x, :y

  def initialize x, y
    @x = x
    @y = y
  end

  def compare_x other
    @x <=> other.x
  end

  def compare_y other
    @y <=> other.y
  end

  def compare_polar other
    polar <=> other.polar
  end

  def polar
  	Math.atan2(@y, @x)
  end

  def clone
  	Point.new(@x, @y)
  end

  def to_s
  	"#{@x}, #{@y}"
  end
end

class ConvexHull
	attr_reader :points, :hull

	def initialize points
		@points = points	
		@hull = []
		@processed = false
	end

	def processed?
		@processed
	end

	def process
		# return if convex hull is already calculated
		return if processed? 	

		# sort points based on the lowest y
	  @points.sort! {|a, b| a.compare_y b}
	  @p = @points.first.clone

	  # substract first point from all the points, needed to calculate polar angle relative to first point
	  @points.each {|pnt| pnt.x-=@p.x; pnt.y-=@p.y}

	  # sort points based on polar angle
		@points.sort! {|a, b| a.compare_polar b}

		@hull = @points.slice(0,2)

		(2...@points.length).each do |i|
			top = @hull.pop
			while ccw(@hull.last, top, @points[i]) <= 0
				top = @hull.pop
			end
			@hull.push top
			@hull.push @points[i]
		end

		# restore points array
		@points.each {|pnt| pnt.x+=@p.x; pnt.y+=@p.y}
		@processed = true
	end

	# checks if angle between a, b and c is counter clockwise. gt 1 is not, eq 0 is straight, le 1 is ccw
	def ccw a, b, c
	  area2 = (b.x-a.x)*(c.y-a.y) - (b.y-a.y)*(c.x-a.x)
	  (area2 > 0) ? 1 : (area2 < 0) ? -1 : 0
	end

	def to_s
		puts "Given Points:"
		puts @points # .each {|pnt| pnt.x+=@p.x; pnt.y+=@p.y}
		puts "Convex Hull Points:"
    puts @hull
	end
end

ch = ConvexHull.new [Point.new(2, 3), Point.new(4,1), Point.new(6,7), Point.new(6,5), Point.new(6,6), Point.new(6,8)]
ch.process
ch.process #dont have any effect
puts ch
puts ch
