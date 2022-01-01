defmodule Transform do
  @moduledoc """
  CLI Interface for transforming colors.
  """

  def main(argv) do
    argv
    |> OptionParser.parse(
      strict: [rgb: :string, hex: :string, hsl: :string, cmyk: :string, hsv: :string]
    )
    |> run()
  end

  defp run({[], ["rgb", values], _errors}) do
    [r, g, b] =
      values
      |> String.split(",")
      |> Enum.map(&String.to_integer(&1))

    rgb = Chameleon.RGB.new(r, g, b)
    hex = Chameleon.convert(rgb, Chameleon.Hex)
    hsl = Chameleon.convert(rgb, Chameleon.HSL)
    hsv = Chameleon.convert(rgb, Chameleon.HSV)
    cmyk = Chameleon.convert(rgb, Chameleon.CMYK)

    print_results(rgb, hex, hsl, hsv, cmyk)
  end

  defp run({[], ["cmyk", values], _errors}) do
    [c, m, y, k] =
      values
      |> String.split(",")
      |> Enum.map(&String.to_integer(&1))

    cmyk = Chameleon.CMYK.new(c, m, y, k)
    rgb = Chameleon.convert(cmyk, Chameleon.RGB)
    hex = Chameleon.convert(cmyk, Chameleon.Hex)
    hsl = Chameleon.convert(cmyk, Chameleon.HSL)
    hsv = Chameleon.convert(cmyk, Chameleon.HSV)

    print_results(rgb, hex, hsl, hsv, cmyk)
  end

  defp run({[], ["hex", value], _errors}) do
    hex = Chameleon.Hex.new(value)
    cmyk = Chameleon.convert(hex, Chameleon.CMYK)
    rgb = Chameleon.convert(hex, Chameleon.RGB)
    hsl = Chameleon.convert(hex, Chameleon.HSL)
    hsv = Chameleon.convert(hex, Chameleon.HSV)

    print_results(rgb, hex, hsl, hsv, cmyk)
  end

  defp run({[], ["hsl", values], _errors}) do
    [h, s, l] =
      values
      |> String.split(",")
      |> Enum.map(&String.to_integer(&1))

    hsl = Chameleon.HSL.new(h, s, l)
    cmyk = Chameleon.convert(hsl, Chameleon.CMYK)
    rgb = Chameleon.convert(hsl, Chameleon.RGB)
    hex = Chameleon.convert(hsl, Chameleon.Hex)
    hsv = Chameleon.convert(hsl, Chameleon.HSV)

    print_results(rgb, hex, hsl, hsv, cmyk)
  end

  defp run({[], ["hsv", values], _errors}) do
    [h, s, v] =
      values
      |> String.split(",")
      |> Enum.map(&String.to_integer(&1))

    hsv = Chameleon.HSV.new(h, s, v)
    cmyk = Chameleon.convert(hsv, Chameleon.CMYK)
    rgb = Chameleon.convert(hsv, Chameleon.RGB)
    hex = Chameleon.convert(hsv, Chameleon.Hex)
    hsl = Chameleon.convert(hsv, Chameleon.HSL)

    print_results(rgb, hex, hsl, hsv, cmyk)
  end

  defp run(_) do
    IO.puts("Valid commands are:")
    IO.puts("`transform rgb 0,0,0`")
    IO.puts("`transform cmyk 0,0,0,0`")
    IO.puts("`transform hsl 0,0,0`")
    IO.puts("`transform hsv 0,0,0`")
    IO.puts("`transform hex FFFFFF`")
  end

  defp print_results(rgb, hex, hsl, hsv, cmyk) do
    IO.puts("#{IO.ANSI.magenta()}RGB:#{IO.ANSI.reset()} R:#{rgb.r}, G:#{rgb.g}, B:#{rgb.b}")
    IO.puts("#{IO.ANSI.cyan()}HEX:#{IO.ANSI.reset()} ##{hex.hex}")
    IO.puts("#{IO.ANSI.green()}HSL:#{IO.ANSI.reset()} H:#{hsl.h}, S:#{hsl.s}, L:#{hsl.l}")
    IO.puts("#{IO.ANSI.blue()}HSV:#{IO.ANSI.reset()} H:#{hsv.h}, S:#{hsv.s}, V:#{hsv.v}")

    IO.puts(
      "#{IO.ANSI.magenta()}CMYK:#{IO.ANSI.reset()} C:#{cmyk.c}, M:#{cmyk.m}, Y:#{cmyk.y}, K:#{cmyk.k}"
    )
  end
end
