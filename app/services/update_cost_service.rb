class UpdateCostService
  SATOSHIES = ['BTC', 'BSV']
  SMART_CHAINS = ['BNB', 'ETH']
  AMOUNT_BYTE = 192
  SMART_CHAIN_GAS = 21000

  def initialize
    @rate_service = CryptoCurrencyRateService.new.current_currency_rates
    @current_cost_service = CurrentCostService.new
  end
  
  def get_single_transaction_cost(cryto_currency, current_cost, current_rate)
    cost = nil
    if SATOSHIES.include?(cryto_currency.short_name)
      cost = current_cost * AMOUNT_BYTE * current_rate * 10.pow(-8)
    end

    if SMART_CHAINS.include?(cryto_currency.short_name)
      cost = SMART_CHAIN_GAS * current_cost * current_rate * 10.pow(-9)
    end

    cost
  end

  def update_cost_for(cryto_currency)
    current_cost = @current_cost_service.send(cryto_currency.short_name.downcase)
    current_rate = @rate_service[cryto_currency.short_name]&.to_f
    if current_cost && current_rate
      single_cost = get_single_transaction_cost(cryto_currency, current_cost, current_rate)
      if single_cost
        multisig_cost = single_cost * cryto_currency.multiisg_factor if cryto_currency.multiisg_factor
        cryto_currency.update!(single_transaction_cost: single_cost, multisig_transaction_cost: multisig_cost)
      end
    end
  end
  
  def batch_update
    CryptoCurrency.find_each do |cryto_currency|
      update_cost_for(cryto_currency)
    end
  end
end