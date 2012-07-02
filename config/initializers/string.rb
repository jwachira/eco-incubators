class String
  def numeric_id(sep = "-")
    mb_chars.split(sep).last.to_s =~ /(\w+)/ && $1
  end
end