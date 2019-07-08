require "jobs/pages_publishing_job"

describe PagesPublishingJob do
  let(:google_sheets_document) { instance_spy("GoogleSheetsDocument") }
  let(:page_builder) { instance_spy("PageBuilder") }
  let(:html_file_dumper) { instance_spy("HTMLFileDumper") }
  let(:etl) { instance_spy("ETL") }

  describe "#perform" do
    before do
      allow(GoogleSheetsDocument)
        .to receive(:new)
        .with(sheet_names: [:clinics, :wards])
        .and_return(google_sheets_document)
      allow(PageBuilder).to receive(:new).and_return(page_builder)
      allow(HTMLFileDumper).to receive(:new).and_return(html_file_dumper)
    end

    it "uses GoogleSheetsDocument, PageBuilder and HTMLFileDumper for ETL" do
      expect(ETL)
        .to receive(:new)
        .with(
          extractor: google_sheets_document,
          transformer: page_builder,
          loader: html_file_dumper,
        ).and_return(etl)
      expect(etl).to receive(:perform)
      subject.perform
    end
  end
end
