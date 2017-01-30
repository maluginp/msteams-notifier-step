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
      "#{env.build_title} #{build_verb}"
    end  

    def text
      "*Build ##{env.build_number} (Commit [#{env.git_commit}](#{env.gitlab_internal_url}) by #{env.git_author} on #{env.git_branch})*<br/>**Commit message:**<br/>#{env.git_message}<br/>**Issues:**<br/>#{issues}"
    end

    def build_url
      env.build_url
    end

    def border_color
      env.build_successful? ? "008000" : "EA4300"
    end

    def

    def fields
      [
        field_commit,
        field_jira,
        field_scheme,
      ].compact
    end

    def actions
      [{
          '@context' => 'https://schema.org',
          '@type' => 'ViewAction',
          name: 'Show build page',
          target: [env.build_url]
      }]
    end

    private

    attr_reader :env

    def build_verb
      env.build_successful? ? "succeeded" : "failed"
    end

    def issues
      str = ""
      env.git_message.scan(/\#[a-zA-Z0-9\-]+/m) { |match| str << "[Issue #{match}](#{env.youtrack_url}#{match[1..-1]})<br/>" }
      if str == ""
        str = "Issues not found"
      end

      str
    end



  end

end
