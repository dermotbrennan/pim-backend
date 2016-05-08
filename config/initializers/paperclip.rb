# https://github.com/thoughtbot/paperclip/issues/1429
require 'paperclip/media_type_spoof_detector'

module Paperclip
  class MediaTypeSpoofDetector
    old_spoofed = instance_method(:spoofed?)

    define_method(:spoofed?) do
      false
    end
  end
end

paperclip_defaults = {
  storage: :s3,
  s3_region: ENV["AWS_REGION"],
  bucket: ENV["AWS_S3_BUCKET"],
  s3_host_name: ENV["AWS_S3_HOST_NAME"],
  s3_redundancy_class: :reduced_redundancy,
  s3_credentials: {
    access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
  }
}

Paperclip::Attachment.default_options.merge! paperclip_defaults
