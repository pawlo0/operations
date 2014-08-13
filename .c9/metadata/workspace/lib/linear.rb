{"filter":false,"title":"linear.rb","tooltip":"/lib/linear.rb","undoManager":{"mark":0,"position":0,"stack":[[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":0,"column":0},"end":{"row":1,"column":0}},"text":"\n"},{"action":"insertLines","range":{"start":{"row":1,"column":0},"end":{"row":32,"column":0}},"lines":["class SimpleLinearRegression","  def initialize(xs, ys)","    @xs, @ys = xs, ys","    if @xs.length != @ys.length","      raise \"Unbalanced data. xs need to be same length as ys\"","    end","  end"," ","  def y_intercept","    mean(@ys) - (slope * mean(@xs))","  end"," ","  def slope","    x_mean = mean(@xs)","    y_mean = mean(@ys)"," ","    numerator = (0...@xs.length).reduce(0) do |sum, i|","      sum + ((@xs[i] - x_mean) * (@ys[i] - y_mean))","    end"," ","    denominator = @xs.reduce(0) do |sum, x|","      sum + ((x - x_mean) ** 2)","    end"," ","    (numerator / denominator)","  end"," ","  def mean(values)","    total = values.reduce(0) { |sum, x| x + sum }","    Float(total) / Float(values.length)","  end"]},{"action":"insertText","range":{"start":{"row":32,"column":0},"end":{"row":32,"column":3}},"text":"end"}]}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":9,"column":6},"end":{"row":9,"column":17},"isBackwards":true},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":{"row":4,"state":"start","mode":"ace/mode/ruby"}},"timestamp":1407967963944,"hash":"d78baba28f7c244b6897bdb535600d41f66ac733"}