require 'spec_helper'

describe NewTime do
  it 'has a version number' do
    expect(NewTime::VERSION).not_to be nil
  end

  context "For a fixed time and place" do
    let(:latitude)  { -33.714955 }
    let(:longitude) { 150.311407 }
    let(:tz)        { "Australia/Sydney" }
    let(:date_time) { DateTime.parse("2015-01-31T14:32:10+11:00") }

    describe ".convert" do
      let(:t) { NewTime::NewTime.convert(date_time, latitude, longitude, tz) }
      it { expect(t.hours).to eq 13 }
      it { expect(t.minutes).to eq 10 }
      it { expect(t.seconds).to eq 23 }
      it { expect(t.fractional).to be_within(0.00000001).of(0.999999999992724) }
    end
  end
end
