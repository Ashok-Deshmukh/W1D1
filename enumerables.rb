class Array
  def my_each(&block)
    i = 0
    while i < self.length
      block.call(self[i])
      i+= 1
    end
    self
  end

  def my_select(&block)
    arr = []
    self.my_each do |num|
      arr << num if block.call(num)
    end
    arr
  end

  def my_reject(&block)
    arr = []
    self.my_each do |num|
      arr << num unless block.call(num)
    end
    arr
  end

  def my_any?(&block)
    self.my_each do |num|
      true if block.call(num)
    end
    false
  end

  def my_all?(&block)
    self.my_each do |num|
      return false unless block.call(num)
    end
    true
  end


  def my_flatten
    arr = []

    self.my_each do |num|
      if num.is_a?(Array)
        arr.concat(num.my_flatten)
      else
        arr << num
      end
    end
    arr
  end


  def my_zip(*args)
    counter = 0
    arr = []
    while counter < self.length
      sub_arr = []
      sub_arr << self[counter]
      args.my_each do |arg|
        sub_arr << arg[counter]
      end
      counter += 1
      arr << sub_arr
    end
    arr
  end


  def my_rotate(idx=1)
    idx %= self.length
    rot_arr = self[idx..self.length] + self[0..(idx-1)]
  end


  def my_join(del = "")
    arr = []
    str = ""
    self.my_each { |e| str << e + del}
    if del != ""
      str = str[0..str.length-2]
    end

    str
  end


  def my_reverse
    rev_arr = []
    arr = self
    while !arr.empty?
      rev_arr << arr.pop
    end
    rev_arr
  end

end
