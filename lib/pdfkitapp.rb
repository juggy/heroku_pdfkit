require 'pdfkit'

PDFKit.configure do |config|       
  config.wkhtmltopdf = File.expand_path('../../bin/wkhtmltopdf-amd64', __FILE__).to_s if ENV['RACK_ENV'] == 'production'  
  config.default_options = {
    :print_media_type => true, 
    :footer_right=>"[page]/[toPage]", 
    :page_size=>"Letter", 
    :margin_bottom=>"1cm", 
    :margin_left=>"5mm", 
    :margin_right=>"5mm", 
    :margin_top=>"5mm"
  }
end

module HerokuPdfKit
  
  NotFound = [404, {'Content-Type' => 'text/plain'}, ['Not Found']]
  
  class GenApp
    
    def call(env)
      request = Rack::Request.new(env)
      params = request.params
      if params["url"] && File.extname(request.path_info) == ".pdf"
        pdf = PDFKit.new("http://" + params["url"])
        return [200, {'Content-Type' => 'application/pdf'}, [pdf.to_pdf]]
      else
        return NotFound
      end
    end
  end
end