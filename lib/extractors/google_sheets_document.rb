require "google/apis/sheets_v4"
require "googleauth"
require "fileutils"

class GoogleSheetsDocument
  def initialize(sheet_names:, sheets_service: create_sheets_service)
    @sheet_names = sheet_names
    @sheets_service = sheets_service
  end

  def extract
    puts "Extracting data for sheets: #{sheet_names.inspect}"
    Hash[
      sheet_names.map do |sheet_name|
        [sheet_name.to_sym, rows(sheet_name)]
      end
    ]
  end

  private

  attr_accessor :sheet_names, :sheets_service

  def create_sheets_service
    sheets_service = Google::Apis::SheetsV4::SheetsService.new
    sheets_service.key = ENV["GOOGLE_SHEETS_API_KEY"]
    sheets_service
  end

  def rows(sheet_name)
    data_with_headers = values(sheet_name)
    headers = data_with_headers[0].map(&:to_sym)
    data_without_headers = data_with_headers[1..-1]
    data_without_headers.map do |row_data|
      Hash[headers.zip(row_data)]
    end
  end

  def values(sheet_name)
    sheets_service
      .get_spreadsheet_values(ENV["SPREADSHEET_ID"], "#{sheet_name}!A1:ZZ")
      .values
  end
end
