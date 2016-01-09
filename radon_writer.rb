require 'mechanize'
require 'httparty'

class RadonWriter

	def initialize
		@mechanize = Mechanize.new
		@username = 'p2433'
		@password = 'harper'
		@code = 'aa4bca69-ce62-4182-a2e0-f594c3d3052c'
	end

	def login
		page = @mechanize.get('http://3pcmc.pillartopost.com/standard/login.aspx')
		form = page.forms.first

		@viewstate = form['__VIEWSTATE']
		@viewstategenerator = form['__VIEWSTATEGENERATOR']

		data = { :body => {
			__VIEWSTATE: @viewstate,
			__VIEWSTATEGENERATOR: @viewstategenerator,
			txtUsername: @username,
			txtPassword: @password,
			btnSubmit: 'Submit'
		}}

		inspections = HTTParty.post('http://3pcmc.pillartopost.com/standard/login.aspx', data)
		print inspections
	end

	def search_todays_inspections
		data = { :body => {
			'__EVENTTARGET' => 'lkbEvent',
			'__EVENTARGUMENT' => 'RunSearch',
			'__VIEWSTATE' => @viewstate,
			'__VIEWSTATEGENERATOR' => @viewstategenerator,
			'ctl00$mainContent$txtSearch' => '',
			'ctl00$mainContent$lstInspectors' => @code,
			'ctl00$mainContent$txtAgent' => '',
			'ctl00$mainContent$hdnAgentId' => '0',
			'ctl00$mainContent$txtFromDate' => '01/08/2016',
			'ctl00$mainContent$hdnDateFrom' => '',
			'ctl00$mainContent$txtToDate' => '01/08/2016',
			'ctl00$mainContent$hdnDateTo' => '',
			'ctl00$mainContent$lstStatus' => '2',
			'tblListOfInspections_length' => '100',
			'ctl00$hidRole' => 'False'
		}}

		page = HTTParty.post('http://3pcmc.pillartopost.com/authenticated/inspections/home.aspx', data)
		print page
		#print page.headers.inspect
	end

end

app = RadonWriter.new
app.login
#app.search_todays_inspections

