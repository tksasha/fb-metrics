require 'rails_helper'

RSpec.describe URIParser do
  subject { described_class.new url }

  context do
    let(:url) { 'www.tksasha.me' }

    its(:scheme) { should eq 'http' }

    its(:hostname) { should eq 'www.tksasha.me' }

    its(:scheme_and_host) { should eq 'http://www.tksasha.me' }
  end

  context do
    let(:url) { 'https://www.tksasha.me' }

    its(:scheme) { should eq 'https' } 

    its(:hostname) { should eq 'www.tksasha.me' }

    its(:scheme_and_host) { should eq 'https://www.tksasha.me' }
  end

  context do
    let(:url) { 'http://www.tksasha.me/companies.html' }

    its(:scheme) { should eq 'http' }

    its(:hostname) { should eq 'www.tksasha.me' }

    its(:scheme_and_host) { should eq 'http://www.tksasha.me' }
  end

  context do
    let(:url) { 'www.tksasha.me/companies.html' }

    its(:scheme) { should eq 'http' }

    its(:hostname) { should eq 'www.tksasha.me' }

    its(:scheme_and_host) { should eq 'http://www.tksasha.me' }
  end

  context do
    let(:url) { '//www.tksasha.me/companies.html' }

    its(:scheme) { should eq 'http' }

    its(:hostname) { should eq 'www.tksasha.me' }

    its(:scheme_and_host) { should eq 'http://www.tksasha.me' }
  end
end
