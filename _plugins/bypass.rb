module Bypass
    DOCTYPE = [:documents, :pages]
    class BypassContent < Jekyll::Renderer
        def initialize(document, site_payload = nil)
            @site     = document.site
            @document = document
            @payload  = site_payload
            @layouts  = nil
        end

        def infiltrate
            osmosed = document.content
            # render only liquid thing in the doc_source
            if document.render_with_liquid?
                info = {
                  :registers        => { :site => site, :page => payload["page"] },
                  :strict_filters   => liquid_options["strict_filters"],
                  :strict_variables => liquid_options["strict_variables"],
                }
              Jekyll.logger.debug "        Osmosing:", document.relative_path
              osmosed = render_liquid(osmosed, payload, info, document.path)
            end

            payload["page"]["bypassed"] = osmosed
        end
    end
end


Jekyll::Hooks.register Bypass::DOCTYPE, :post_init do |doc|
    Jekyll.logger.debug "Initialized:",
                        "Hooked for #{doc.inspect}"
end

Jekyll::Hooks.register Bypass::DOCTYPE, :pre_render do |doc, payload|
    Bypass::BypassContent.new(doc, payload).infiltrate if payload["page"]["bypass"]
end
