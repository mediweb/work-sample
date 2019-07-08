require "transformers/page_builder"

describe PageBuilder do
  let(:data) do
    {
      wards: [{
        slug: "minato",
        title: "Minato-ku's Top Clinics",
        image_url: "banner_url",
      }],
      clinics: [{
        slug: "x000001",
        ward: "minato",
        name: "Shinbashi Clinic",
      }],
    }
  end

  describe "#transform" do
    it "returns page_htmls" do
      expect(subject.transform(data).keys).to include(:page_htmls)
    end
  end

  describe "#transform[:page_htmls]" do
    let(:result) do
      Capybara.string(subject.transform(data)[:page_htmls].first[:html])
    end

    it "has ward data" do
      expect(result).to have_selector("h1", text: "Minato-ku's Top Clinics")
    end

    it "has clinic data" do
      expect(result).to have_selector("h5", text: "Shinbashi Clinic")
    end
  end
end
