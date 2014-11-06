# Your code here
require 'weapons/bow'


describe Bow do
	# I want to use intance_double
	let(:bow){Bow.new}

	describe "#arrows" do

		specify "arrow count is readable" do
			# the second test acutally confirms that this is readable
			expect(bow.arrows).not_to be_nil
		end

		context "when arrows are not specified" do
			it "starts with ten arrows" do
				expect(bow.arrows).to eq(10)
			end
		end

		context "when number of arrows are specified" do
			it "returns the specified number of arrows" do
				# want to use stubs and mocks - overkill?
				bow = Bow.new(12)
				expect(bow.arrows).to eq(12)
			end
		end

	end

	describe "#use" do

		it "decreases number arrows by one" do
			# I don't want this to run in the terminal, just to make sure it works
			bow.use
			expect(bow.arrows).to eq(9)
		end

		it "raises an error when there are no arrows left" do
			# this just feels wrong...
			# I want to test if the method works without actually calling it
			# in the terminal.
			expect{11.times{bow.use}}.to raise_error
		end
	end

end