require 'spec_helper'

describe NewTime do
  it 'has a version number' do
    expect(NewTime::VERSION).not_to be nil
  end

  context "For a fixed place in the northern hemisphere" do
    let(:point) { NewTime::Point.new(51.829731, -0.860455, "Europe/London") }

    def c(month, hour)
      NewTime::NewTime.convert(Time.new(2015,month,1,hour,0,0,"+00:00"), point).to_s
    end

    def i(month, hour)
      t1 = Time.new(2015,month,1,hour,0,0,"+00:00")
      t2 = NewTime::NewTime.convert(t1, point).convert(point)
      expect(t2.to_f).to eq t1.to_f
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

    describe "it should be invertable" do
      it { i(1, 0) }
      it { i(1, 6) }
      it { i(1, 12) }
      it { i(1, 18) }
      it { i(7, 0) }
      it { i(7, 6) }
      it { i(7, 12) }
      it { i(7, 18) }
    end
  end

  context "For a fixed place in the southern hemisphere" do
    let(:point) { NewTime::Point.new(-33.714955, 150.311407, "Australia/Sydney") }

    def c(month, hour)
      NewTime::NewTime.convert(Time.new(2015,month,1,hour,0,0,"+11:00"), point).to_s
    end

    def i(month, hour)
      t1 = Time.new(2015,month,1,hour,0,0,"+11:00")
      t2 = NewTime::NewTime.convert(t1, point).convert(point)
      expect(t2.to_f).to eq t1.to_f
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

    describe "it should be invertable" do
      it { i(1, 0) }
      it { i(1, 6) }
      it { i(1, 12) }
      it { i(1, 18) }
      it { i(7, 0) }
      it { i(7, 6) }
      it { i(7, 12) }
      it { i(7, 18) }
    end

    describe "inverting should work with zero fractional" do
      it do
        n1 = NewTime::NewTime.new(2015,2,1,6,50,33,0)
        t1 = n1.convert(point)
        n2 = NewTime::NewTime.convert(t1, point)
        expect(n2.year).to eq n1.year
        expect(n2.month).to eq n1.month
        expect(n2.day).to eq n1.day
        expect(n2.hours).to eq n1.hours
        expect(n2.minutes).to eq n1.minutes
        expect(n2.seconds).to eq n1.seconds
        expect(n2.fractional).to eq n1.fractional
      end
    end
  end
end
