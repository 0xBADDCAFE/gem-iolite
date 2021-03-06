load 'spec_helper.rb'
require "iolite/lazy"


describe "Iolite lazy" do
	describe "Iolite::lazy" do
		include Iolite
		arg1 = Iolite.lazy { |*args| args[0] }
		arg2 = Iolite.lazy { |*args| args[1] }

		describe "#class" do
			it "#class by Obejct#class" do
				expect(lazy { |a, b| a + b }.class).to eq(Iolite::Lazy)
			end
		end

		describe "#call" do
			it "call" do
				expect(lazy { |a, b| a + b }.call(1, 2)).to eq(3)
			end
		end

		describe "#bind" do
			it "bind argument" do
				expect(lazy { |a, b| a + b }.bind(1, 2).call()).to eq(3)
			end
			it "bind placeholders" do
				expect(lazy { |a, b| a + b }.bind(arg2, 2).call(2, 1)).to eq(3)
			end
			it "bind by placeholders" do
				expect((arg1 - arg2).bind(arg2, 2).call(1, 1)).to eq(-1)
			end
		end

		describe "#send" do
			it "send method" do
				expect(arg1.send(:length).call("homu")).to eq(4)
			end
			it "send Object method" do
				expect(arg1.send(:class).call("homu")).to eq(String)
			end
		end

		describe "#method_missing" do
			it "send method" do
				expect(arg1.length.call("homu")).to eq(4)
			end
			it "send Object method" do
				expect(arg1.class).to eq(arg1.__send__(:class))
			end
		end

		describe "#apply" do
			it "apply lazy" do
				expect(arg1.apply(1, 2).call(arg1 + arg2)).to eq(3)
			end
		end

		describe "#+" do
			it "call lazy" do
				expect((lazy { |a, b| a + b } + 3).call(1, 2)).to eq(6)
			end
		end

		describe "#==" do
			it "call" do
				expect((arg1 == 3).call(3)).to eq(true)
			end
		end

		describe "#===" do
			it "call" do
				expect((arg1 === arg2).call(/^m/, "mami")).to eq(true)
			end
		end

		describe "#to_s" do
			it "Symbol#to_s" do
				expect(arg1.to_s.call(:mami)).to eq("mami")
			end
			it "Fixnum#to_s" do
				expect(arg1.to_s.call(42)).to eq("42")
			end
		end

		describe "#class" do
			it "Symbol#class" do
				expect(arg1.class.call(:mami)).to eq(Symbol)
			end
		end
	end
end
