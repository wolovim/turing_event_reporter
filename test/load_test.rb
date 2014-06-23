require "./test/test_helper"

require './lib/loader'

class LoadTest < Minitest::Test

  def test_it_loads_a_file_by_default
    loader = Loader.new
    assert loader
  end

  def test_it_loads_a_custom_csv
    loader = Loader.new('./data/event_attendees2.csv')
    assert loader
  end

  def test_it_instatiates_unique_csvs
    loader = Loader.new
    loader2 = Loader.new('./data/event_attendees2.csv')
    refute_equal loader, loader2
  end

  # def test_it_prints_rows
  #   loader = Loader.new('./data/fixtures/fake.csv')
  #   assert_equal "Paul", loader.clean_people
  # end

  def test_it_cleans_zipcodes
    loader = Loader.new
    data = {zipcode: "7306"}
    assert_equal "07306", loader.clean_zipcode(data)
  end

  def test_it_cleans_phone_numbers
    loader = Loader.new
    data = {homephone: "(321- )1231234"}
    assert_equal "(321) 123-1234", loader.clean_phone_numbers(data)
  end

  def test_it_handles_garbage_phone_numbers
    loader = Loader.new
    data = {homephone: "9.82E+00"} #if not 10 digits, then rjust with 0's
    assert_equal "(000) 009-8200", loader.clean_phone_numbers(data)
  end

  def test_it_cleans_first_names
    loader = Loader.new
    data = {first_name: "paul"}
    assert_equal "Paul", loader.clean_first_name(data)
  end

  def test_it_cleans_last_names
    loader = Loader.new
    data = {last_name: "fulghum"}
    assert_equal "Fulghum", loader.clean_last_name(data)
  end

  def test_it_cleans_city
    loader = Loader.new
    data = {city: "DeNvEr"}
    assert_equal "Denver", loader.clean_city(data)
  end

  def test_it_cleans_street
    loader = Loader.new
    data = {street: "1510 blakE st. uncw station"}
    assert_equal "1510 Blake St. Uncw Station", loader.clean_street(data)
  end

  def test_parse_method_creates_a_person_object
    loader = Loader.new('./data/fixtures/fake.csv')
    loader.clean_people
    assert_equal 1, loader.queue.length
  end

  def test_find_by_first_name
    loader = Loader.new('./data/fixtures/fake.csv')
    loader.clean_people
    selected = loader.find_by(:first_name, "Paul")
    assert_equal "Paul", selected.current_queue.first[:first_name]
  end

  def test_find_by_last_name
    loader = Loader.new('./data/fixtures/fake.csv')
    loader.clean_people
    selected = loader.find_by(:last_name, "Fulghum")
    assert_equal "Fulghum", selected.current_queue.first[:last_name]
  end

end
