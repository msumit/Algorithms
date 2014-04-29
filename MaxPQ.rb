class MaxPQ

  def initialize 
    @pq = Array.new
  end

  def insert v
    @pq.push v   
    swim @pq.length-1    
  end

  def del_max    
    if @pq.length > 1
    	max = @pq[0]
    	@pq[0] = @pq.pop
    	sink 0
    	max
    elsif @pq.length == 1
    	max = @pq.pop
    else
    	'Priority Queue is empty!'
    end        
  end

  def empty?
  	@pq.empty?
  end

  def print
  	puts @pq.to_s
  end

  private

  def swim k
  	while k>0 && @pq[k] > @pq[k/2]
  		@pq[k], @pq[k/2] = @pq[k/2], @pq[k]
  		k/=2
  	end
  end

  def sink k

  	while k<@pq.length
  		j = 2*k+1  		 
  		j+=1 if j<@pq.length-1 && @pq[j]<@pq[j+1]  		
  		break if @pq[j].nil? || @pq[k]>=@pq[j]
  		@pq[k], @pq[j] = @pq[j], @pq[k]
  		k = j  	
  	end 
  end
end

pq = MaxPQ.new
pq.insert 'P'
pq.insert 'Q'
pq.insert 'P'
pq.insert 'Q'
pq.insert 'Z'
pq.insert 'R'
pq.insert 'S'
pq.insert 'T'
pq.insert 'U'

while !pq.empty?
	pq.print
  puts pq.del_max
end
puts pq.del_max