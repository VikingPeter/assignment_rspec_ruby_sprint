# Your crizzilode here
require 'calculator'

describe Calculator do

	subject(:calculator){Calculator.new} # use for a defined subject, like instantiating an object

	# otherwise use 'let'
	# let(:calc){Calculator.new}

	# know that this does the same thing
	# before do
	# 	@calc = Calculator.new
	# end

	describe '#add' do
		it "adds two positive integers together" do
			expect(calculator.add(1,2)).to eq(3)
		end
		it "adds one positive and one negatve integer together" do
			expect(calculator.add(1,-2)).to eq(-1)
		end
		it "adds two negative integers together" do
			expect(calculator.add(-1,-2)).to eq(-3)
		end
		it "adds two floats together" do
			expect(calculator.add(0.1,0.3)).to eq(0.4)
		end
		it "adds two negative floats together" do
			expect(calculator.add(-0.1,-0.3)).to eq(-0.4)
		end
	end

	describe "#subtract" do
		it "subtracts two positive integers from one another" do
			expect(calculator.subtract(5,2)).to eq(3)
		end
		it "subtracts one positive and one negatve integer from one another" do
			expect(calculator.subtract(2,-1)).to eq(3)
		end
		it "subtracts two negative integers from one another" do
			expect(calculator.subtract(-1,-2)).to eq(1)
		end
		it "subtracts two floats from one another" do
			expect(calculator.subtract(0.5,0.1)).to eq(0.4)
		end
		it "subtracts two negative floats from one another" do
			expect(calculator.subtract(-0.5,-0.1)).to eq(-0.4)
		end
	end

	describe "#divide" do
		it "returns an integer for two divisible numbers" do
			expect(calculator.divide(10,2)).to eq(5)
		end
		it "raises an error when the second number is negative" do
			expect{calculator.divide(2,-3)}.to raise_error(ArgumentError)
		end
		it "returns a float if there is a remainder" do
			expect(calculator.divide(7,2)).to eq(3.5)
		end
	end

	describe "#pow" do
		it "raises x to n power" do
			expect(calculator.pow(2,3)).to eq(8)
		end
		it "takes negative numbers as the base with an odd exponent" do
			expect(calculator.pow(-2,3)).to eq(-8)
		end
		it "takes negative numbers as the base with an even exponent" do
			expect(calculator.pow(-2,2)).to eq(4)
		end
		it "takes negative numbers as the exponent" do
			expect(calculator.pow(2,-1)).to eq(0.5)
		end
		it "takes floats as the base" do
			expect(calculator.pow(0.5,2)).to eq(0.25)
		end
		it "takes floats as the exponent" do
			expect(calculator.pow(9,0.5)).to eq(3)
		end
	end

	describe "#sqrt" do
		it "returns the square root of round postive integers" do
			expect(calculator.sqrt(4)).to eq(2)
		end
		it "returns the root of non-round postive integers as 2-digit decimals" do
			expect(calculator.sqrt(5)).to eq(2.24)
		end
		it "raises an error for negative input" do
			expect{calculator.sqrt(-1)}.to raise_error
		end
	end
	describe "#memory" do
		it "starts with nothing in memory" do
			expect(calculator.memory).to eq(nil)
		end
		it "takes input and stores it in memory" do
			calculator.memory = 8
			expect(calculator.memory).to eq(8)
		end
		it "returns and clears the object in memory" do
			calculator.memory = 8
			puts "    calculator.memory = #{calculator.memory}"
			expect(calculator.memory).to eq(nil)
			puts "    calculator.memory = #{calculator.memory}"
		end
	end
	describe "#stringify" do
		subject(:calc){Calculator.new(true)}

		it "stringifies the output of the add function" do
			expect(calc.add(2,3)).to eq("5")
		end
		it "stringifies the output of the subtract function" do
			expect(calc.subtract(8,3)).to eq("5")
		end
		it "stringifies the output of the multiply function" do
			expect(calc.multiply(2.5,2)).to eq("5.0")
		end
		it "stringifies the output of the divide function" do
			expect(calc.divide(10,2)).to eq("5")
		end
		it "stringifies the output of the power function" do
			expect(calc.pow(2,3)).to eq("8")
		end
		it "stringifies the output of the sqrt function" do
			expect(calc.sqrt(25)).to eq("5")
		end
		it "stringifies the output of the memory function" do
			calc.memory = 10
			expect(calc.memory).to eq("10")
		end
		it "nil stringifies to empty string" do
			expect(calc.memory).to eq("")
		end
	end

end