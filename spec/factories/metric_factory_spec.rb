require 'rails_helper'

RSpec.describe MetricFactory do
  subject { described_class.new uri: 'www.tksasha.me', depth: 42 }

  it { should delegate_method(:scheme).to(:uri) }

  it { should delegate_method(:host).to(:uri) }

  its(:uri) { should be_a URI }

  describe '#links' do
    let(:html) do
      <<-eos
        <!DOCTYPE html>
        <html>
          <head>
            <title></title>
          </head>
          <body>
            <a href="/">Root</a>
            <a href="/companies.html">Companies</a>
            <a href="/companies.html?param=true">Companies</a>
            <a href="http://www.tksasha.me/companies.html">Companies</a>
            <a href="http://www.rubyonrails.org/">Ruby on Rails</a>
            <a href="mailto:mail@tksasha.me">My Email</a>
            <a href="/posts.html">Posts</a>
          </body>
        </html>
      eos
    end

    before { expect(subject).to receive(:open).with('http://www.tksasha.me').and_return(html) }

    its(:links) do
      should eq [
        URI('/'),
        URI('/companies.html'),
        URI('/companies.html?param=true'),
        URI('http://www.tksasha.me/companies.html'),
        URI('/posts.html')
      ]
    end
  end

  describe '#create' do
  end

  describe '.create' do
    before do
      #
      # described_class.new(uri: 'www.tksasha.me', depth: 42).create
      #
      expect(described_class).to receive(:new).with(uri: 'www.tksasha.me', depth: 42) do
        double.tap { |a| expect(a).to receive(:create) }
      end
    end

    subject { described_class.create uri: 'www.tksasha.me', depth: 42 }

    it { expect { subject }.to_not raise_error }
  end
end
