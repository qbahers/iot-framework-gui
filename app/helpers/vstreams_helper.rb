module VstreamsHelper


	def vstreamname(stream_id)
                    
                

		res = Api.get("/streams/#{stream_id}")
	    stream_owner_id = res['user_id']
		stream_name= res['name']
		link_to "#{stream_name}", "/streams/#{stream_id}"
	end


end