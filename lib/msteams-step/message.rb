#
#  message.rb
#
#  Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
#

module MSTeamsStep

  class Message

    def initialize(env)
      @env = env
    end

    def fallback
      "Build #{build_verb}: ##{env.build_number} (#{env.git_commit} by #{env.git_author} on #{env.git_branch})"
    end

    def title
      "#{env.build_title}"
    end  

    def text
      "*Build #{build_verb}: [##{env.build_number}](#{env.git_commit} by #{env.git_author} on #{env.git_branch})*"
    end

    def build_url
      env.build_url
    end

    def border_color
      @env.build_successful? ? "008000" : "EA4300"
    end

    def

    def fields
      [
        field_commit,
        field_jira,
        field_scheme,
      ].compact
    end

    private

    attr_reader :env

    def build_verb
      env.build_successful? ? "succeeded" : "failed"
    end

    def field_commit
      {
        title: "Commit",
        value: env.git_message,
        short: false,
      }
    end

    def field_jira
      env.jira_task.nil? ? nil : {
        title: "Task",
        value: "[#{env.jira_task}](https://#{env.jira_domain}.atlassian.net/browse/#{env.jira_task})",
        short: true,
      }
    end

    def field_scheme
      {
        title: "Scheme",
        value: env.xcode_scheme,
        short: true,
      }
    end

  end

end
