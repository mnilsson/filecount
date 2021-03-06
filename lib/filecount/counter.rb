module Filecount
  class Counter
    
    attr_accessor :file_count, :start_dir
    def initialize(options)
      @options = options
      @file_count = 0
      @start_dir
    end

    def self.execute(options)
      new(options).execute
    end
    
    def execute()
      if ARGV[0] != nil and File.directory?(ARGV[0])
        @start_dir = File.expand_path(ARGV[0])
        count(ARGV[0])
      elsif ARGV[0] != nil
        puts "Directory '#{ARGV[0]}' not found"
        exit
      else
        @start_dir = File.expand_path(".")
        count(".")
      end
      @file_count
    end
    
    def count (directory)
      Dir.foreach(directory) do |file|
        if file != '.' && file != '..' then
          if @options[:dotfiles] == nil && file[0].chr == "." && file != '.git'
            next
          end
          f = "#{directory}/#{file}"

          if File.directory?(f)
            if @options[:count_git_dir] == nil && file == '.git' 
              next
            end
            count(f)
          else
            if @options[:verbose]
              puts f
            end
            @file_count += 1
          end
        end
      end
    end


  end
end