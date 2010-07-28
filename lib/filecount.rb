class Filecount
  attr_reader :filecount
  def initialize
    @filecount = 0
  end

  def run (directory)
    Dir.foreach(directory) do |file|
      if file != '.' && file != '..' then
        f = "#{directory}/#{file}"
        if File.directory?(f)
          run(f)
        else
          @filecount += 1
        end
      end
    end
  end
end
