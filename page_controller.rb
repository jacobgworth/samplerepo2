class PageController < ApplicationController
  localComm = Community
  localuser = User
  include Databasedotcom::Rails::Controller
  Community = localComm
  localuser = User
  
  def about_haiti
    @title = "Haiti Facts: Information About Haiti & Haiti Now"
    @meta = "Facts about Haiti and information about Haiti's culture, population, geography, climate, and what's happening there now."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def about_us
    @title = "About Mission of Hope, Haiti (MOH)"
    @meta = "Mission of Hope's primary efforts are focused on Church Advancement, Education, Orphan care, Medical care, Nutrition, Disaster Relief, and HaitiOne."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end

  def archived_interns
    @interns = Intern.where("is_archived=true").order("created_at desc")
    @isadmin = is_admin_user?
    unless @isadmin
      redirect_to "/" and return
    end

    respond_to do |format|
      format.html {render :layout=>"homeLayout"}
      format.csv #{ send_data @interns.as_csv }
      format.json { render json: @interns }
    end

  end
  
  def be_a_partner
    @title = "Become a Mission of Hope, Haiti Partner of Hope"
    @meta = "What does it mean to be a partner of hope? Find out how you can become a partner of hope with Mission of Hope, Haiti."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end 
  
  def caprojects
    @title = "Special Project for Missionaries"
    @meta = "Choose a special project to work on while on your mission trip with Mission of Hope, Haiti."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end 

  
  def console
    unless is_admin_user?
      respond_to do |format|
        format.html { redirect_to "/" }
      end
    else
      @user = current_user if current_user
      
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}# console.html.erb
      end
    end
  end
  
  def church_partner
     @title = "Mission of Hope, Haiti: Church Partnerships"
    @meta = "Learn about Mission of Hope, Haiti Church Partnership opportunities and how your church can partner with us to help local villages in Haiti."
    @txtname = params[:txtname]
    @txtphone = params[:txtphonenumber]
    @txtemail = params[:txtemail]
    @txtaddress = params[:txtaddress]
    @txtcity = params[:txtcity]
    @txtstate = params[:txtstate]
    @txtzip = params[:txtzip]
    @txtchurchname = params[:txtchurchname]
    @txtchurchaddress = params[:txtchurchaddress]
    @txtchurchcity = params[:txtchurchcity]
    @txtchurchstate = params[:txtchurchstate]
    @txtchurchzip = params[:txtchurchzip]
    @txtchurchwebsite = params[:txtchurchwebsite]
    @txtpastorname = params[:txtpastorname]
    @txtpastorphone = params[:txtpastorphone]
    @txtmissionname = params[:txtmissionname]
    @txtmissionphone = params[:txtmissionphone]
    @txtcomments = params[:txtcomments]
    @prefs = " "
    if !params[:chkadvocate].nil?
      @prefs = @prefs + "Advocate,"
    end
    if !params[:chkambassador].nil?
      @prefs = @prefs + "Ambassador,"
    end
    if !params[:chkanchor].nil?
      @prefs = @prefs + "Anchor"
    end
    if !@txtname.nil? && @txtname != '' 
      @isvalid = true
      @data = {
        :txtname => @txtname,
        :txtphone => @txtphone,
        :txtemail => @txtemail,
        :txtaddress => @txtaddress,
        :txtcity => @txtcity,
        :txtstate => @txtstate,
        :txtzip => @txtzip,
        :txtchurchname => @txtchurchname,
        :txtchurchaddress => @txtchurchaddress,
        :txtchurchcity => @txtchurchcity,
        :txtchurchstate => @txtchurchstate,
        :txtchurchzip => @txtchurchzip,
        :txtpastorname => @txtpastorname,
        :txtpastorphone => @txtpastorphone,
        :txtmissionname => @txtmissionname,
        :txtmissionphone => @txtmissionphone,
        :txtchurchwebsite => @txtchurchwebsite,
        :txtprefs => @prefs,
        :txtcomments => @txtcomments
      }
      respond_to do |format|
        ContactUsMailer.church_partner(@data).deliver
        format.html {render :layout=>"homeLayout"}# three_cords.html.erb
      end
    else
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}# three_cords.html.erb
      end
    end
  end
  
  def clinic
     @title = "Haiti Health Clinic of Hope: Medical Care for Haitians"
    @meta = "The MOH Haiti Health Clinic of Hope provides much needed medical care for Haitians. It offers a pharmacy, lab, dentist facility, urgent care and an operating room."
     @category = Category.find_by_categoryname("Health Care")
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def communities_impacted
    @category = Category.find_by_categoryname("Church Advancement")
    @villages = Community.joins(:projects => :categories).where("category_id=" + @category.id.to_s)
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# communities_impacted.html.erb
    end
  end
  
  def community_health
     @title = "Haiti Health Program: Disease Prevention & Hygiene Education"
    @meta = "The Haiti Community Health Program works to provide Haitians with health education, prevent the spread of disease and sickness, as well as teach about hygiene."
     @category = Category.find_by_categoryname("Health Care")
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end

  def createproject
    @title = "Create Your Project"
    @txtname = params[:txtname]
    @txtemail = params[:txtemail]
    @txtdates = params[:txtdates]
    @tname = params[:tname]
    @txtleader = params[:txtleader]
    @txttree = params[:txttree]
    @txtsolar = params[:txtsolar]
    @txtwater = params[:txtwater]
    @txtgoats = params[:txtgoats]
    @txtkids = params[:txtkids]
    @txthouse = params[:txthouse]
    @txtroof = params[:txtroof]
    @txtlatrine = params[:txtlatrine]
    @txtbuild = params[:txtbuild]
    @totalPrice = params[:totalPrice]
     if !@txtname.nil? && @txtname != '' && !@txtemail.nil? && @txtemail != "" && (params[:formname].nil? || params[:formname].empty?)
      @isvalid = true
      @data = {
        :txtname => @txtname,
        :txtemail => @txtemail,
        :txtdates => @txtdates,
        :tname => @tname,
        :txtleader => @txtleader,
        :txttree => @txttree,
        :txtsolar => @txtsolar,
        :txtwater => @txtwater,
        :txtgoats => @txtgoats,
        :txtkids => @txtkids,
        :txthouse => @txthouse,
        :txtroof => @txtroof,
        :txtlatrine => @txtlatrine,
        :txtbuild => @txtbuild,
      }

      ContactUsMailer.createproject_mail(@data).deliver
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}
      end
    else
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}
      end
    end
  end

  
  def contact_us
     @title = "Contact Mission of Hope, Haiti"
    @meta = "How to contact Mission of Hope, Haiti by mail, phone or fax. Contact us at our U.S. Office or Haiti office."
    @name = params[:name]
    @body = params[:letter]
    @subject = params[:topics]
    @fromaddress = params[:email]
    @phone = params[:phonenumber]
    if !@name.nil? && !@body.nil? && !@subject.nil? && !@fromaddress.nil? && !@phone.nil?
      @isvalid = true
      @data = {
        :name => @name, 
        :fromaddress => @fromaddress, 
        :subject => @subject, 
        :bodym => @body,
        :phone => @phone
      }
    end
    if @isvalid
      ContactUsMailer.contact_us_mail(@data,@body).deliver
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
      end
    else
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
      end
    end
  end
  
  def denari
    respond_to do |format|
      format.html { render :layout=>"homeLayout"}
    end
  end
  
  def downloads
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def edit_user_information
    unless is_admin_user?
      respond_to do |format|
        format.html { redirect_to "/" }
      end
    else
      @user = current_user if current_user
      
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}# console.html.erb
      end
    end
  end
    
  def education
     @title = "Haiti Education Projects & Solutions from (MOH)"
    @meta = "MOH Haiti education projects consist of building schools to ensure that every child has the opportunity for an excellent education."
    @category = Category.find_by_categoryname("Education")
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    @villages = Community.joins(:projects=>:categories).where("category_id=?",@category.id.to_s)
    
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# orphan_care.html.erb
    end
  end
  
  def event
     @title = "Haiti Fundraising Events | Mission of Hope, Haiti (MOH)"
    @meta = "Mission of Hope, Haiti always has fundraising for Haiti events happening. Find a local event near you or start one of your own to raise support and donations for Haiti!"
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def faq
     @title = "Mission of Hope, Haiti Frequently Asked Questions (FAQs)"
    @meta = "Most frequently asked questions about Mission of Hope, Haiti from our supporters and donors."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end 
  
  def financial_info
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def find_user_id_by_email
    @thisuser = User.where("lower(email)=?",params[:email].downcase)
    render layout: false and return
  end
  
  def gift_store
    @title = "Mission of Hope, Haiti Child Sponsorship Gift Store"
    @meta = "Send your MOH sponsored child a gift for their birthday or Christmas through the Mission of Hope, Haiti sponsored child gift store."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def haiti_one
    @title = "MOH HaitiOne Ministry: Uniting Missions & Organizations in Haiti"
    @meta = "HaitiOne unites organizations based in Haiti with the goal of working together to meet the physical, social, mental and spiritual restoration in the nation of Haiti."
    @category = Category.find_by_categoryname("Haiti One")
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def health_care
    @title = "Haiti Health & Medical Care Projects from Mission of Hope, Haiti (MOH)"
    @meta = "MOH Haiti health care projects consist of raising health standards and relieving suffering through community health, medical care, sanitation, and mobile clinics."
    @category = Category.find_by_categoryname("Health Care")
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    
    @jason = @projects.to_gmaps4rails
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# health_care.html.erb
    end
  end
  
  def image_submit
    @image = params[:files][0]
    @project = Project.find_by_projectname(params[:project][:projectname])
    @tessa = Asset.create(:asset=>@image, :project=>@project)
    @tessa.save()
    @url = @tessa.asset.to_s
    respond_to do |format|
      format.json { render json: {:url=>@tessa.asset.to_s}.to_json }
    end
  end
  
  def intern_application
    @title = "Submit and appliation to intern with Mission of Hope, Haiti"
    @meta = "Use our online intern application to apply for an internship at Mission of Hope, Haiti."
    @fname = params[:fname]
    @lname = params[:lname]
    @comments = params[:letter]
    @fromaddress = params[:email]
    @phone = "0000000000"
    #@medical = params[:childnumber]
    @street = params[:street]
    @city = params[:city]
    @state = params[:state]
    @zip = params[:zip]
    @church = params[:church]
    @organization = params[:organization]
    @participants = params[:participants].to_i
    if !@fname.nil? && @fname != "" && !@fromaddress.nil? && @fromaddress != "" && (params[:formname].nil? || params[:formname].empty?)
      @isvalid = true
      @data = {
        :fname => @fname,
        :lname => @lname, 
        :fromaddress => @fromaddress, 
        :comments => @comments,
        :phone => @phone,
        #:medical => @medical,
        :address => @street,
        :city => @city,
        :state => @state,
        :zip => @zip,
        :church => @church,
        :org => @organization,
        :participants => @participants,
        :month => params[:trip_month]
      }
      ContactUsMailer.take_a_trip(@data).deliver
      #Save contact to convio
      @sfcontact = Contact.find_by_Email(params[:email])
      if @sfcontact.nil?
        @sfcontact = create_convio_contact(params[:lname], params[:fname], params[:email])
        @sfcontact = Contact.find_by_Id(@sfcontact.Id)
        @sfcontact.MailingStreet = @street
        @sfcontact.MailingCity = @city
        @sfcontact.MailingState = @state
        @sfcontact.MailingPostalCode = @zip
      end
      @sfcontact.MT_Prospect_Status__c = "Prospect"
      @sfcontact.MyMOH_Church__c = @church
      @sfcontact.Organization__c = @organization
      @sfcontact.Number_of_Trip_Participants__c = @participants
      @sfcontact.Ideal_Trip_Month__c = params[:trip_month]
      @sfcontact.save
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}
      end 
    else
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}
      end
    end
  end
  
  def intern_thank_you
    respond_to do |format|
        format.html {render :layout=>"homeLayout"}
      end
  end
  
  def internships
    @title = "Haiti Ministry Internships | Internships at Mission of Hope, Haiti (MOH)"
    @meta = "Mission of Hope, Haiti offers internships to students who have a heart for Haiti and for Christ. Learn more about being an intern MOH Haiti!"
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def join_our_team
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def learn_sponsor
    @title = "Mission of Hope, Haiti (MOH) Child & Orphan Sponsorship"
    @meta = "Learn about the Mission of Hope, Haiti child sponsorship program for students and orphans who need your help."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def make_donation
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def medical_mission_trips
    @title = "Medical Mission Trips to Haiti: Mission of Hope, Haiti Medical Missions"
    @meta = "If you're a licensed medical professional  (nurse, doctor, CNA, EMT, RN, PA, NP, MD, PT, OT) we would love for you to take a medial mission trip to help the people of Haiti."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def meet_our_staff
    @title = "Mission of Hope, Haiti (MOH) Staff"
    @meta = "Meet the staff of Mission of Hope, Haiti and learn about their roles at MOH."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
   def meal_packing
    @title = "Meal Packing"
    @user = current_user
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}
    end
  end 

  def mission_trips
    @title = "Haiti Missions Trips: Take A Missions Trip to Haiti With MOH"
    @meta = "Haiti Missions trips are great ways for Christian families, groups, youth, or adults to get involved with Haiti. Take a short-term missions with MOH today."
    @user = current_user
    @experiences = Experience.last(5)
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}
    end
  end 
  
  def mission_trip_experinces
    @title = "MOH Mission Trip Stories & Experiences: Stories from Mission Trips to Haiti"
    @meta = "Read real stories and experiences from people who have gone on a Mission trip to Haiti with Mission of Hope, Haiti. Plus share your own mission trip story!"
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
   
  def mwen_kapab
    @title = "Mwen Kapab: A Christian Curriculum to Educate Haiti"
    @meta = "MOH Haiti offers a Christian curriculum providing Haitians with an education from Kindergarten through High School. The curriculum is academically excellent and Biblically integrated."
    @category = Category.find_by_categoryname("Education")
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    @villages = Community.joins(:projects=>:categories).where("category_id=?",@category.id.to_s)
    
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def orphan_sponsorship
    @title = "Village of Hope"
    @meta = "Sponsor an orphan at Village of Hope."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def newsletter_thank_you
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}
    end
  end
  
  def nutrition
    @title = "Haiti Food Distribution Program: Stopping Malnutrition in Haitians"
    @meta = "The MOH Food Distribution program allows us to provide nutritious meals to Haitians with the help of our partners. Learn how we're stopping malnutrition in Haitian children."
    @category = Category.find_by_categoryname("Nutrition")
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# nutrition.html.erb
    end
  end
  
  def orphan_care
    @title = "Village of Hope Orphanage in Haiti | Haitian Orphan Care at Mission of Hope"
    @meta = "65 children call the Village of Hope orphanage their home. Mission of Hope is providing these orphans with a loving home, nutrition and education and how you can help us."
    @category = Category.find_by_categoryname("Orphanage")
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    
    @jason = @projects.to_gmaps4rails
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# orphan_care.html.erb
    end
  end
  
  def our_story
    @title = "The History & Beliefs of Mission of Hope, Haiti"
    @meta = "Learn about the history of Mission of Hope, Haiti, founded in 1998 and what our belief system is. It all started in 1977 with Sharon Johnson's trip to Haiti to direct a choir."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end

  def partner_of_hope
    @title = "Become a Mission of Hope, Haiti Partner of Hope"
    @meta = "What does it mean to be a partner of hope? Find out how you can become a partner of hope with Mission of Hope, Haiti."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def preparing_for_mission_trips
    @title = "Preparing for a Mission Trip to Haiti with Mission of Hope, Haiti (MOH)"
    @meta = "How do you prepare to take a missions trip to Haiti? Make sure you have your passport, immunizations and proper clothes. Read more about what you'll need."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def press
    @title = "Press Releases & News about Mission of Hope, Haiti"
    @meta = "See the latest press releases and news stories from Mission of Hope, Haiti."
    @press = News.find(:all, :order => "postdate desc")
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def privacy
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
   
  
  def prosthetics
    @title = "MOH Prosthetics Lab: Orthotic & Prosthetic Limbs for Haiti Amputees"
    @meta = "Haiti amputees can receive the limbs they need from the Prosthetic Lab at MOH. The lab provides Haitian amputees with prosthetic legs, orthotic arms and more."
     @category = Category.find_by_categoryname("Health Care")
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
   
  def request_info
    @title = "Request Information About MOH Haiti Mission Trips"
    @meta = "Use our easy request information form to receive more information on taking a short-term mission trip with Mission of Hope, Haiti."
    @fname = params[:fname]
    @lname = params[:lname]
    @comments = params[:letter]
    @fromaddress = params[:email]
    @phone = "0000000000"
    #@medical = params[:childnumber]
    @street = params[:street]
    @city = params[:city]
    @state = params[:state]
    @zip = params[:zip]
    @church = params[:church]
    @organization = params[:organization]
    @participants = params[:participants].to_i
    if !@fname.nil? && @fname != "" && !@fromaddress.nil? && @fromaddress != "" && (params[:formname].nil? || params[:formname].empty?)
      @isvalid = true
      @data = {
        :fname => @fname,
        :lname => @lname, 
        :fromaddress => @fromaddress, 
        :comments => @comments,
        :phone => @phone,
        #:medical => @medical,
        :address => @street,
        :city => @city,
        :state => @state,
        :zip => @zip,
        :church => @church,
        :org => @organization,
        :participants => @participants,
        :month => params[:trip_month]
      }
      ContactUsMailer.take_a_trip(@data).deliver
      #Save contact to convio
      @sfcontact = Contact.find_by_Email(params[:email])
      if @sfcontact.nil?
        @sfcontact = create_convio_contact(params[:lname], params[:fname], params[:email])
        @sfcontact = Contact.find_by_Id(@sfcontact.Id)
        @sfcontact.MailingStreet = @street
        @sfcontact.MailingCity = @city
        @sfcontact.MailingState = @state
        @sfcontact.MailingPostalCode = @zip
      end
      @sfcontact.MT_Prospect_Status__c = "Prospect"
      @sfcontact.MyMOH_Church__c = @church
      @sfcontact.Organization__c = @organization
      @sfcontact.Number_of_Trip_Participants__c = @participants
      @sfcontact.Ideal_Trip_Month__c = params[:trip_month]
      @sfcontact.save
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}
      end 
    else
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}
      end
    end
  end
  
  def request_info_medical
    @title = "Request Information About MOH Haiti Medical Mission Trips"
    @meta = "Use our easy request information form to receive more information on taking a short-term medical mission trip with Mission of Hope, Haiti."
    @fname = params[:fname]
    @lname = params[:lname]
    @comments = params[:letter]
    @fromaddress = params[:email]
    @phone = "0000000000"
    @medical = params[:childnumber]
    @street = params[:street]
    @city = params[:city]
    @state = params[:state]
    @zip = params[:zip]
    @church = params[:church]
    @organization = params[:organization]
    @participants = params[:participants].to_i
    @license = params[:license]
    if !@fname.nil? && @fname != "" && !@fromaddress.nil? && @fromaddress != "" && (params[:formname].nil? || params[:formname].empty?)
      @isvalid = true
      @data = {
        :fname => @fname,
        :lname => @lname, 
        :fromaddress => @fromaddress, 
        :comments => @comments,
        :phone => @phone,
        :license => @license,
        :address => @street,
        :city => @city,
        :state => @state,
        :zip => @zip,
        :church => @church,
        :org => @organization,
        :participants => @participants,
        :month => params[:trip_month]
      }
      ContactUsMailer.take_a_medical_trip(@data).deliver
      #Save contact to convio
      @sfcontact = Contact.find_by_Email(params[:email])
      if @sfcontact.nil?
        @sfcontact = create_convio_contact(params[:lname], params[:fname], params[:email])
        @sfcontact = Contact.find_by_Id(@sfcontact.Id)
        @sfcontact.MailingStreet = @street
        @sfcontact.MailingCity = @city
        @sfcontact.MailingState = @state
        @sfcontact.MailingPostalCode = @zip
      end
      @sfcontact.MT_Prospect_Status__c = "Prospect"
      @sfcontact.MyMOH_Church__c = @church
      @sfcontact.Organization__c = @organization
      @sfcontact.Number_of_Trip_Participants__c = @participants
      @sfcontact.Ideal_Trip_Month__c = params[:trip_month]
      @sfcontact.Medical_Trip_Prospect__c = true
      @sfcontact.save
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}
      end 
    else
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}
      end
    end
  end
  
  def school_of_hope
    @title = "School of Hope in Haiti | Mission of Hope, Haiti School Program"
    @meta = "The School of Hope provides quality education in Haiti for students from Kindergarten through High School. It is ranked one of the top schools in the Haiti school system."
    @category = Category.find_by_categoryname("Education")
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    @villages = Community.joins(:projects=>:categories).where("category_id=?",@category.id.to_s)
    
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def share_photos
    @title = "Mission of Hope SnapBack | Donate Your Photos of Haiti Culture"
    @meta = "The Mission of Hope Photo Share program, SnapBack, allows you to donate any pictures you have of the Haitian culture and life in Haiti."
    FlickRaw.api_key = "1df2b5c52c4acb9e2217b7a43842732f"
    FlickRaw.shared_secret = "93aace8a1dba42d1"
    #@photos = flickr.interestingness.getList( :per_page => 5 )
    #@photos = flickr.people.getPublicPhotos(:user_id => '45792545@N03',:per_page => '20')
    @photos = flickr.groups.pools.getPhotos(:group_id => '1908168@N20',:per_page => '20')
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def sitemap
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}
    end
  end
  
  def sponsor_child
    @children = Child__c.query("Number_of_Photos__c > 0 LIMIT 3")
    @photos = Hash.new
    @children.each do |child|
      photo = Picture__c.find_by_Child__c(child.Id).Photo__c
      @photos[child] = photo
    end
    @title = "Child Sponsorship: Help Children in Haiti by Becoming a Sponsor"
    @meta = "Help a child in Haiti who is in need through sponsorship. Sponsorship provides children with food, care, clothing, shelter & education. Sponsor a child in Haiti today."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def sponsor_faq
    @title = "Mission of Hope, Haiti Child Sponsorship FAQs"
    @meta = "Find answers to the most frequently asked questions (FAQs) about the Mission of Hope, Haiti child sponsorship program."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def sponsorshipcatalog
    redirect_to "http://mohhaiti.force.com/sponsorship" and return
  end
  
  def stampinup
    @title = "Stampin' Up is Partnering with Mission of Hope, Haiti"
    @meta = "Help Haitians in need get the housing and basic necessities they need. Donate today."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  
  def three_cords
    @title = "3 Cords at Mission of Hope, Haiti: Giving Amputee Women Hope"
    @meta = "The 3 Cords program employs amputee Haitian women and mothers of amputee Haitian children. Three Cords women create headbands, purses an accessories to sell and provide for their families."
    @category = Category.find_by_categoryname("3 Cords")
    @projects = Project.joins(:categories).where("category_id=" + @category.id.to_s).last(4).reverse
    @posts = Post.joins(:categories).where("category_id=" + @category.id.to_s).order(:postdate).last(3).reverse
    @updates = Update.joins(:categories).where("category_id=" + @category.id.to_s).last(3).reverse
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# three_cords.html.erb
    end
  end
  
  def trip_costs
    @title = "MOH  Mission Trip Costs | How much does a mission trip to Haiti cost?"
    @meta = "The cost of a mission trip to Haiti vary per length of trip. The costs with Mission of Hope, Haiti covers lodging, food and transportation."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
      
    
  def trip_dates
    @title = "MOH Mission Trip Dates | When can I go on a mission trip to Haiti?"
    @meta = "When can you or your group go on a missions trip to Haiti? Find the available dates at Mission of Hope, Haiti (MOH) for taking a missions trip."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end

   
  def trip_faqs
    @title = "MOH Mission Trip FAQs | Going on a Mission Trip to Haiti"
    @meta = "What does going on a missions trip to Haiti look like? Find out how to take a missions trip, what you'll do on a trip and traveling to Haiti."
     respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def videos
    @title = "Haiti Videos | Videos from Mission of Hope, Haiti "
    @meta = "Videos that provide a different view to MOH Haiti's earthquake relief, orphan care, education opportunities, and church advancement opportunities."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"} #videos.html.erb
    end
  end
  
  def vision_mission_resolution
    @title = "The Mission of Hope, Haiti Vision, Mission & Resolutions"
    @meta = "Mission of Hope is driven by our vision and key resolutions which permeate all of our efforts."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def vision_trip
    @title = "Vision Trips | Mission of Hope, Haiti Vision Trips for Pastors"
    @meta = "The Mission of Hope 'Vision Trip' is designed for church leaders and pastors to tour Mission of Hope, Port-au-Prince, and surrounding villages. Take a Vision trip with Mission of Hope, Haiti."
    @txtfirst = params[:txtfirst]
    @txtlast = params[:txtlast]
    @txtphone = params[:txtphone]
    @txtemail = params[:txtemail]
    @txtchurch = params[:txtchurch]
    @txtcity = params[:txtcity]
    @txtstate = params[:txtstate]
    @txtzip = params[:txtzip]
    @txtmessage = params[:txtmessage]
    @txtdatesinterested = params[:txtdatesinterested]

    if !@txtfirst.nil? && @txtfirst != "" && !@txtphone.nil? && @txtphone != "" && !@txtemail.nil? && @txtemail != "" && !@txtmessage.nil? && @txtmessage != ""
      @isvalid = true
      @data = {
        :txtfirst => @txtfirst,
        :txtlast => @txtlast,
        :txtphone => @txtphone,
        :txtemail => @txtemail,
        :txtchurch => @txtchurch,
        :txtcity => @txtcity,
        :txtstate => @txtstate,
        :txtzip => @txtzip,
        :txtmessage => @txtmessage,
        :txtdatesinterested => @txtdatesinterested
      }
      respond_to do |format|
        ContactUsMailer.vision_trip(@data).deliver
        format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
      end 
     else
       respond_to do |format|
         format.html {render :layout=>"homeLayout"}# three_cords.html.erb
       end
     end
  end
  
  def volunteer
    @title = "Volunteer for Mission of Hope, Haiti in Fort Myers, FL"
    @meta = "Volunteer for Mission of Hope, Haiti in Fort Myers, FL. It doesn't matter what skills you have or where you live, you can help us!"
    @txtname = params[:txtname]
    @txtmessage = params[:txtmessage]
    @txtemail = params[:txtemail]
    @txtphonenumber = params[:txtphonenumber]
    if !@txtname.nil? && @txtname != "" && !@txtmessage.nil? && @txtmessage != "" && !@txtemail.nil? && @txtemail != ""
      @isvalid = true
      @data = {
        :txtname => @txtname, 
        :txtemail => @txtemail, 
        :txtmessage => @txtmessage,
        :txtphonenumber => @txtphonenumber
      }
      respond_to do |format|
        ContactUsMailer.volunteer(@data).deliver
        format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
      end
    else
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
      end
    end
  end
  
  def what_we_do
    @title = "What MOH Does | Ministries of Mission of Hope, Haiti"
    @meta = "Mission of Hope, Haiti has several ministries and areas of work. Our organization's ministries allow us to daily serve the people of Haiti and advance the church."
    respond_to do |format|
      format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
    end
  end
  
  def write_my_child
    @title = "Write Your Sponsored Child Online at Mission of Hope, Haiti"
    @meta = "Write your Mission of Hope, Haiti sponsored child online with this easy form that allows you to write your letter and send a photo!"
    @name = params[:name]
    @letterbody = params[:letter]
    @fromaddress = params[:email]
    @phone = params[:phonenumber]
    @childname = params[:childname]
    @childnumber = params[:childnumber]
    if !@name.nil? && @name != "" && !@letterbody.nil? && @letterbody != "" && !@childnumber.nil? && @childnumber != ""
      @attachment = params[:datafile]
      @isvalid = true
      @data = {
        :fname => @name, 
        :fromaddress => @fromaddress, 
        :bodym => @letterbody,
        :phone => @phone,
        :childname => @childname,
        :childnumber => @childnumber,
        :attachment => @attachment
      }
      respond_to do |format|
        ContactUsMailer.write_child(@data).deliver
        ContactUsMailer.write_child_confirmation(@data).deliver
        format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
      end 
    else
      @data = {}
      unless current_user == nil
        @sponsorship = Child_Sponsorship__c.find_by_Sponsor__c(current_user.convio_id)
        puts "Sponsorship"
        @contact = Contact.find_by_Id(current_user.convio_id)
        if params[:id]
          @child = Child__c.find_by_Id(params[:id])
        else
          if @sponsorship
            @child = Child__c.find_by_Id(@sponsorship.Child__c)
          end
        end
        if @child
          @data[:childname] = @child.Name__c || ""
          @data[:childid] = @child.Child_Number__c || ""
          @data[:sponsorname] = (current_user.first || "") + " " + (current_user.last || "")
          @data[:sponsoremail] = current_user.email || ""
          @data[:sponsorphone] = @contact.HomePhone || ""
        end
      end
      respond_to do |format|
        format.html {render :layout=>"homeLayout"}# haiti_one.html.erb
      end  
    end
    
  end
    
  

  
  
  
end

