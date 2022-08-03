defmodule Exmeal.Error do
  @keys [:status, :result]
  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{status: status, result: result}
  end

  def bad_request(), do: build(:bad_request, "Invalid request format.")
end
