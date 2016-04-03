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

# paperclip_defaults = Rails.application.config_for :paperclip
# paperclip_defaults.symbolize_keys!
#
# Paperclip::Attachment.default_options.merge! paperclip_defaults
