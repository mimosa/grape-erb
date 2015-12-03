# -*- encoding: utf-8 -*-
require 'grape-erb'

module Grape
  module Formatter
    module Erb
      class << self
        def call(object, env)
          fail "Use Rack::Config to set 'api.tilt.root' in config.ru" unless env['api.tilt.root']
          Grape::Erb::Formatter.new(object, env).call
        end
      end
    end
  end
end
