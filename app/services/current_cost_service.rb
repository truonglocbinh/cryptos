class CurrentCostService
  BTC_URL = 'https://api.blockchain.info/mempool/fees'.freeze
  BSV_URL = 'https://mapi.taal.com/mapi/feeQuote'.freeze
  BSC_URL = 'https://api.bscscan.com/api?module=gastracker&action=gasoracle'
  ETH_URL = 'https://api.etherscan.io/api?module=gastracker&action=gasoracle'
  
  BSC_URL_API_KEY = ENV['BSC_API_KEY']
  ETH_URL_API_KEY = ENV['ETH_API_KEY']
  
  def btc
    res_json = request(BTC_URL)
    res_json['priority']
  end

  def eth
    api_url = "#{ETH_URL}&apikey=#{ETH_URL_API_KEY}"
    smart_chain_gas(api_url)
  end

  def bnb
    api_url = "#{BSC_URL}&apikey=#{BSC_URL_API_KEY}"
    smart_chain_gas(api_url)
  end

  def bsv
    res_json = request(BSV_URL)
    payload = JSON.parse(res_json['payload'])
    fees = payload['fees']
    standard_fee = fees.find { |item| item['feeType'] == 'standard' }
    standard_fee&.dig('miningFee')&.dig('satoshis')
  end

  private

  def request(url)
    response = HTTParty.get(url)
    res_json = JSON.parse(response.body)
    raise "Non-200 Response from #{response.code}" unless response.code == 200

    res_json
  rescue StandardError => e
    UpdateCostLog.create(context: 'CurrentCostService', params: url)
    Rails.logger.info e.message
    raise e
  end

  def smart_chain_gas(api_url)
    res_json = request(api_url)
    res_json&.dig('result')&.dig('FastGasPrice')&.to_f
  end
end