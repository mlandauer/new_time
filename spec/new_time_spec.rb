require 'spec_helper'

describe NewTime do
  it 'has a version number' do
    expect(NewTime::VERSION).not_to be nil
  end

  context "For a fixed place in the northern hemisphere" do
    let(:point) { NewTime::Point.new(51.829731, -0.860455, "Europe/London") }

    def c(month, hour)
      NewTime::NewTime.convert(DateTime.new(2015,month,1,hour,0,0,"+0"), point).to_s
    end

    describe ".convert" do
      context "2015-01-01" do
        it { expect(c(1, 0)).to eq "2014-12-31 11:55 pm" }
        it { expect(c(1, 6)).to eq "2015-01-01 4:23 am" }
        it { expect(c(1, 12)).to eq "2015-01-01 11:50 am" }
        it { expect(c(1, 18)).to eq "2015-01-01 7:27 pm" }
      end

      context "2015-07-01" do
        it { expect(c(7, 0)).to eq "2015-06-30 11:49 pm" }
        it { expect(c(7, 6)).to eq "2015-07-01 7:35 am" }
        it { expect(c(7, 12)).to eq "2015-07-01 11:55 am" }
        it { expect(c(7, 18)).to eq "2015-07-01 4:15 pm" }
      end
    end
  end

  context "For a fixed place in the southern hemisphere" do
    let(:point) { NewTime::Point.new(-33.714955, 150.311407, "Australia/Sydney") }

    def c(month, hour)
      NewTime::NewTime.convert(DateTime.new(2015,month,1,hour,0,0,"+11"), point).to_s
    end

    describe ".convert" do
      context "2015-01-01" do
        it { expect(c(1, 0)).to eq "2014-12-31 10:43 pm" }
        it { expect(c(1, 6)).to eq "2015-01-01 6:07 am" }
        it { expect(c(1, 12)).to eq "2015-01-01 11:08 am" }
        it { expect(c(1, 18)).to eq "2015-01-01 4:09 pm" }
      end

      context "2015-07-01" do
        it { expect(c(7, 0)).to eq "2015-06-30 11:07 pm" }
        it { expect(c(7, 6)).to eq "2015-07-01 4:14 am" }
        it { expect(c(7, 12)).to eq "2015-07-01 10:45 am" }
        it { expect(c(7, 18)).to eq "2015-07-01 6:00 pm" }
      end
    end
  end
end
