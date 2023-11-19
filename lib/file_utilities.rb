def read_file(filename)
  File.read(filename).split("\n")
end

def overwrite(filename, contents)
  f = File.new(filename, 'w')
  f.write(contents)
  f.close
end

def append_write(filename, contents)
  f = File.new(filename, 'a')
  f.write(contents)
  f.close
end

def safe_write(filename, contents)
  if !File.exist?(filename) || File.empty?(filename)
    overwrite(filename, contents)
  else
    puts 'Write aborted: File is not empty.'
  end
end
