RSpec.describe Request do
  before { subject.get('https://telegram.org/') }

  describe '#get' do
    it 'sends GET request' do
      expect(subject.get('https://telegram.org/').code).to eq '200'
    end
  end

  describe '#uri' do
    it 'returns URI' do
      expect(subject.uri).to be_a URI
    end
  end

  describe '#response' do
    it 'returns response' do
      expect(subject.response).to be_a Net::HTTPOK
    end
  end

  describe '#resp_status' do
    it 'returns response status' do
      expect(subject.resp_status).to eq '200'
    end
  end

  describe '#resp_body' do
    it 'returns response body' do
      expect(subject.resp_body.include?('DOCTYPE')).to eq true
    end
  end

  describe 'resp_headers' do
    it 'returns response headers' do
      expect(subject.resp_headers).to be_a Hash
    end
  end
end
