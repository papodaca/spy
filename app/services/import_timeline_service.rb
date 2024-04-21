class ImportTimelineService < ApplicationService
  string file_path
  string user_id

  validates :file_path, presence: true
  validates :user_id, presence: true

  def execute
    user = User.find(user_id)
    return puts "User(#{user_id}) does not exist" if user.nil?
    data = JSON.load_file(file_path, symbolize_names: true)
    data[:locations].each_with_index do |location, index|
      lat = location[:latitudeE7] / 1e7
      lon = location[:longitudeE7] / 1e7
      tz = Timezone.from_point(lat, lon)
      Location.find_or_create_by(user_id: user_id, reported_at: DateTime.parse(location[:timestamp]))
        .update(
          timezone_id: tz.id,
          tid: user.properties&.dig(:device_ids)&.first,
          uid: user.properties&.dig(:username),
          lat: lat,
          lon: lon,
          gis_location: "POINT(#{lon} #{lat})",
          acc: location[:accuracy],
          alt: location[:altitude],
          vac: location[:verticalAccuracy],
          properties: location
        )
    end
    puts "Done."
  end
end
