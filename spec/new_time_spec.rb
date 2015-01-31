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
        it "00:00:01" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T00:00:01+00:00"), latitude, longitude, tz).to_s).to eq "2015-01-30 11:47 pm"
        end

        it "03:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T03:00:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 2:11 am"
        end

        it "14:32:10" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T14:32:10+00:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 2:58 pm"
        end

        it "20:10:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T20:10:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 8:41 pm"
        end

        it "23:59:59" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T23:59:59+00:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 11:47 pm"
        end
      end

      context "2015-07-31" do
        it "00:00:01" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T00:00:01+00:00"), latitude, longitude, tz).to_s).to eq "2015-07-30 11:46 pm"
        end

        it "03:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T03:00:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 4:02 am"
        end

        it "14:32:10" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T14:32:10+00:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 1:50 pm"
        end

        it "20:10:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T20:10:00+00:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 6:21 pm"
        end

        it "23:59:59" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T23:59:59+00:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 11:45 pm"
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
        it "00:00:01" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T00:00:01+11:00"), latitude, longitude, tz).to_s).to eq "2015-01-30 10:35 pm"
        end

        it "03:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T03:00:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 2:06 am"
        end

        it "14:32:10" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T14:32:10+11:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 1:10 pm"
        end

        it "20:10:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T20:10:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 6:07 pm"
        end

        it "23:59:59" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-01-31T23:59:59+11:00"), latitude, longitude, tz).to_s).to eq "2015-01-31 10:35 pm"
        end
      end

      context "2015-07-31" do
        it "00:00:01" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T00:00:01+11:00"), latitude, longitude, tz).to_s).to eq "2015-07-30 11:03 pm"
        end

        it "03:00:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T03:00:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 1:42 am"
        end

        it "14:32:10" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T14:32:10+11:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 1:40 pm"
        end

        it "20:10:00" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T20:10:00+11:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 7:39 pm"
        end

        it "23:59:59" do
          expect(NewTime::NewTime.convert(DateTime.parse("2015-07-31T23:59:59+11:00"), latitude, longitude, tz).to_s).to eq "2015-07-31 11:02 pm"
        end
      end
    end
  end
end
