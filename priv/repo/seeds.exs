# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ytvcr.Repo.insert!(%Ytvcr.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

video_id = Faker.String.base64(11)

{:ok, recording} =
  Ytvcr.Recordings.create_recording(%{
    external_video_id: video_id,
    external_site_name: "youtube",
    temp_file_path: Faker.File.file_name(:video)
  })
