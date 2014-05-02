Node = Struct.new(:key, :value, :left, :right, :count)

class BST
  def initialize
  	@root = nil
  end

  def put key, value
    @root = add_node @root, key, value
  end

  def get key
  	x = @root
  	while x != nil
  	  if x.key > key
  	  	x = x.left
  	  elsif x.key < key
  	  	x = x.right
  	  else
  	  	return x.value  	
  	  end  	
  	end
  	return nil 
  end

  def delete key
  	@root = delete_node @root, key
  end

  def floor key
  	x = tree_floor @root, key
  	(x) ? x.key : nil
  end

  def ceiling key
  	x = tree_ceiling @root, key
  	(x) ? x.key : nil
  end

  def size
  	node_size @root
  end

  def rank key
  	node_rank @root, key
  end

  def inorder_print
  	print_node @root
  end

  def delete_min
  	@root = tree_delete_min @root
  end

  def delete_max
  	@root = tree_delete_max @root
  end

  private 

  def add_node x, k, v
  	if x == nil
  		x = Node.new(k, v, nil, nil, 0)
  	end

  	if x.key > k
  		x.left = add_node x.left, k, v
  	elsif x.key < k
  		x.right = add_node x.right, k, v 
  	else
  		x.value = v
  	end
  	x.count = 1 + node_size(x.left) + node_size(x.right)
  	x
  end

  def delete_node x, k
  	if x == nil then return nil end

  	if x.key > k
  		x.left = delete_node x.left, k
  	elsif x.key < k
  		x.right = delete_node x.right, k
  	else
  		if x.right == nil then return x.left end
  		if x.left == nil then return x.right end

  		t = x
  		x = min t.right
  		x.right = tree_delete_min t.right
  		x.left = t.left
  	end

  	x.count = 1 + node_size(x.left) + node_size(x.right)
  	return x
  end

  def print_node x
  	print_node x.left if x.left
  	puts "#{x.key} : #{x.value}"
  	print_node x.right if x.right
  end

  def tree_floor x, key
  	if(x == nil) then return nil end

  	if(x.key == key) then return x end

  	if(x.key > key) then return tree_floor(x.left, key) end

  	t = tree_floor x.right, key

  	return (t != nil) ? t : x  		
  end

  def tree_ceiling x, key
  	if(x == nil) then return nil end

  	if(x.key == key) then return x end	

  	if(x.key > key)
  		t = tree_ceiling(x.left, key) 
  		return (t != nil) ? t : x  
  	end

  	if(x.key < key) then return tree_ceiling x.right, key end

  end

  def node_size x
  	(x == nil) ? 0 : x.count
  end

  def node_rank x, key
  	if(x == nil) then return 0 end

  	if x.key > key
  		node_rank x.left, key
  	elsif x.key < key
  		1 + node_size(x.left) + node_rank(x.right, key)
  	else
  		node_size x.left
  	end
  end

  def tree_delete_min x
  	if x.left == nil then return x.right end

  	x.left = tree_delete_min x.left
  	x.count = 1 + node_size(x.left) + node_size(x.right)
  	return x
  end

  def tree_delete_max x
  	if x.right == nil then return x.left end

  	x.right = tree_delete_max x.right
   	x.count = 1 + node_size(x.left) + node_size(x.right)
  	return x 	
  end

  def min x
  	(x.left) ? x.left : x
  end
end

bst = BST.new

bst.put 'x', 10
bst.put 'y', 30
bst.put 'r', 5
bst.put 'z', 10
bst.put 'a', 15
bst.put 'r', 20
bst.put 'd', 2

puts bst.get 'r'
puts bst.floor 'w'
puts bst.ceiling 'e'
puts bst.size
puts bst.rank 's'
bst.inorder_print
bst.delete_min
bst.delete_max
bst.delete 'x'
bst.inorder_print
