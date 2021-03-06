class Contact < ActiveRecord::Base

  include HTTParty

  def self.all!(token, email)

    headers = { "Authorization" => "Bearer " + token, "GData-Version" => "3.0" }

    response = HTTParty.get("https://www.google.com/m8/feeds/contacts/#{email}/full?max-results=100", :headers => headers)

    gmail_xml = Nokogiri::XML(response)

    collect_xml_data(gmail_xml)

  end

  def self.collect_xml_data(xml)
    contacts = []

    xml.css("entry").each do |entry|

      name = entry.css("gd|fullName").text

      email = !entry.css('gd|email').empty? ? entry.css('gd|email').attribute('address').text : ""

      phone = entry.css("gd|phoneNumber").text

      contact = {
        :name => name,
        :email => email,
        :phone => phone,
      }

      contacts << contact

    end

    return contacts
  end


end
