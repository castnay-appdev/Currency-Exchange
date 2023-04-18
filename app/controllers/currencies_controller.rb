class CurrenciesController < ApplicationController

  def first_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    render({ :template => "currency_templates/step_one.html.erb"})
  end

  def second_currency

    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys
    # params are 
    #Parameters: {"from_currency" => "ARS"}

    @from_symbol = params.fetch("from_currency")
    render({ :template => "currency_templates/step_two.html.erb" })
  end

  def convert_currency

    @from_currency = params.fetch("from_currency")
    @to_currency = params.fetch("to_currency")


    url = "https://api.exchangerate.host/convert?from=#{@from_currency}&to=#{@to_currency}"

   

    @conversion_info_raw = open(url).read
    @conversion_info_parsed = JSON.parse(@conversion_info_raw)
   
    #@exchange_hash = fetch("info")
    @exchange_rate = @conversion_info_parsed.dig( "info", "rate")

    

    
    render({ :template => "currency_templates/step_three.html.erb" })
  end

end
