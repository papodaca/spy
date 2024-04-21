class UpdateTimezonesService < ActiveInteraction::Base
  def execute
    require "open-uri"
    require "zip"
    require "rgeo/shapefile"

    tmp_root = Rails.root.join("tmp", "shapes")
    FileUtils.mkdir_p(tmp_root.to_s)
    repo = "evansiroky/timezone-boundary-builder"
    releases = JSON.parse(URI.open("https://api.github.com/repos/#{repo}/releases").read)
    latest = releases.first

    zip_file = URI.open("https://github.com/#{repo}/releases/download/#{latest["tag_name"]}/timezones-now.shapefile.zip")

    Zip::File.open(zip_file) do |zip|
      shape_file = nil

      zip.each do |entry|
        shape_file = entry if /\.shp$/.match?(entry.name)
        File.binwrite(tmp_root.join(entry.name).to_s, entry.get_input_stream.read)
      end

      RGeo::Shapefile::Reader.open(tmp_root.join(shape_file.name).to_s) do |shape_file|
        puts "importing #{shape_file.num_records} timezone shapes"
        shape_file.each do |record|
          Timezone
            .find_or_create_by(name: record.attributes["tzid"])
            .update(shape: record.geometry.as_text)
        end
      end
    ensure
      FileUtils.rm_rf(tmp_root.to_s) if File.exist?(tmp_root.to_s)
    end
  end
end
