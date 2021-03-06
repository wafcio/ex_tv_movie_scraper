defmodule Workers.TraktTvDownloadShowPeopleWorker do
  def perform(id) do
    HTTPoison.start

    response = HTTPoison.get!("https://api.trakt.tv/shows/" <> id <> "/people?extended=full,images", ["Content-Type": "application/json", "trakt-api-version": 2, "trakt-api-key": Application.get_env(:trakt_tv, :client_id)])
    {:ok, parsed_json} = Util.parse_json(response.body)

    "data/trakt_tv/shows/details/show_" <> id <> "/people.json"
    |> Util.open_file
    |> Util.write_file(response.body)
    |> Util.close_file
  end
end
