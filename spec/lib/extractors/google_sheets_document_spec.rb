require "extractors/google_sheets_document"

describe GoogleSheetsDocument do
  describe "#new" do
    let(:sheets_service) do
      instance_double("Google::Apis::SheetsV4::SheetsService", "key=": nil)
    end

    subject { described_class.new(sheet_names: []) }

    it "creates google sheets service by default" do
      expect(Google::Apis::SheetsV4::SheetsService)
        .to receive(:new)
        .and_return(sheets_service)
        .once
      subject
    end
  end

  describe "#extract" do
    let(:sheets_service) do
      instance_double("Google::Apis::SheetsV4::SheetsService")
    end
    let(:sheet_names) { ["sheet"] }
    let(:sheet_data) do
      [
        ["header a", "header b"],
        ["a1", "b1"],
        ["a2", "b2"],
      ]
    end

    before do
      allow(sheets_service)
        .to receive(:get_spreadsheet_values)
        .with(anything, "sheet!A1:ZZ")
        .and_return(double(values: sheet_data))
    end

    subject do
      described_class.new(
        sheet_names: sheet_names,
        sheets_service: sheets_service,
      )
    end

    context "with the last data column missing" do
      let(:sheet_data) do
        [
          ["header a", "header b"],
          ["a1"],
        ]
      end

      it "gives it a nil value" do
        expect(subject.extract).to eq({
          sheet: [
            {"header a": "a1", "header b": nil},
          ]
        })
      end
    end

    context "with an extra data column" do
      let(:sheet_data) do
        [
          ["header a", "header b"],
          ["a1", "b1", "c1"],
        ]
      end

      it "ignores the extra value" do
        expect(subject.extract).to eq({
          sheet: [
            {"header a": "a1", "header b": "b1"},
          ]
        })
      end
    end

    context "with multiple sheets" do
      let(:sheet_names) { ["sheet", "sheet2"] }
      let(:sheet2_data) do
        [
          ["header x", "header y"],
          ["x1", "y1"],
          ["x2", "y2"],
        ]
      end

      before do
        allow(sheets_service)
        .to receive(:get_spreadsheet_values)
        .with(anything, "sheet2!A1:ZZ")
        .and_return(double(values: sheet2_data))
      end

      it "returns an array with data from each sheet" do
        expect(subject.extract).to eq({
          sheet: [
            {"header a": "a1", "header b": "b1"},
            {"header a": "a2", "header b": "b2"},
          ],
          sheet2: [
            {"header x": "x1", "header y": "y1"},
            {"header x": "x2", "header y": "y2"},
          ],
        })
      end
    end
  end
end
