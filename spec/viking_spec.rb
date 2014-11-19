# Your code here
require 'viking.rb'

describe Viking do
	# most cases I re-initialize this. Is that bad?

	context "creating" do

		describe "#name" do

			context "when initialized without a custom name" do
				let(:viking){Viking.new}
				it "should generate a random viking name" do
					expect(viking.name).not_to be_nil
				end
			end
			context "when initialized with the name 'Olaf'" do
				let(:viking){Viking.new("Olaf")}
				it "should use the name 'Olaf'" do
					expect(viking.name).to eq("Olaf")
				end
			end
		end

		describe "#health" do
			context "when no health is specified" do
				it "should set the health to 100" do
					expect(subject.health).to eq(100)
				end
			end
			context "when health is specified" do
				let(:viking){Viking.new("",200)}
				it "should set health to 200" do
					expect(viking.health).to eq(200)
				end
			end
		end

		describe "#weapon" do
			it "should start at nil" do
				expect(subject.weapon).to be_nil
			end
		end

	end

	context "modifying attributes" do
		# attr_reader! A viking may not change his name!
		# describe "#name" do
		# 	it "can change the given name for the sake of glory or retirement" do
		# 		viking.name = "Derpina Wilkens"
		# 		expect(viking.name).to eq("Derpina Wilkens")
		# 	end
		# end
		describe "#health" do
			it "should throw an error" do
				expect{subject.health=3}.to raise_error(NoMethodError)
			end
		end

		context "weapons" do

			weapons = {a: Axe.new, b: Bow.new, f: Fists.new}

			context "picking up a weapon" do

				context "when it is a 'non-weapon'" do
					it "should raise an error" do
						expect{subject.pick_up_weapon("Frog Slammer Hammer")}.to raise_error
					end
				end

				context "when it is a new weapon" do

					it "sets axe as weapon" do
						subject.pick_up_weapon(weapons[:a])
						expect(subject.weapon).to eq(weapons[:a])
					end

					it "replaces bow with axe" do
						subject.pick_up_weapon(weapons[:b])
						subject.pick_up_weapon(weapons[:a])
						expect(subject.weapon).to eq(weapons[:a])
					end
				end
			end

			context "dropping a weapon" do

				specify "weapon should be nil" do
					subject.pick_up_weapon(weapons[:a])
					subject.drop_weapon
					expect(subject.weapon).to be_nil
				end
			end
		end
	end

	context "when fighting" do
		describe "#receive_attack" do
			it "should reduce health by 5 points" do
				subject.receive_attack(5)
				expect(subject.health).to eq(95)
			end
			it "should call the take_damage method" do
				# is this even working?
				allow(subject).to receive(:take_damage)
				expect(subject).to receive(:take_damage)
				subject.receive_attack(10)
			end
		end

		describe "#attack" do
			let(:u){Viking.new("Steve")}
			context "when attacking another viking" do
				it "should reduce the health of the recipient" do
					starting_health = u.health
					subject.attack(u)
					expect(u.health).to be < starting_health
				end

				it "should call the take_damage method" do
					allow(u).to receive(:take_damage)
					expect(u).to receive(:take_damage)
					subject.attack(u)
				end

				context "when attacking with no weapon" do
					it "should run damage_with_fists" do
						allow(subject).to receive(:damage_with_fists).and_return(2.5)
						expect(subject).to receive(:damage_with_fists)
						subject.attack(u)
					end
					it "should deal Fists multiplier damage" do
						subject.drop_weapon
						puts subject
						puts u.health
						subject.attack(u)
						expect(u.health).to eq(97.5)
					end
				end
				context "when attacking with a bow" do
					it "should run damage_with_weapon" do
						subject.pick_up_weapon(Bow.new)
						allow(subject).to receive(:damage_with_weapon).and_return(20)
						expect(subject).to receive(:damage_with_weapon)
						subject.attack(u)
					end

					it "should deal 20 damage to recipient" do
						subject.pick_up_weapon(Bow.new)
						subject.attack(u)
						expect(u.health).to eq(80)
					end
					context "when the bow runs out of arrows" do
						it "should resort to fisticuffs" do
							subject.pick_up_weapon(Bow.new(0))
							allow(subject).to receive(:damage_with_fists).and_return(2.5)
							expect(subject).to receive(:damage_with_fists)
							subject.attack(u)
						end
					end
					context "when a viking dies" do
						it "should throw an error" do
							expect{subject.take_damage(9001)}.to raise_error
						end
					end
				end
			end
		end
	end
end