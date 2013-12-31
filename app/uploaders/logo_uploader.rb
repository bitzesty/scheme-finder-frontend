class LogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :logo do
    process resize_to_fill: [50, 50]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
