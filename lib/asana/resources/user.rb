### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.

module Asana
  module Resources
    # A _user_ object represents an account in Asana that can be given access to
    # various workspaces, projects, and tasks.
    #
    # Like other objects in the system, users are referred to by numerical IDs.
    # However, the special string identifier `me` can be used anywhere
    # a user ID is accepted, to refer to the current authenticated user.
    class User < Resource


      attr_reader :id

      attr_reader :email

      attr_reader :photo

      attr_reader :workspaces

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'users'
        end

        # Returns the full user record for the currently authenticated user.
        #
        # options - [Hash] the request I/O options.
        def me(client, options: {})

          Resource.new(parse(client.get("/users/me", options: options)).first, client: client)
        end

        # Returns the full user record for a single user.
        #
        # id - [Id] Globally unique identifier for the user.
        #
        # options - [Hash] the request I/O options.
        def find_by_id(client, id, options: {})

          self.new(parse(client.get("/users/#{id}", options: options)).first, client: client)
        end

        # Returns the user records for all users in all workspaces and organizations
        # accessible to the authenticated user.
        #
        # workspace - [Id] The workspace in which to get users.
        # limit - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_by_workspace(client, workspace:, limit: 20, options: {})
          params = { limit: limit }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/workspaces/#{workspace}/users", params: params, options: options)), type: self, client: client)
        end

        # Returns the user records for all users in the specified workspace or
        # organization.
        #
        # workspace - [Id] The workspace or organization to filter users on.
        # limit - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_all(client, workspace: nil, limit: 20, options: {})
          params = { workspace: workspace, limit: limit }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/users", params: params, options: options)), type: self, client: client)
        end
      end

    end
  end
end
