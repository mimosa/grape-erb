# -*- encoding: utf-8 -*-

module Grape
  module Erb
    class Formatter
      attr_reader :env, :endpoint, :object, :options

      def initialize(object, env)
        @env      = env
        @endpoint = env['api.endpoint']
        @object   = object

        @options  = {
          erb: env['api.tilt.erb'],
          format: env['api.format'],
          locals: env['api.tilt.erb.locals'],
          view_path: env['api.tilt.root']
        }
      end

      def call(opts={})
        @options.merge!(opts)
        if template?
          output = erb_template(template).render(endpoint, locals)
          layout = layout_name
          return layout.nil? ? output : erb_template(layout).render(endpoint, locals) { output }
        else
          fail 'missing erb template'
        end 
      end

      private

      def view_path(view_name)
        view_name += ".#{@options[:format]}.erb" unless view_name =~ /.erb$/
        File.join(@options[:view_path], view_name)
      end

      def template?
        !!template
      end

      def locals
        @options[:locals] || endpoint.options[:route_options][:locals] || {}
      end

      def template
        @options[:erb] || endpoint.options[:route_options][:erb]
      end

      def erb_template(view_name)
        _path = view_path(view_name)
        ::Tilt::ErubisTemplate.new(_path, @options)
      end

      def layout_name
        view_name = (env['api.tilt.layout'] || 'layouts/application')
        view_name if File.exist?( view_path(view_name) )
      end
    end
  end
end