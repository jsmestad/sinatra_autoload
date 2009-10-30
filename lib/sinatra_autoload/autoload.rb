require 'singleton'

module SinatraAutoload
  @@root_path = nil
  
  def self.root_path
    @@root_path
  end
  
  def self.root_path=(path)
    @@root_path = path
  end

  def self.directories(*args)
    return unless args
    args.each do |file_path|
      Dir[ File.join( @root_path, file_path, '/**/*.rb') ].each do |file|
        require file
      end
    end
  end
  
end