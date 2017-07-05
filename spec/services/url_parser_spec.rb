require 'rails_helper'

RSpec.describe URLParser do
  subject { described_class.new url }

  describe '#parse' do
    let(:url) { 'www.tksasha.me' }

    subject { described_class.new(url).parse }

    it { should be_a URI }

    its(:scheme) { should eq 'http' }

    its(:host) { should eq 'www.tksasha.me' }

    context do
      let(:url) { 'https://www.tksasha.me' }

      its(:scheme) { should eq 'https' } 

      its(:hostname) { should eq 'www.tksasha.me' }
    end

    context do
      let(:url) { 'http://www.tksasha.me/companies.html' }

      its(:scheme) { should eq 'http' }

      its(:host) { should eq 'www.tksasha.me' }
    end

    context do
      let(:url) { 'www.tksasha.me/companies.html' }

      its(:scheme) { should eq 'http' }

      its(:host) { should eq 'www.tksasha.me' }
    end

    context do
      let(:url) { '//www.tksasha.me/companies.html' }

      its(:scheme) { should eq 'http' }

      its(:host) { should eq 'www.tksasha.me' }
    end
  end

  describe '.parse' do
    before do
      #
      # described_class.new('www.tksasha.me').parse
      #
      expect(described_class).to receive(:new).with('www.tksasha.me') do
        double.tap { |a| expect(a).to receive(:parse) }
      end
    end

    subject { described_class.parse 'www.tksasha.me' }

    it { expect { subject }.to_not raise_error }
  end
end
