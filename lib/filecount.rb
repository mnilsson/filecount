class Filecount
  attr_reader :filecount
  def initialize
    @filecount = 0
  end

  def run (dir)
    Dir.entries(dir).each do |file|
      if file != '.' && file != '..' then
        if File.directory?(file)
          fc = Filecount.new
          fc.run(file)
          @filecount += fc.filecount
        else
          @filecount += 1
        end
      end
    end
  end
end
