namespace :spy do
  desc "create or update application user"
  task create_user: :environment do
    username = ARGV[1]
    password = ARGV[2]

    User.find_or_create_by(username: username).update!(password: password, password_confirmation: password)
  end

  desc "import the google takeout records(Records.json) for maps timeline"
  task import_timeline: :environment do
    file_path = ARGV[1]
    user_id = ARGV[2]

    ImportTimelineService.run(file_path: file_path, user_id: user_id)
  end

  desc "Update the latest timezones table"
  task update_timezones: :environment do
    UpdateTimezonesService.run
  end
end
