### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.

module Asana
  module Resources
    # A _workspace_ is the highest-level organizational unit in Asana. All projects
    # and tasks have an associated workspace.
    #
    # An _organization_ is a special kind of workspace that represents a company.
    # In an organization, you can group your projects into teams. You can read
    # more about how organizations work on the Asana Guide.
    # To tell if your workspace is an organization or not, check its
    # `is_organization` property.
    #
    # Over time, we intend to migrate most workspaces into organizations and to
    # release more organization-specific functionality. We may eventually deprecate
    # using workspace-based APIs for organizations. Currently, and until after
    # some reasonable grace period following any further announcements, you can
    # still reference organizations in any `workspace` parameter.
    class Workspace < Resource


      attr_reader :id

      attr_reader :name

      attr_reader :is_organization

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'workspaces'
        end

        # Returns the full workspace record for a single workspace.
        #
        # id - [Id] Globally unique identifier for the workspace or organization.
        #
        # options - [Hash] the request I/O options.
        def find_by_id(client, id, options: {})

          self.new(parse(client.get("/workspaces/#{id}", options: options)).first, client: client)
        end

        # Returns the compact records for all workspaces visible to the authorized user.
        #
        # limit - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_all(client, limit: 20, options: {})
          params = { limit: limit }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/workspaces", params: params, options: options)), type: self, client: client)
        end
      end

      # Update properties on a workspace. Returns the complete, updated workspace record.
      #
      # options - [Hash] the request I/O options.
      # data - [Hash] the attributes to post.
      def update(options: {}, **data)

        refresh_with(parse(client.put("/workspaces/#{id}", body: data, options: options)).first)
      end

      # Retrieves objects in the workspace based on an auto-completion/typeahead
      # search algorithm. This feature is meant to provide results quickly, so do
      # not rely on this API to provide extremely accurate search results. The
      # result set is limited to a single page of results with a maximum size,
      # so you won't be able to fetch large numbers of results.
      #
      # type - [Enum] The type of values the typeahead should return.
      # Note that unlike in the names of endpoints, the types listed here are
      # in singular form (e.g. `task`). Using multiple types is not yet supported.
      #
      # query - [String] The string that will be used to search for relevant objects. If an
      # empty string is passed in, the API will currently return an empty
      # result set.
      #
      # count - [Number] The number of results to return. The default is `20` if this
      # parameter is omitted, with a minimum of `1` and a maximum of `100`.
      # If there are fewer results found than requested, all will be returned.
      #
      # limit - [Integer] the number of records to fetch per page.
      # options - [Hash] the request I/O options.
      def typeahead(type:, query: nil, count: nil, limit: 20, options: {})
        params = { type: type, query: query, count: count, limit: limit }.reject { |_,v| v.nil? || Array(v).empty? }
        Collection.new(parse(client.get("/workspaces/#{id}/typeahead", params: params, options: options)), type: Resource, client: client)
      end

    end
  end
end
