module Bypass
    DOCTYPE = [:documents, :pages]
    class BypassContent < Jekyll::Renderer
        def initialize(document, site_payload = nil)
            @site     = document.site
            @document = document
            @payload  = site_payload
            @layouts  = nil
        end

        def output
            @output ||= trigger_hooks(:post_render, renderer.run)
        end

        def process_liquid_thing
            info = {
              :registers        => { :site => site, :page => payload["page"] },
              :strict_filters   => liquid_options["strict_filters"],
              :strict_variables => liquid_options["strict_variables"],
            }
      
            # render only liquid thing in the doc_source
            if document.render_with_liquid?
              Jekyll.logger.debug "Rendering Liquid:", document.relative_path
              output = render_liquid(document.content, payload, info, document.path)
            end

            document.data["bypass"] = output
        end
    end
end
  
# Jekyll::Hooks.register Bypass::DOCTYPE, :post_init do |doc|
#     Jekyll.logger.debug "Initialized:",
#                         "Hooked for #{doc.inspect}"
# end
  
Jekyll::Hooks.register Bypass::DOCTYPE, :pre_render do |doc, payload|
    puts payload["page"]["bypass"]
    Bypass::BypassContent.new(doc, payload).process_liquid_thing if payload["page"]["bypass"]
end