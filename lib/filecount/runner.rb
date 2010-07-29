require 'optparse'
module Filecount
  class Runner
    def initialize
      @options = {}
      parse_options
    end

    def self.execute
      new().execute
    end

    def execute
      count = Counter.execute(@options)
      puts "-- #{count} files found"
    end
    
    def parse_options
      optparse = OptionParser.new do |opts|
        opts.banner = 'Usage: filecount [options] directory'
        
        opts.on('-d', '--dotfiles', 'Follow dotfiles and directories') do
          @options[:dotfiles] = true
        end
        
        opts.on('-g', '--count-git-dir', 'Count files in git directory') do
          @options[:count_git_dir] = true
        end
        
        opts.on('-v', '--verbose', 'Display counted files') do
          @options[:verbose] = true
        end
        
        opts.on('-h', '--help', 'Display this screen') do
          puts opts
          exit
        end
      end
      
      begin 
        optparse.parse! 
      rescue 
        puts "Invalid options"
        puts optparse
        exit
      end
    end
  end
end