require 'spec_helper'

describe NewTime do
  it 'has a version number' do
    expect(NewTime::VERSION).not_to be nil
  end

  context "For a fixed place in the northern hemisphere" do
    let(:latitude)  { 51.829731 }
    let(:longitude) { -0.860455 }
    let(:tz)        { "Europe/London" }

    describe ".convert" do
      context "2015-01-31" do
        it "00:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T00:00:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-01-30 11:47 pm"
        end

        it "06:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T06:00:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 4:35 am"
        end

        it "12:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T12:00:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 11:37 am"
        end

        it "18:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T18:00:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 6:57 pm"
        end
      end

      context "2015-07-31" do
        it "00:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T00:00:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-07-30 11:46 pm"
        end

        it "06:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T06:00:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 7:14 am"
        end

        it "12:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T12:00:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 11:53 am"
        end

        it "18:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T18:00:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 4:31 pm"
        end
      end
    end
  end

  context "For a fixed place in the southern hemisphere" do
    let(:latitude)  { -33.714955 }
    let(:longitude) { 150.311407 }
    let(:tz)        { "Australia/Sydney" }

    describe ".convert" do
      context "2015-01-31" do
        it "00:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T00:00:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-01-30 10:35 pm"
        end

        it "06:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T06:00:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 5:37 am"
        end

        it "12:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T12:00:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 10:57 am"
        end

        it "18:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T18:00:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 4:11 pm"
        end
      end

      context "2015-07-31" do
        it "00:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T00:00:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-07-30 11:03 pm"
        end

        it "06:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T06:00:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 4:21 am"
        end

        it "12:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T12:00:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 10:45 am"
        end

        it "18:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T18:00:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 5:39 pm"
        end
      end
    end
  end
end
