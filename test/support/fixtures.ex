defmodule Kegster.Fixtures do
  alias Kegster.Beer

  def fixture(:beer) do
    %Beer{name: "Daniel Berkompas", alcohol_content: 5.5}
  end
end
