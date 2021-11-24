class HomeController < ApplicationController
  def index
    @crypto_currencies = CryptoCurrency.all
  end
end
