class CryptoCurrencyRateService
  URL = 'https://api.coincap.io/v2/assets'.freeze

  def current_currency_rates
    response = HTTParty.get(URL)
    res_json = JSON.parse(response.body)
    data = res_json['data']
    current_currency_rate_hash = {}
    
    data.each do |item|
      current_currency_rate_hash[item['symbol']] =  item['priceUsd']
    end

    current_currency_rate_hash
  rescue StandardError => e
    UpdateCostLog.create(context: 'CryptoCurrencyRateService', params: e.message)
    Rails.logger.info e.message
    raise e
  end
end