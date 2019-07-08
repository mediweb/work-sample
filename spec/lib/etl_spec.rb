require "etl"

describe ETL do
  let(:extractor) { spy(extract: extracted_data) }
  let(:transformer) { spy(transform: transformed_data) }
  let(:loader) { spy }
  let(:extracted_data) { double("extracted data") }
  let(:transformed_data) { double("transformed_data") }

  subject do
    described_class.new(
      extractor: extractor,
      transformer: transformer,
      loader: loader,
    )
  end

  describe "#perform" do
    before { subject.perform }
    it { expect(extractor).to have_received(:extract).once }
    it { expect(transformer).to have_received(:transform).with(extracted_data).once }
    it { expect(loader).to have_received(:load).with(transformed_data).once }
  end
end
