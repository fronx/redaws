require 'unicode'

module MagicParams
  def to_param
    "#{id}"+Unicode::normalize_KD("-"+name+"-").downcase.gsub(/[^a-z0-9\s_-]+/,'').gsub(/[\s_-]+/,'-')[0..-2]
  end
end
