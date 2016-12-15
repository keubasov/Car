class ParserTest < ActiveSupport::TestCase
require 'parser'
  test 'should return ad' do
    table = Nokogiri::HTML "<table><tr data-row-as-link='1' data-bull-id='23057325' data-index='15' data-is-sticky='0' data-is-up='1' class='row'>
                          <td><center><nobr><a href='http://omsk.drom.ru/toyota/premio/23057325.html'>15-12</a></nobr><a href='http://www.drom.ru/sms/#up'><img class='upped' src='http://c.rdrom.ru/img/up.gif' width='11' height='12' title='Поднято наверх'></a></center></td>
                          <td class='c_i b-tableCell'>
                              <a name='15'></a>                    <a class='b-tableCell__link' href='http://omsk.drom.ru/toyota/premio/23057325.html'>
                                                                                          <div class='picContainer'>
                                          <img width='220' height='165' src='http://s.auto.drom.ru/i24200/s/photos/23058/23057325/ttn_220_180575746.jpg' srcset='http://s.auto.drom.ru/i24200/s/photos/23058/23057325/ttn_440_180575746.jpg 2x,http://s.auto.drom.ru/i24200/s/photos/23058/23057325/ttn_660_180575746.jpg 3x' onerror='try{this.src='http://c.rdrom.ru/sales/nottn_0.svg';}catch(e){}'>
                                          <div title='Объявление находится в Избранном' class='for-sticker-favorite' data-bull-id='23057325'></div>
                                                                      </div>
                                                      </a>
                          </td>
                          <td class='c_n f14 b-tableCell'>
                                                  <a class='b-tableCell__link' href='http://omsk.drom.ru/toyota/premio/23057325.html'>

                                  <b>Toyota Premio</b>                                                    <br>2006
                                                      </a>
                                          </td>
                                          <!--<td class='f14'></td>-->
                          <td class='b-tableCell'>
                                                  <a class='b-tableCell__link' href='http://omsk.drom.ru/toyota/premio/23057325.html'>
                                                      1.8 л                                                    <span class='gray' style='white-space: nowrap;'>(132 л.с.)</span><br>                                                                бензин<br>                    автомат<br>                    передний<b>
                                                  </b></a><b>
                                          </b></td>
                          <td class='b-tableCell'>
                                                  <a class='b-tableCell__link' href='http://omsk.drom.ru/toyota/premio/23057325.html'>
                              170
                                                  </a>
                                          </td>
                          <td class='b-tableCell'>
                                                  <a class='b-tableCell__link' href='http://omsk.drom.ru/toyota/premio/23057325.html'>
                                  <center></center>
                                                      </a>
                                          </td>
                          <td class='b-tableCell'>
                                                  <a class='b-tableCell__link' href='http://omsk.drom.ru/toyota/premio/23057325.html'>
                                                              <span class='f14'>510 000 руб.</span><br>
                                  <span style='color: #808080'>Kalachinsk</span>
                                                      </a>
                                          </td>
                      </tr></table>"
                      @tr = table.css('tr')[0]
    @parser = Parser.new
    ad = @parser.send(:parse_tr, @tr)
    assert_equal Date.new(2016,12,15), ad.date
    assert_equal 510000, ad.price
    assert_equal 2006, ad.year
    assert_equal 'Toyota', ad.make
    assert_equal 'Premio', ad.model
    assert_equal regions(:omsk).id, ad.region_id
    assert_equal 23057325, ad.site_id
    assert_equal 'http://omsk.drom.ru/toyota/premio/23057325.html', ad.link
  end

end


