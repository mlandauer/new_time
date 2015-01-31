require 'spec_helper'

describe NewTime do
  it 'has a version number' do
    expect(NewTime::VERSION).not_to be nil
  end

  context "For a fixed place in the northern hemisphere" do
    let(:point) { NewTime::Point.new(51.829731, -0.860455, "Europe/London") }

    def c(month, hour)
      NewTime::NewTime.convert(DateTime.new(2015,month,31,hour,0,0,"+0"), point).to_s
    end

    describe ".convert" do
      context "2015-01-31" do
        it { expect(c(1, 0)).to eq "2015-01-30 11:47 pm" }
        it { expect(c(1, 6)).to eq "2015-01-31 4:35 am" }
        it { expect(c(1, 12)).to eq "2015-01-31 11:37 am" }
        it { expect(c(1, 18)).to eq "2015-01-31 6:57 pm" }
      end

      context "2015-07-31" do
        it { expect(c(7, 0)).to eq "2015-07-30 11:46 pm" }
        it { expect(c(7, 6)).to eq "2015-07-31 7:14 am" }
        it { expect(c(7, 12)).to eq "2015-07-31 11:53 am" }
        it { expect(c(7, 18)).to eq "2015-07-31 4:31 pm" }
      end
    end
  end

  context "For a fixed place in the southern hemisphere" do
    let(:point) { NewTime::Point.new(-33.714955, 150.311407, "Australia/Sydney") }

    def c(month, hour)
      NewTime::NewTime.convert(DateTime.new(2015,month,31,hour,0,0,"+11"), point).to_s
    end

    describe ".convert" do
      context "2015-01-31" do
        it { expect(c(1, 0)).to eq "2015-01-30 10:35 pm" }
        it { expect(c(1, 6)).to eq "2015-01-31 5:37 am" }
        it { expect(c(1, 12)).to eq "2015-01-31 10:57 am" }
        it { expect(c(1, 18)).to eq "2015-01-31 4:11 pm" }
      end

      context "2015-07-31" do
        it { expect(c(7, 0)).to eq "2015-07-30 11:03 pm" }
        it { expect(c(7, 6)).to eq "2015-07-31 4:21 am" }
        it { expect(c(7, 12)).to eq "2015-07-31 10:45 am" }
        it { expect(c(7, 18)).to eq "2015-07-31 5:39 pm" }
      end
    end
  end
end
