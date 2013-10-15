module Allegro
  module WebApi
    class User
      attr_reader :client
      attr_reader :my_data

      def initialize(client)
        @client = client
      end

      def do_get_my_data
        @my_data = client.call(:do_get_my_data, message: {session_handle: client.session_handle}).
            body[:do_get_my_data_response][:user_data]
      end

      # TODO: Create a class method to do that
      def method_missing( name, *args )
        if !!(ret = my_data[ :"user_#{ name }" ])
          ret
        else
          super
        end
      end
    end
  end
end
