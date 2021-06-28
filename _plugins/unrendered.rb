class Jekyll::Converters::Markdown::Bypass
    def initialize(config)
        @config = config
        @kram_config = config["kramdown"] || {}
        @sub_parser = get_sub_processor
    end

    def get_sub_processor
        # TODO: 
        Jekyll::Converters::Markdown::KramdownParser.new(@config)
    end

    # converters need #convert, #matches, #output_ext 
    def convert(content)
        document = Kramdown::JekyllDocument.new(content, @kram_config)
#        puts @config
        # return as is
        return content if @config.key?("bypass") && @config["bypass"]
        html_output = document.to_html
#        puts html_output
        html_output
    end

    def matches(ext)
        ext =~ /^\.(m(?:d(?:te?xt|o?wn)?|arkdown|kdn?)|text)$/i
    end
  
    def output_ext(ext)
        ".html"
    end
end