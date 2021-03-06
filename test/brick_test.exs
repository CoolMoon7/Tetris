defmodule BrickTest do
  use ExUnit.Case

  import Tetris.Brick

  alias Tetris.Points
  alias Tetris.Brick

  test "Creates a new brick" do
    assert new_brick().name == :i
  end

  test "Creates a new random brick" do
    actual = new_random()

    assert actual.name in [:i, :l, :z, :o, :t]
    assert actual.rotation in [0, 90, 180, 270]
    assert actual.reflection in [true, false]
  end

  test "Should manipulate brick" do
    actual =
      new_brick()
      |> left
      |> right
      |> right
      |> down
      |> spin_90
      |> spin_90

    assert actual.location == {41, 1}
    assert actual.rotation == 180
  end

  test "should return points for brick i" do
    points =
      new_brick(name: :i)
      |> points()

    assert {2, 2} in points
  end
  test "should return points for brick z" do
    points =
      new_brick(name: :z)
      |> points()

    assert {3, 4} in points
  end
  test "should translate a list of points" do
    actual_points =
      new_brick(name: :i)
      |> Tetris.Brick.points
      |> Tetris.Points.move_to_location({1, 2})

    assert actual_points == [{3, 3}, {3, 4}, {3, 5}, {3, 6}]
  end

  test "should mirror flip rotate and rotate" do
    [{1, 1}]
    |> Points.mirror
    |> assert_point({4, 1})
    |> Points.flip
    |> assert_point({4, 4})
    |> Points.rotate_90
    |> assert_point({1, 4})
    |> Points.rotate_90
    |> assert_point({1, 1})
  end

  test "should convert brick to string" do
    actual = new_brick() |> Brick.to_string
    expected = ".X..\n.X..\n.X..\n.X.."

    assert actual == expected
  end

  test "should inspect brick" do
    actual = new_brick() |> inspect
    expected =
      """
      .X..
      .X..
      .X..
      .X..
      {#{x_center()}, 0}
      false
      """

    assert "#{actual}\n" == expected
  end

  def assert_point([actual], expected) do
    assert actual == expected
    [actual]
  end

  def new_brick(attributes \\ []), do: new(attributes)
end
