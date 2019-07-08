class HTMLFileDumper
  OUTPUT_FOLDER = "./output/"

  def load(data)
    ensure_output_folder
    data[:page_htmls].each do |page_html|
      output(page_html[:slug], page_html[:html])
    end
  end

  private

  def ensure_output_folder
    FileUtils.mkdir_p(OUTPUT_FOLDER)
  end

  def output(slug, html)
    puts "Writing to file: #{filename_for(slug)}"
    IO.write(filename_for(slug), html)
  end

  def filename_for(slug)
    File.join(
      OUTPUT_FOLDER,
      sanitize_filename("#{slug}.html")
    )
  end

  def sanitize_filename(filename)
    filename.gsub(/[^0-9A-z.]/, "_")
  end
end
