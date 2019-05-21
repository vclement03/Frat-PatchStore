require 'test_helper'

class ClubTest < ActiveSupport::TestCase
  test "validate_value annual event future event is invalid" do
    club = Club.new
    club.annual_event!

    assert_not club.validate_value("20", Date.new(2018, 02, 01))
  end

  test "validate_value annual event before start date is invalid" do
    club = Club.new
    club.annual_event!
    club.start_date = Date.new(2018, 1, 8)

    assert_not club.validate_value("18", Date.new(2018, 01, 01))
  end

  test "validate_value annual event past end date is invalid" do
    club = Club.new
    club.annual_event!
    club.start_date = Date.new(2017, 1, 8)
    club.end_date = Date.new(2018, 1, 8)

    assert_not club.validate_value("18", Date.new(2018, 04, 05))
  end

  test "validate_value annual event valid" do
    club = Club.new
    club.annual_event!
    club.start_date = Date.new(2017, 1, 8)
    club.end_date = Date.new(2020, 1, 8)

    assert club.validate_value("18", Date.new(2018, 04, 05))
  end

  test "validate_value yearly before end of year" do
    club = Club.new
    club.year!

    assert_not club.validate_value("18-19", Date.new(2018, 11, 01))
  end

  test "validate_value yearly invalid values" do
    club = Club.new
    club.year!

    assert_not club.validate_value("10-18", Date.new(2018, 01, 01))
    assert_not club.validate_value("19-18", Date.new(2018, 01, 01))
    assert_not club.validate_value("XX-XX", Date.new(2018, 01, 01))
  end

  test "validate_value yearly outside start/end date" do
    club = Club.new
    club.year!
    club.start_date = Date.new(1990, 07, 01)
    club.end_date = Date.new(2005, 05, 01)

    assert_not club.validate_value("17-18", Date.new(2018, 01, 01))
    assert_not club.validate_value("89-90", Date.new(2018, 01, 01))
    assert club.validate_value("90-91", Date.new(2018, 01, 01))
    assert club.validate_value("00-01", Date.new(2018, 01, 01))
  end

  test "validate_value yearly winter" do
    club = Club.new
    club.year!

    assert_not club.validate_value("17-18", Date.new(2018, 03, 01))
  end

  test "validate_value biannual event on the same semester" do
    conf = Config.create!(key: 'current_semester', value: 'H18')

    club = Club.new
    club.biannual_event!

    assert_not club.validate_value("H18")


    conf.destroy
  end

  test "validate_value biannual future/past event" do
    conf = Config.create!(key: 'current_semester', value: 'H18')

    club = Club.new
    club.biannual_event!

    assert_not club.validate_value("H20")
    assert_not club.validate_value("A20")

    assert club.validate_value("H99")
    assert club.validate_value("A98")

    conf.destroy
  end

  test "validate_value biannual invalid" do
    conf = Config.create!(key: 'current_semester', value: 'H18')

    club = Club.new
    club.biannual_event!

    assert_not club.validate_value("ASDF")
    assert_not club.validate_value("Z23")

    conf.destroy
  end

  test "validate_value biannual outside start/end date" do
    conf = Config.create!(key: 'current_semester', value: 'H18')

    club = Club.new
    club.biannual_event!
    club.start_date = Date.new(1990, 01, 01)
    club.end_date = Date.new(2015, 12, 01)

    assert_not club.validate_value("A16")

    conf.destroy
  end

  test "validate_value biannual edge" do
    conf = Config.create!(key: 'current_semester', value: 'H18')

    club = Club.new
    club.biannual_event!
    club.end_date = Date.new(2018, 01, 01)

    assert club.validate_value("A17")
    assert_not club.validate_value("H18")

    conf.destroy
  end
end
