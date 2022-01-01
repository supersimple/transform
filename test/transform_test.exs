defmodule TransformTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  doctest Transform

  test "outputs translations" do
    assert capture_io(fn -> Transform.main(["rgb", "5,5,5"]) end) ==
             "\e[35mRGB:\e[0m R:5, G:5, B:5\n\e[36mHEX:\e[0m #050505\n\e[32mHSL:\e[0m H:0, S:0, L:2\n\e[34mHSV:\e[0m H:0, S:0, V:2\n\e[35mCMYK:\e[0m C:0, M:0, Y:0, K:98\n"
  end
end
