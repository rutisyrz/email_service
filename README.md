# EmailService
    A reusable bundle for email gateway integration with multiple systems
    It's a layer between third part email gateway & system, which allows you to easily plug-in/out email gateway of your choise without hampering your system

## Need of Private gem
	Customize existing gem as per your requirements
	Store your third party account credentials & keep them safe 
	Avoid code duplication in SaaS / SOA based multiple applications using same set of services/functionalities 
	Do not wait for your contribution to get added in original gem 

## Host private gem
	Use gemfury(https://gemfury.com/) to host your private gems
	How it works - https://gemfury.com/l/gem-server
	Please note - do not forget to update gem version (lib/email_service/version.rb) everytime you push new changes made in gem, else gemfury won't reconize that gem has been modified. Hence, it won't update the gem.
	Know more about gem versioning guidelines - http://guides.rubygems.org/patterns/#semantic-versioning

## Customizations 
	Pulled iCubes account configurations in private gem (lib/email_service/lyris_config.yml) to avoid duplication in multiple services offered by company
	(NEW) Maintain Rails Environment specific copy of each list rather than creating & maintaining different lists based on environment
	API Error notification mechanism 

## Installation

Add this line to your application's Gemfile:

    gem 'email_service'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install email_service

## Usage

	Add your iCubes account credentials here - lib/email_service/lyris_config.yml
	Make necessary changes in constants - lib/email_service/constant.yml
	Change TECH_DEVS in constant with email id where you would like to receive API error emails

## Contributing

1. Fork it ( https://github.com/[my-github-username]/email_service/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
