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
  Region.delete_all
  Town.delete_all
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


  # fill the 'makes' and 'models' tables from 'auto.drom.ru' page
  Make.delete_all
  Model.delete_all
  Make.create(name: 'all')
  page = Nokogiri::HTML(open('http://auto.drom.ru/'))
  links = page.css('div.selectCars_no_script-js-open strong a')
  links.each {|link| Make.create(name: link.text)}
  Make.create([{name: 'Chery'}, {name: 'Citroen'},  {name: 'Peugeot'}])
  makes = Make.all.to_a
  makes.each do |make|
    Model.create(name:'all', make_id: make.id)
    page = Nokogiri.HTML(open("http://auto.drom.ru/#{Russian.translit(make.name)}/"))
    lines = page.css('div.selectCars_js_open h3')
    lines.each do |line|
      model = line.css('a').text
      line.at_css('a').content = ''
      count = line.text.lstrip.to_i
      Model.create(name: model, make_id: make.id) if count>=500
    end
  end

  #  adjust the 'makes' and 'models' tables in accordance with the names on 'avito.ru/rossiya/avtomobili' page

  Model.find_by_name('3-Series').try(:update_attributes,{synonym: '3 серия'})
  Model.find_by_name('5-Series').try(:update_attributes,{synonym: '5 серия'})
  Model.find_by_name('7-Series').try(:update_attributes,{synonym: '7 серия'})
  Model.delete(Model.find_by_name 'Civic Ferio')
  Model.find_by_name('Civic').try(:update_attributes,{synonym: 'Civic Ferio'})
  Model.find_by_name('Grand Starex').try(:update_attributes,{synonym: 'H-1 (Grand Starex)'})
  Model.find_by_name('GS300').try(:update_attributes,{name: 'GS', synonym: 'GS300'})
  Model.find_by_name('LX470').try(:update_attributes,{name: 'LX'})
  Model.delete(Model.find_by_name 'LX570')
  Model.find_by_name('RX300').try(:update_attributes,{name: 'RX'})
  Model.delete(Model.find_by_name 'RX330')
  Model.delete(Model.find_by_name 'RX350')
  Model.find_by_name('Mazda3').try(:update_attributes,{synonym: '3'})
  Model.find_by_name('Mazda6').try(:update_attributes,{synonym: '6'})
  Model.find_by_name('C-Class').try(:update_attributes,{synonym: 'C-класс'})
  Model.find_by_name('E-Class').try(:update_attributes,{synonym: 'E-класс'})
  Model.find_by_name('G-Class').try(:update_attributes,{synonym: 'G-класс'})
  Model.find_by_name('GL-Class').try(:update_attributes,{synonym: 'GL-класс'})
  Model.find_by_name('M-Class').try(:update_attributes,{synonym: 'M-класс'})
  Model.find_by_name('S-Class').try(:update_attributes,{synonym: 'S-класс'})
  Model.delete(Model.find_by_name 'Lancer Cedia')
  Model.find_by_name('Lancer').try(:update_attributes,{synonym: 'Lancer Cedia'})
  Model.delete(Model.find_by_name 'Legacy B4')
  Model.find_by_name('Legacy').try(:update_attributes,{synonym: 'Legacy B4'})
  Model.delete(Model.find_by_name 'Corolla Fielder')
  Model.find_by_name('Corolla').try(:update_attributes,{synonym: 'Corolla Fielder'})
  Model.find_by_name('Буханка').try(:update_attributes,{synonym: '452 Буханка'})
  Model.find_by_name('Патриот').try(:update_attributes,{synonym: 'Patriot'})
  Model.find_by_name('Хантер').try(:update_attributes,{synonym: 'Hunter'})
  Model.find_by_name('Tiggo').try(:update_attributes,{synonym: 'Tiggo (T11)'})
  Model.find_by_name('2114').try(:update_attributes,{synonym: '2114 Samara'})
  Model.find_by_name('2115').try(:update_attributes,{synonym: '2115 Samara'})
  Model.find_by_name('4x4 2121 Нива').try(:update_attributes,{synonym: '4x4 (Нива)'})
  Model.find_by_name('Веста').try(:update_attributes,{synonym: 'Vesta'})
  Model.find_by_name('Гранта').try(:update_attributes,{synonym: 'Granta'})
  Model.find_by_name('Калина').try(:update_attributes,{synonym: 'Kalina'})
  Model.find_by_name('Приора').try(:update_attributes,{synonym: 'Priora '})


