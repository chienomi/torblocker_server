def preprocess_tor_list(filepath_r, filepath_w)
  f = File.open(filepath_r, "r")
  buffer = f.read()
  f.close()

  buffer.gsub!(/[|].*/,"")

  f = File.open(filepath_w, "w")
  f.write(buffer)
  f.close()
end

