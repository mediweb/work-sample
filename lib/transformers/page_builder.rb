require "erb"

class PageBuilder
  PAGE_TEMPLATE_FILE =
    "#{File.dirname(__FILE__)}/page_builder/template.html.erb"

  def transform(data)
    puts "Building pages for #{data[:wards].size} wards"
    {
      page_htmls: build_page_htmls(data),
    }
  end

  private

  def build_page_htmls(data)
    data[:wards].map do |ward|
      {
        slug: ward[:slug],
        html: ward_html(ward, data),
      }
    end
  end

  def ward_html(ward, data)
    render_erb(IO.read(PAGE_TEMPLATE_FILE), template_data(ward, data))
  end

  def template_data(ward, data)
    {
      title: ward[:title],
      image_url: ward[:image_url],
      clinics: data[:clinics].select { |clinic| clinic[:ward] == ward[:slug] },
    }
  end

  def render_erb(template, data = {})
    render_binding = binding
    data.each { |k, v| render_binding.local_variable_set(k, v) }
    ERB.new(template).result(render_binding)
  end
end
