require 'rails_helper'

RSpec.describe Shares do
  subject { described_class.new 'http://www.tksasha.me' }

  describe '#facebook_access_token' do
    before { expect(ENV).to receive(:[]).with('FACEBOOK_ACCESS_TOKEN').and_return('XXXX-YYYY-ZZZZ') }

    its(:facebook_access_token) { should eq 'XXXX-YYYY-ZZZZ' }
  end

  describe '#json' do
    let(:json) do
      <<-eos
        {
          "http://www.tksasha.me":{
            "share":{
              "share_count":69
            }
          }
        }
      eos
    end

    before { expect(subject).to receive(:facebook_access_token).and_return('TOKEN') }

    before do
      #
      # open('https://graph.facebook.com?ids=http://www.tksasha.me&access_token=TOKEN').read -> json
      #
      expect(subject).to receive(:open).with('https://graph.facebook.com?ids=http://www.tksasha.me&access_token=TOKEN') do
        double.tap { |a| expect(a).to receive(:read).and_return(json) }
      end
    end

    its(:json) do
      should eq({
        'http://www.tksasha.me' => {
          'share' => {
            'share_count' => 69
          }
        }
      })
    end
  end

  describe '#count' do
    let(:json) do
      {
        'http://www.tksasha.me' => {
          'share' => {
            'share_count' => 69
          }
        }
      }
    end

    before { expect(subject).to receive(:json).and_return(json) }

    its(:count) { should eq 69 }
  end

  describe '.count' do
    before do
      #
      # described_class.new('http://www.tksasha.me').count
      #
      expect(described_class).to receive(:new).with('http://www.tksasha.me') do
        double.tap { |a| expect(a).to receive(:count) }
      end
    end

    subject { described_class.count 'http://www.tksasha.me' }

    it { expect { subject }.to_not raise_error }
  end
end
