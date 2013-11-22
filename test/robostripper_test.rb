require 'minitest/autorun'
require 'robostripper'

class YellowPage < Robostripper::Resource
end
YellowPage.add_item :details do
  phone "p.phone"
  street ".street-address"
  city { scan(".city-state").split(",")[0] }
  state { scan(".city-state").split(",")[1].scan(/[A-Z]{2}/)[0] }
  zip { scan(".city-state").split(",")[1].scan(/\d{5}/)[0] }
  address { [ street, city, state, zip ].join(" ") }
  payments { scan(".payment").split(",").map(&:strip) }
end

class RobostripperTest < MiniTest::Test
  def test_http_headers
    headers_hash = Robostripper::HTTP::HEADERS
    assert_equal %w(Accept Accept-Charset Accept-Language User-Agent), headers_hash.keys
    assert headers_hash["User-Agent"] =~ /Mozilla/
  end

  def test_yellowpage_resource_example
    url = "http://www.yellowpages.com/silver-spring-md/mip/quarry-house-tavern-3342829"
    yp = YellowPage.new(url)
    assert_equal "(301) 587-8350", yp.details.phone
    assert_equal "8401 Georgia Ave", yp.details.street
    assert_equal "Silver Spring", yp.details.city
    assert_equal "MD", yp.details.state
    assert_equal "20910", yp.details.zip
    assert_equal "8401 Georgia Ave Silver Spring MD 20910", yp.details.address
    assert_equal ["master card", "discover", "amex", "visa"], yp.details.payments
  end
end
