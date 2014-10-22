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
      Dir[ File.join(@@root_path, file_path, '/**/*.rb') ].each do |file|
        names = object_names(file, file_path)
        object_with_a_file_to_load = names.pop.to_sym

        parent = preload_ancestors(names)
        parent.autoload object_with_a_file_to_load, file
      end
    end
  end

  def self.preload_ancestors(names)
    parent = Object
    full_name = nil
    names.each do |name|
      begin
        full_name = full_name ? "#{ full_name }::#{ name }" : name
        parent = full_name.constantize
      rescue NameError
        parent.const_set name, (m = Module.new)
        parent = m
      end
    end
    parent
  end

  def self.object_names(file, path)
    file.gsub("#{ File.join(@@root_path, path) }/", '').gsub('.rb', '').split('/').map(&:camelize)
  end

end
