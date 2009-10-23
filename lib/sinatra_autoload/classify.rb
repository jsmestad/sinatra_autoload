class String
  
  def camelize
    self.split(/[^a-z0-9]/i).map{ |w| w.capitalize}.join
  end
  
  def classify
    self.split('/').map{ |w| w.camelize }.join('::')
  end
  
end
