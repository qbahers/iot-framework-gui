require 'json'

module Api
	class << self

		def connect
			conn = Faraday.new(:url => "#{CONF['API_URL']}") do |faraday|
			  faraday.request  :url_encoded             # form-encode POST params
			  faraday.response :logger                  # log requests to STDOUT
			  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
			end
		end

		def get(url)
			res = connect.get(url)
			resp = res.to_hash
			resp[:body] = JSON.parse(resp[:body])
			resp.stringify_keys!
		end

		def semantics_get(url)
			res = connect.get(url)
			resp = res.to_hash
			#render :text => resp[:body]
			#send_data(resp[:body], :type => 'text/html', :filename => "export.txt",:status=>'200 OK')
			#send_data resp[:body]
			File.open("/home/iakovosk/semantics_output.txt", 'w') {|f| f.write(resp[:body]) }
			#send_file '/home/iakovosk/semantics_output.txt'
			resp.stringify_keys!
		end

		def post(url, body)
			res = connect.post do |req|
			  req.url url
			  req.headers['Content-Type'] = 'application/json'
			  req.body = body.to_json
			end
			resp = res.to_hash
			resp[:body] = JSON.parse(resp[:body])
			resp.stringify_keys!
		end

		def put(url, body)
			res = connect.put do |req|
			  req.url url
			  req.headers['Content-Type'] = 'application/json'
			  req.body = body.to_json
			end
		  resp = res.to_hash
			resp[:body] = JSON.parse(resp[:body])
			resp.stringify_keys!
		end

		def delete(url, body)
			res = connect.delete do |req|
			  req.url url
			  req.headers['Content-Type'] = 'application/json'
			  req.body = body.to_json
			end
		  resp = res.to_hash
			resp[:body] = JSON.parse(resp[:body])
			resp.stringify_keys!
		end

	end
end
