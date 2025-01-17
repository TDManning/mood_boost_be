require 'rails_helper'

RSpec.describe "Error Serializer" do
    describe "As Json" do 
        it "Returns a Hash with message and error keys" do 

            message = ErrorMessage.new("some message", "error")
    
            result = message.as_json
    
            expect(result).to eq({ message: 'some message', status: 'error' })
        end
    end
end