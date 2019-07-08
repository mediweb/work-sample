class ETL
  def initialize(extractor:, transformer:, loader:)
    @extractor = extractor
    @transformer = transformer
    @loader = loader
  end

  def perform
    extracted_data = extractor.extract
    transformed_data = transformer.transform(extracted_data)
    loader.load(transformed_data)
  end

  private

  attr_accessor :extractor, :transformer, :loader
end
