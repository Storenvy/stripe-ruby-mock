module StripeMock
  module TestStrategies
    class Base

      def create_plan_params(params={})
        {
          :id => 'stripe_mock_default_plan_id',
          :name => 'StripeMock Default Plan ID',
          :amount => 1337,
          :currency => 'usd',
          :interval => 'month'
        }.merge(params)
      end

      def generate_card_token(card_params={})
        date_time = Time.now + 6.months
        card_data = { :number => "4242424242424242", :exp_month => date_time.month, :exp_year => date_time.year, :cvc => "999" }
        card = StripeMock::Util.card_merge(card_data, card_params)
        card[:fingerprint] = StripeMock::Util.fingerprint(card[:number])

        stripe_token = Stripe::Token.create(:card => card)
        stripe_token.id
      end

    end
  end
end
