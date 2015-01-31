require 'spec_helper'

describe NewTime do
  it 'has a version number' do
    expect(NewTime::VERSION).not_to be nil
  end

  context "For a fixed place" do
    let(:latitude)  { -33.714955 }
    let(:longitude) { 150.311407 }
    let(:tz)        { "Australia/Sydney" }

    describe ".convert" do
      it "00:00:01" do
        expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T00:00:01+11:00"), latitude, longitude, tz).to_s).to eq "10:35 pm"
      end

      it "03:00:00" do
        expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T03:00:00+11:00"), latitude, longitude, tz).to_s).to eq "2:06 am"
      end

      it "14:32:10" do
        expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T14:32:10+11:00"), latitude, longitude, tz).to_s).to eq "1:10 pm"
      end

      it "20:10:00" do
        expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T20:10:00+11:00"), latitude, longitude, tz).to_s).to eq "6:07 pm"
      end

      it "23:59:59" do
        expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T23:59:59+11:00"), latitude, longitude, tz).to_s).to eq "10:35 pm"
      end

    end
  end
end
