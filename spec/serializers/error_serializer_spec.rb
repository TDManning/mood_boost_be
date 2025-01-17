require 'rails_helper'

RSpec.describe "Error Serializer" do
    describe "As Json" do 
        it "Returns a Hash with message and error keys" do 
            hash = double('Input Object' , message: 'No', Error: 'Nah')

            message = ErrorMessage.new(hash)
    
            result = message.as_json
    
            expect(result).to eq({ message: 'Hello World', status: 'success' })
        end
    end
end