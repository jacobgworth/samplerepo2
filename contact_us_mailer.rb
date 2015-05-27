class ContactUsMailer < ActionMailer::Base
    helper :application
  #"info@mohhaiti.org"
  def church_partner(data)
    #change this to churchpartnerships@mohhaiti.org after testing
    @data = data
    
    @txtname = @data[:txtname]
    @txtphone = @data[:txtphone]
    @txtemail = @data[:txtemail]
    @txtaddress = @data[:txtaddress]
    @txtcity = @data[:txtcity]
    @txtstate = @data[:txtstate]
    @txtzip = @data[:txtzip]
    @txtchurchname = @data[:txtchurchname]
    @txtchurchaddress = @data[:txtchurchaddress]
    @txtchurchcity = @data[:txtchurchcity]
    @txtchurchstate = @data[:txtchurchstate]
    @txtchurchzip = @data[:txtchurchzip]
    @txtchurchwebsite = @data[:txtchurchwebsite]
    @txtpastorname = @data[:txtpastorname]
    @txtpastorphone = @data[:txtpastorphone]
    @txtmissionname = @data[:txtmissionname]
    @txtmissionphone = @data[:txtmissionphone]
    @txtcomments = @data[:txtcomments]
    @txtprefs = @data[:txtprefs]
    
    mail(:to => "drew@mohhaiti.org", :subject => "Church Partnership Inquiry", :from => @txtemail)
  end
  
   def createproject_mail(data)
    
    @data = data

    @txtname = @data[:txtname]
    @txtemail = @data[:txtemail]
    @txtdates = @data[:txtdates]
    @tname = @data[:tname]
    @txtleader = @data[:txtleader]
    @txttree = @data[:txttree]
    @txtsolar = @data[:txtsolar]
    @txtwater = @data[:txtwater]
    @txtgoats = @data[:txtgoats]
    @txtkids = @data[:txtkids]
    @txthouse = @data[:txthouse]
    @txtroof = @data[:txtroof]
    @txtlatrine = @data[:txtlatrine]
    @txtbuild = @data[:txtbuild]

    mail(:to => "jacob@fusionbible.com", :subject => "TEST", :from => "no-reply@mohhaiti.org")
  end

  def contact_us_mail(data,msgbody)
    
    @data = data
    
    @msgbody = msgbody#@data[:bodym]
    @fromaddress = @data[:fromaddress]
    @emailsubject = @data[:subject]
    @name = @data[:name]
    @phone = @data[:phone]
    mail(:to => "info@mohhaiti.org", :subject => @emailsubject, :from => @fromaddress)
  end
  
  def sponsorship_contact(data)
     
    @data = data
    
    @childpreferences = @data[:childpreferences]
    @fname = @data[:fname]
    @phone = @data[:phone]
    @fromaddress = @data[:fromaddress]
    @streetaddress = @data[:streetaddress]
    @city = @data[:city]
    @state = @data[:state]
    @zip = @data[:zip]  
    
    #mail(:to => "jesse@threetwelvecreative.com", :subject => "Child Sponsorship Inquiry", :from => @fromaddress)
    mail(:to => "sponsorship@mohhaiti.org, donna@mohhaiti.org", :subject => "Child Sponsorship Inquiry", :from => @fromaddress)
  end
  
  def sponsorship_thankyou(data)
    @email = data[:fromaddress]
    puts("hit here")
    mail(:to => @email, :subject => "Child Sponsorship Inquiry", :from => "sponsorship@mohhaiti.org")
  end
  
  def write_child(data)
    #change this to sponsorship@mohhaiti.org after testing
    
    @data = data
    
    @fname = @data[:fname]
    @phone = @data[:phone]
    @fromaddress = @data[:fromaddress]
    @bodym = @data[:bodym]
    @childname = @data[:childname]
    @childnumber = @data[:childnumber]
    @attachment = @data[:attachment]
    if !@attachment.nil?
      attachments[@attachment.original_filename] = @attachment.read
    end
    @sendto = "Brittany@mohhaiti.org"
    #@sendto = "jesse@threetwelvecreative.com"
    
    mail(:to => @sendto, :subject => "Write My Child", :from => @fromaddress)
  end

  def write_child_confirmation(data)
    
    @data = data
    
    @fname = @data[:fname]
    @phone = @data[:phone]
	@sendto = @data[:fromaddress]
    @bodym = @data[:bodym]
    @childname = @data[:childname]
    @childnumber = @data[:childnumber]
    @attachment = @data[:attachment]
    if !@attachment.nil?
      attachments[@attachment.original_filename] = @attachment.read
    end
    @fromaddress = "Brooke@mohhaiti.org"
    #@sendto = "jesse@threetwelvecreative.com"
    
    mail(:to => @sendto, :subject => "Write My Child", :from => @fromaddress)
  end

  def take_a_medical_trip(data)
    #change this to medical@mohhaiti.org after testing
    
    @data = data
    
    @fullname = @data[:fname]
    @phone = @data[:phone]
    @fromaddress = @data[:fromaddress]
    @comments = @data[:comments]
    @license = @data[:license]
    @toemail = "medical@mohhaiti.org"
    #@toemail = "david@threetwelvecreative.com" #testing
    
    mail(:to => @toemail, :subject => "Take a Medical Mission Trip", :from => @fromaddress)
  end



  
  def take_a_trip(data)
    #change this to missiontrips@mohhaiti.org after testing
    
    @data = data
    
    @fullname = @data[:fname]
    @phone = @data[:phone]
    @fromaddress = @data[:fromaddress]
    @comments = @data[:comments]
    #@medical = @data[:medical]
    @toemail = "missiontrips@mohhaiti.org"
    #@toemail = "david@threetwelvecreative.com" #testing
    
    mail(:to => @toemail, :subject => "Take a Mission Trip", :from => @fromaddress)
  end
  
  def volunteer(data)
    #change this to info@mohhaiti.org after testing
    
    @data = data
    
    @txtname = @data[:txtname]
    @txtphonenumber = @data[:txtphonenumber]
    @txtemail = @data[:txtemail]
    @txtmessage = @data[:txtmessage]
    
    @frizzle = @data[:txtname]
    
    mail(:to => "info@mohhaiti.org", :subject => "MOH Volunteer", :from => @txtemail)
  end
  
  def vision_trip(data)
    #change this to churchpartnerships@mohhaiti.org after testing
    
    @data = data
    
    @txtfirst = @data[:txtfirst]
    @txtlast = @data[:txtlast]
    @txtphone = @data[:txtphone]
    @txtemail = @data[:txtemail]
    @txtchurch = @data[:txtchurch]
    @txtcity = @data[:txtcity]
    @txtstate = @data[:txtstate]
    @txtzip = @data[:txtzip]
    @txtmessage = @data[:txtmessage]
    @txtdatesinterested = @data[:txtdatesinterested]
    
    mail(:to => "drew@mohhaiti.org", :subject => "Vision Trip Information", :from => @txtemail)
  end
  
  
  
end
