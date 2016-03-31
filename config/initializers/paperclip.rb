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
