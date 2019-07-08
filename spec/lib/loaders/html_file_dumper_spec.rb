require "loaders/html_file_dumper"

describe HTMLFileDumper do
  describe "#load" do
    let(:slug) { "minato" }

    let(:data) do
      {
        page_htmls: [{slug: slug, html: "some html"}]
      }
    end

    before do
      allow(FileUtils).to receive(:mkdir_p)
      allow(IO).to receive(:write)
      subject.load(data)
    end

    it "creates the output folder " do
      expect(FileUtils).to have_received(:mkdir_p).once
    end

    it "outputs the html with the expected filename" do
      expect(IO).to have_received(:write)
        .with("./output/minato.html", "some html")
        .once
    end

    context "with malicious text in the slug" do
      let(:slug) { "../../:*?\"<>|$!hacked?#%&()'" }

      it "sanitizes the slug" do
        expect(IO).to have_received(:write)
          .with("./output/.._..__________hacked_______.html", "some html")
          .once
      end
    end
  end
end
