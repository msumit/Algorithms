class Array

	def sorted? dir='ASC'
		if dir != 'DSC'
			(1...self.length).each do |i|
				return false if self[i-1] > self[i]
			end
		else
			(1...self.length).each do |i|
				return false if self[i-1] < self[i]
			end
		end
		return true
	end

  def shell_sort!
  	n = self.length
  	h = 1			

  	while h<n/3
  	  h = 3*h + 1	#1, 4, 13, 40, 121, 364 
  	end
  	
  	while h>=1 do
      (h...n).each do |i|
 		j = i
 		while j>=h && self[j] < self[j-h] do
 		  self[j], self[j-h] = self[j-h], self[j]
 		  j-=h
 		end
      end
  	  h/=3
  	end
  end

  def shell_sort
  	self.clone.shell_sort!
  end

  def merge_sort!
  	divide Array.new(self.length), 0, self.length-1
  end

  def merge_sort
  	self.clone.merge_sort!
  end

  def bottom_up_merge_sort!
    bottom_up_sort self.clone, 0, self.length-1
  end

  def bottom_up_merge_sort
    self.clone.bottom_up_merge_sort!
  end
  

  private 

  def divide aux, low, high
    return if high <= low
    mid = low + (high - low)/2
    divide aux, low, mid
    divide aux, mid+1, high
    return if(self[mid] <= self[mid+1])   # to check if biggest element in first half is smaller than first element in second half
    merge aux, low, mid, high
  end

  def bottom_up_sort aux, low, high
    sz = 1
    while sz <= high
      low = 0
      while low <= high-sz
        merge aux, low, low+sz-1, [low+sz+sz-1, high].min
        low+=sz+sz
      end
      sz+=sz
    end
  end

  def merge aux, low, mid, high
  	(low..high).each do |i|
  		aux[i] = self[i]
  	end

  	i, j = low, mid+1

  	(low..high).each do |k|
  		if i > mid 
  			self[k] = aux[j]
  			j+=1
  		elsif j > high
  			self[k] = aux[i]
  			i+=1
			elsif aux[i] > aux[j]
				self[k] = aux[j]
				j+=1
			else
				self[k] = aux[i]
				i+=1
			end
  	end
  end

end

arr = [3, -5, -11, -17, -18]
puts arr.sorted? 'DSC'

arr = [4, 6, -1, 23, 89, 0, 99, -3]

arr.bottom_up_merge_sort!
puts arr
puts arr.sorted? 
