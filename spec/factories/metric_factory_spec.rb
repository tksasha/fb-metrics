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
            <a href="http://www.tksasha.me">Root</a>
          </body>
        </html>
      eos
    end

    before { expect(subject).to receive(:open).with('http://www.tksasha.me').and_return(html) }

    its(:links) do
      should eq [
        URI::Generic.build(scheme: 'http', host: 'www.tksasha.me', path: '/'),
        URI::Generic.build(scheme: 'http', host: 'www.tksasha.me', path: '/companies.html'),
        URI::Generic.build(scheme: 'http', host: 'www.tksasha.me', path: '/companies.html', query: 'param=true'),
        URI::HTTP.build(scheme: 'http', host: 'www.tksasha.me', path: '/companies.html'),
        URI::Generic.build(scheme: 'http', host: 'www.tksasha.me', path: '/posts.html'),
        URI::HTTP.build(scheme: 'http', host: 'www.tksasha.me', path: '/')
      ]
    end
  end

  describe '#site' do
    before { expect(Site).to receive(:find_or_create_by).with(url: 'www.tksasha.me').and_return(:site) }

    its(:site) { should eq :site }
  end

  describe '#create' do
    let(:link) { URI.parse 'www.tksasha.me/companies.html' }

    let(:site) { stub_model Site }

    let(:page) { stub_model Page }

    before { expect(subject).to receive(:links).and_return([link]) }

    before { expect(subject).to receive(:site).and_return(site) }

    before { expect(Shares).to receive(:count).with(link.to_s).and_return(69) }

    before do
      #
      # site.pages.find_or_create_by(url: link.to_s) -> page
      #
      expect(site).to receive(:pages) do
        double.tap { |a| expect(a).to receive(:find_or_create_by).with(url: link.to_s).and_return(page) }
      end
    end

    context do
      before { expect(page).to receive(:metric).and_return(nil) }

      before { expect(page).to receive(:create_metric).with(shares_count: 69) }

      it { expect { subject.create }.to_not raise_error }
    end

    context do
      let(:metric) { stub_model Metric }

      before { expect(page).to receive(:metric).and_return(metric) }

      before { expect(metric).to receive(:update).with(shares_count: 69) }

      it { expect { subject.create }.to_not raise_error }
    end
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
