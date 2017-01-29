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
      '*Build  #{build_verb}: [##{env.build_number}](##{env.git_commit} by #{env.git_author} on #{env.git_branch})*<br/>'\
      '**Commit message:**\n #{env.git_message}'
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
      acts = []

      acts << field_build_page
      acts << field_gitlab_page

      git_commit.scan(/\#[a-zA-Z0-9\-]+/) { |match| acts << {
        '@context' => 'https://schema.org',
        '@type' => 'ViewAction',
        name: 'Open issue: #{match}',
        target: ["#{env.youtrack_url}#{match[1..-1]}"]
      }}

      acts
    end

    private

    attr_reader :env

    def build_verb
      env.build_successful? ? "succeeded" : "failed"
    end

    

    def field_gitlab_page
      {
        '@context' => 'https://schema.org',
        '@type' => 'ViewAction',
        name: 'Show commit in Gitlab',
        target: [env.gitlab_internal_url]
      }
    end

    def field_build_page
      {
          '@context' => 'https://schema.org',
          '@type' => 'ViewAction',
          name: 'Show build page',
          target: [build_url]
      }
    end



  end

end
