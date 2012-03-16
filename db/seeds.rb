# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Investigation.delete_all

flower_shop = Investigation.create(
                name: 'Clothes Shop',
                description: 'An Investigation of a failing website'
              )
web_server = Log.new( investigation: flower_shop,
                      name: 'Web Server Log',
                      description: 'Apache Combined Access log from the web server',
                      data_type: 'plaintext',
                      file: 'flower_shop_log.log',
                      time_bias: 0
                    )
log_file = File.new("test/fixtures/files/access_combined.log")

web_server.save!
web_server.import_to_db(log_file)

apache_2x_3x_ignore_list = IgnoreList.create(
                              name: 'Unimportant Apache Messages',
                              description: 'Messages returning status 2xx or 3xx',
                              pattern_list: "HTTP/1.1\" 30\nHTTP/1.1\" 200")

apache_combined_source = Source.create( name: 'Apache Combined Access Error Messages',
                                        description: 'extracting error messages',
                                        timestamp_definition: '.+',
                                        field_1_name: 'client_error',
                                        field_1_definition: '4\w+')

client_error_pattern = MessagePattern.create(
                          source: apache_combined_source,
                          name: 'Client error (4xx)',
                          pattern: '.+ \[@@timestamp@@\] \".+?\" @@client_error@@',
                          category: 'Errors')


                                         

