defmodule Tokens.PNRG do
  def get_random_numbers(thres=16) do
    File.stream!("/dev/random",[],1024) |> Enum.take(thres)
  end
end
