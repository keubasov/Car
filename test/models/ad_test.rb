require 'test_helper'

class AdTest < ActiveSupport::TestCase

  test 'should save' do
    ad= Ad.new(date: Date.today, price: 100000, year: 2002, make: 'lada', model: 'granta', site_id: 232, link: 'http://drom.ru/lada_granta.html', region_id: 200)
    assert ad.save
  end
  test 'should not save ad without date' do
    ad= Ad.new(price: 100000, year: 2002, make: 'lada', model: 'granta', site_id: 232, link: 'http://drom.ru/lada_granta.html', region_id: 200)
    assert_not ad.save, 'Saved the ad without a date'
  end
  test 'should not save ad without price' do
    ad= Ad.new(date: Date.today, year: 2002, make: 'lada', model: 'granta', site_id: 232, link: 'http://drom.ru/lada_granta.html', region_id: 200)
    assert_not ad.save, 'Saved the ad without a price'
  end
  test 'should not save ad without year' do
    ad= Ad.new(date: Date.today, price: 100000, make: 'lada', model: 'granta', site_id: 232, link: 'http://drom.ru/lada_granta.html', region_id: 200)
    assert_not ad.save, 'Saved the ad without an year'
  end
  test 'should not save ad without make' do
    ad= Ad.new(date: Date.today, price: 100000, year: 2002, model: 'granta', site_id: 232, link: 'http://drom.ru/lada_granta.html', region_id: 200)
    assert_not ad.save, 'Saved the ad without a make'
  end
  test 'should not save ad without model' do
    ad= Ad.new(date: Date.today, price: 100000, year: 2002, make: 'lada', site_id: 232, link: 'http://drom.ru/lada_granta.html', region_id: 200)
    assert_not ad.save, 'Saved the ad without a model'
  end
  test 'should not save ad without site_id' do
    ad= Ad.new(date: Date.today, price: 100000, year: 2002, make: 'lada', model: 'granta', link: 'http://drom.ru/lada_granta.html', region_id: 200)
    assert_not ad.save, 'Saved the ad without a site_id'
  end
  test 'should not save ad without link' do
    ad= Ad.new(date: Date.today, price: 100000, year: 2002, make: 'lada', model: 'granta', site_id: 232, region_id: 200)
    assert_not ad.save, 'Saved the ad without a link'
  end
  test 'should not save ad without region_id' do
    ad= Ad.new(date: Date.today, price: 100000, year: 2002, make: 'lada', model: 'granta', site_id: 232, link: 'http://drom.ru/lada_granta.html')
    assert_not ad.save, 'Saved the ad without a region_id'
  end
end
