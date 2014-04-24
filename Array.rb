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

  def quick_sort
    self.clone.quick_sort!
  end
  
  def quick_sort!
    self.shuffle!
    qsort 0, self.length-1
  end

  def three_way_sort!
    self.shuffle!
    three_part 0, self.length-1
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

  def qsort low, high
    return if high <= low
    j = partition(low, high)
    qsort low, j-1
    qsort j+1, high
  end

  def partition low, high
    i, j = low+1, high

    while true
      while self[i] < self[low]
        break if i == high
        i+=1
      end  

      while self[low] < self[j]
        break if j == low
        j-=1
      end

      break if i >= j
      self[i], self[j] = self[j], self[i]      
    end

    self[low], self[j] = self[j], self[low]
    j
  end

  def three_part low, high    
    return if high <= low
    
    lt, gt, i, pivot = low, high, low, self[low]

    while i<=gt
      c = self[i] <=> pivot

      if c == -1
        self[lt], self[i] = self[i], self[lt]
        lt+=1
        i+=1
      elsif c == 1
        self[gt], self[i] = self[i], self[gt]
        gt-=1      
      else
        i+=1        
      end
    end
    three_part low, lt-1
    three_part gt+1, high
  end

end

arr = [3, -5, -11, -17, -18]
puts arr.sorted? 'DSC'

arr = [4, 6, -3, 23, 89, 0, 89, -3]

arr.three_way_sort!
puts arr.to_s
puts arr.sorted? 
