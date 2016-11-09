# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'
require 'nokogiri'
require 'russian'

  # fill the 'regions' and the 'towns' tables from wikipedia 'Russian cities list' article
  page = Nokogiri::HTML(open('https://ru.wikipedia.org/wiki/%D0%A1%D0%BF%D0%B8%D1%81%D0%BE%D0%BA_%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%D0%BE%D0%B2_%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D0%B8'))

  trs = page.css('table tr')
  (2..1114).each do |tr_num|
    current_tr = trs[tr_num]
    town_name = current_tr.css('td')[2].text.gsub('Оспаривается','')
    region_name = current_tr.css('td')[3].text
    region = Region.find_by_name region_name
    region ||= Region.create name: region_name
    Town.create name: town_name, region_id: region.id
    Town.create name: town_name.gsub('ё', 'е'), region_id: region  if town_name.include? 'ё'
  end

  # fill the 'brands' and 'types' tables from 'auto.drom.ru' page
  Brand.create(name: 'all')
  page = Nokogiri::HTML(open('http://auto.drom.ru/'))
  links = page.css('div.selectCars_no_script-js-open strong a')
  links.each {|link| Brand.create(name: link.text)}
  Brand.create([{name: 'Chery'}, {name: 'Citroen'},  {name: 'Peugeot'}])
  brands = Brand.all.to_a
  brands.each do |brand|
    Type.create(name:'all', brand_id: brand.id)
    page = Nokogiri.HTML(open("http://auto.drom.ru/#{Russian.translit(brand.name)}/"))
    lines = page.css('div.selectCars_js_open h3')
    lines.each do |line|
      type = line.css('a').text
      line.at_css('a').content = ''
      count = line.text.lstrip.to_i
      Type.create(name: type, brand_id: brand.id) if count>=500
    end
  end

  #  adjust the 'brands' and 'types' tables in accordance with the names on 'avito.ru/rossiya/avtomobili' page

  Type.find_by_name('3-Series').update(synonym: '3 серия')
  Type.find_by_name('5-Series').update(synonym: '5 серия')
  Type.find_by_name('7-Series').update(synonym: '7 серия')
  Type.delete(Type.find_by_name 'Civic Ferio')
  Type.find_by_name('Civic').update(synonym: 'Civic Ferio')
  Type.find_by_name('Grand Starex').update(synonym: 'H-1 (Grand Starex)')
  Type.find_by_name('GS300').update(name: 'GS', synonym: 'GS300')
  Type.find_by_name('LX470').update(name: 'LX')
  Type.delete(Type.find_by_name 'LX570')
  Type.find_by_name('RX300').update(name: 'RX')
  Type.delete(Type.find_by_name 'RX330')
  Type.delete(Type.find_by_name 'RX350')
  Type.find_by_name('Mazda3').update(synonym: '3')
  Type.find_by_name('Mazda6').update(synonym: '6')
  Type.find_by_name('C-Class').update(synonym: 'C-класс')
  Type.find_by_name('E-Class').update(synonym: 'E-класс')
  Type.find_by_name('G-Class').update(synonym: 'G-класс')
  Type.find_by_name('GL-Class').update(synonym: 'GL-класс')
  Type.find_by_name('M-Class').update(synonym: 'M-класс')
  Type.find_by_name('S-Class').update(synonym: 'S-класс')
  Type.delete(Type.find_by_name 'Lancer Cedia')
  Type.find_by_name('Lancer').update(synonym: 'Lancer Cedia')
  Type.delete(Type.find_by_name 'Legacy B4')
  Type.find_by_name('Legacy').update(synonym: 'Legacy B4')
  Type.delete(Type.find_by_name 'Corolla Fielder')
  Type.find_by_name('Corolla').update(synonym: 'Corolla Fielder')
  Type.find_by_name('Буханка').update(synonym: '452 Буханка')
  Type.find_by_name('Патриот').update(synonym: 'Patriot')
  Type.find_by_name('Хантер').update(synonym: 'Hunter')
  Type.find_by_name('Tiggo').update(synonym: 'Tiggo (T11)')
  Type.find_by_name('2114').update(synonym: '2114 Samara')
  Type.find_by_name('2115').update(synonym: '2115 Samara')
  Type.find_by_name('4x4 2121 Нива').update(synonym: '4x4 (Нива)')
  Type.find_by_name('Веста').update(synonym: 'Vesta')
  Type.find_by_name('Гранта').update(synonym: 'Granta')
  Type.find_by_name('Калина').update(synonym: 'Kalina')
  Type.find_by_name('Приора').update(synonym: 'Priora ')


