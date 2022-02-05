defmodule Quizzez.Helpers do
  @doc """
  Scales a number from one scale to another.
  Options
  - `from`: The scale the passed value belongs to
  - `to`: The target scale we'd like the scale our value to
  - `round`: whether the value should be rounded or not. defaults to `false`

  ## Examples

      iex> Quizzez.Helpers.rescale(5, from: 0..10, to: 0..100)
      50.0

      iex> Quizzez.Helpers.rescale(5, from: 0..7, to: 0..100)
      71.42857142857143

      iex> Quizzez.Helpers.rescale(5, from: 0..7, to: 0..100, round: true)
      71
  """
  def rescale(number, options) do
    scale =
      Keyword.get(options, :from) ||
        raise ArgumentError, "`from` option wasn't passed into options for `linear_scale`"

    domain =
      Keyword.get(options, :to) ||
        raise ArgumentError,
              "`to` option wasn't passed into options for `linear_scale`"

    round? = Keyword.get(options, :round, false)

    {scale_min, scale_max} = Enum.min_max(scale)
    {domain_min, domain_max} = Enum.min_max(domain)

    scale_size = scale_max - scale_min
    domain_size = domain_max - domain_min

    scaled_value = domain_min + (number - scale_min) / scale_size * domain_size

    if round? do
      round(scaled_value)
    else
      scaled_value
    end
  end
end
