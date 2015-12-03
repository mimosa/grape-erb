# -*- encoding: utf-8 -*-

module Grape
  module Erb
    module Renderer
      # 
      JS_ESCAPE_MAP = { '\\' => '\\\\', '</' => '<\/', "\r\n" => '\n', "\n" => '\n', "\r" => '\n', '"' => '\\"', "'" => "\\'" }
      # 
      def render(opts = {})
        Grape::Erb::Formatter.new(nil, env).call(opts)
      end
      # 
      def escape_javascript(javascript)
        result = ''
        if javascript
          result += javascript.gsub(/(\|<\/|\r\n|\342\200\250|\342\200\251|[\n\r"'])/u) {|match| JS_ESCAPE_MAP[match] }
        end
        result
      end
    end
  end
end

Grape::Endpoint.send(:include, Grape::Erb::Renderer)