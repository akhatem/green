class OfferCaroselImageUploader < CarrierWave::Uploader::Base
  
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  def append_name_code
    charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
    code = Array.new(4) { charset.sample }.uniq.join
    if code.length < 4
      append_name_code
    else
      return code
    end
  end

  def original_filename
    file_ext = File.extname(super)
    super.chomp(File.extname(super)) + "_" + append_name_code + file_ext
  end
end
