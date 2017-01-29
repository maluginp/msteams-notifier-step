#
#  client.rb
#
#  Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
#

module MSTeamsStep

  class Client

    def initialize(env)
      @env = env
    end

    def send(message)
      # print 'WebHook Url: ', env.msteams_webhook_url, "\n"
      HTTParty.post(
        env.msteams_webhook_url, 
        :body => JSON.dump({
          title: message.title,
          text: message.text,
          themeColor: message.border_color,
          potentialAction: [{
              '@context' => 'https://schema.org',
              '@type' => 'ViewAction',
              name: 'Show build page',
              target: [message.build_url]
          }]
        }), 
        :headers => {
            'Content-Type' => 'application/json', 
        } 
      )

# "potentialAction\": [{\"@context\": \"https://schema.org\", \"@type\": \"ViewAction\", \"name\": \"Open Outlook Dev Center\", \"target\": [\"https://dev.outlook.com\"]}
      # slack_notifier.ping({
      #   attachments: [{
      #     fallback: message.fallback,
      #     text: message.title,
      #     fields: message.fields.map { |field| field_with_formatted_value(field) },
      #     color: message.border_color,
      #     mrkdwn_in: [:text]
      #   }],
      # }).code.to_i.between?(200, 299)
    end

    private

    attr_reader :env

    # def slack_notifier
    #   @slack_notifier ||= Slack::Notifier.new(env.slack_webhook_url, {
    #     channel: env.slack_channel,
    #     username: env.slack_username,
    #     icon_emoji: env.slack_icon_emoji,
    #   })
    # end

    # def field_with_formatted_value(field)
    #   cloned_field = field.clone
    #   cloned_field[:value] = Slack::Notifier::LinkFormatter.format(field[:value])
    #   cloned_field
    # end

  end

end
