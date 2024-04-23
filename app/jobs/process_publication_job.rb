class ProcessPublicationJob < ApplicationJob
  queue_as :default

  def perform(*args, **kwargs)
    params = kwargs[:params].with_indifferent_access
    user = User.find(kwargs[:user_id])

    user.update(tid: params[:tid]) if user.tid.blank?

    tz = Timezone.from_point(params[:lat], params[:lon])
    kwargs = params.slice(*%i[acc alt lat lon tid vac])
    Location.create!(
      gis_location: "POINT(#{params[:lon]} #{params[:lat]})",
      did: params[:topic].split("/").last,
      properties: JSON.dump(params),
      recorded_at: Time.at(params[:tst]).to_datetime,
      reported_at: Time.at(params[:created_at]).to_datetime,
      timezone_id: tz.id,
      user_id: user.id,
      **kwargs
    )
  end
end
