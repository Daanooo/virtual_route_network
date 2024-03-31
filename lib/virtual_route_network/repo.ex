defmodule VirtualRouteNetwork.Repo do
  use Ecto.Repo,
    otp_app: :virtual_route_network,
    adapter: Ecto.Adapters.MyXQL
end
