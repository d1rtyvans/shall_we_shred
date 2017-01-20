module ShredClient
  class SmsMessenger
    def self.notify_user(user, day)
      from = "+1#{ENV['TWILIO_NUMBER']}"
      client.account.messages.create(
        from: from,
        to: "+1#{user.phone_number}",
        body: "You should shred on #{day}",
      )
    end

    private

      def self.client
        Twilio::REST::Client.new(
          ENV.fetch("TWILIO_SID"),
          ENV.fetch("TWILIO_AUTH_TOKEN"),
        )
      end
  end
end
