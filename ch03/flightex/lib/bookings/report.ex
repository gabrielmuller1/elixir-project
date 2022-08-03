defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingsAgent

  def generate(filename \\ "report.csv") do
    bookings = build_bookings()

    File.write(filename, bookings)
  end

  defp build_bookings() do
    BookingsAgent.list_all()
    |> Map.values()
    |> Enum.map(&booking_string/1)
  end

  defp booking_string(%{
         complete_date: complete_date,
         local_origin: local_origin,
         local_destination: local_destination,
         user_id: user_id,
         id: id
       }) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
