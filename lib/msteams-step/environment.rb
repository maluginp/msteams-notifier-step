#
#  environment.rb
#
#  Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
#

module MSTeamsStep

  class Environment

    def initialize(nenv)
      @nenv = nenv
    end

    def build_title
      nenv.bitrise_app_title
    end

    def build_number
      nenv.bitrise_build_number
    end

    def build_url
      nenv.bitrise_public_install_page_url
    end

    def build_successful?
      !nenv.bitrise_build_status?
    end

    def git_commit
      nenv.git_clone_commit_hash[0...7]
    end

    def git_commit_full
      nenv.git_clone_commit_hash
    end

    def git_message
      nenv.git_clone_commit_message_subject
    end

    def git_author
      "#{nenv.git_clone_commit_commiter_name} (#{nenv.git_clone_commit_commiter_email})"
    end

    def git_branch
      nenv.bitrise_git_branch
    end

    def msteams_webhook_url
      ENV["webhook_url"] || nenv.msteams_webhook_url
    end

    def youtrack_url
      ENV["youtrack_url"] || nenv.msteams_youtrack_url
    end

    def gitlab_internal_url
      url = ENV["gitlab_url"] || nenv.msteams_gitlab_url
      "#{url}#{git_commit_full}"
    end
        
    def msteams_username
      "Bitrise"
    end

    def msteams_icon_emoji
      ":bitrise:"
    end

    def xcode_scheme
      nenv.bitrise_scheme
    end

    private

    attr_reader :nenv

  end

end
