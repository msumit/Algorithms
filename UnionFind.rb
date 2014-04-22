class UnionFind
  #ruby implementation of weighted quick union find with path compression

  def initialize n
    @node = (0...n).to_a    # [0, 1, 2, 3...]
    @size = Array.new(n, 1) # [1, 1, 1, 1...]
  end

  def union p, q
    i, j = root(p), root(q)

    return if i == j
    
    if @size[i] < @size[j]      
      @node[i] = j
      @size[j] += @size[i]
    else
      @node[j] = i
      @size[i] += @size[j]
    end
  end

  def connected? p, q
    root(p) == root(q)
  end

  private

  def root p
    while p != @node[p]
      @node[p] = @node[@node[p]] #Make every other node in path point to its grandparent (thereby halving path length). Path compression
      p = @node[p]	
    end  
    p
  end

end


uf = UnionFind.new 10
uf.union 4, 3
uf.union 3, 8
uf.union 6, 5
uf.union 9, 4
uf.union 2, 1
uf.union 8, 9
uf.union 5, 0
uf.union 7, 2
uf.union 6, 1
uf.union 1, 0
uf.union 6, 7
puts uf.connected? 4, 0
puts uf.connected? 1, 9
puts uf.connected? 2, 6
