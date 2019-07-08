require "etl"
require "extractors/google_sheets_document"
require "transformers/page_builder"
require "loaders/html_file_dumper"

class PagesPublishingJob
  def perform
    ETL.new(
      extractor: GoogleSheetsDocument.new(sheet_names: [:clinics, :wards]),
      transformer: PageBuilder.new,
      loader: HTMLFileDumper.new,
    ).perform
  end
end
