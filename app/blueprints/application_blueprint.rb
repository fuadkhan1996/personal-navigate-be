# frozen_string_literal: true

module ApiFieldHelpers
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_reader :current_api_view

    def openapi_schema_name
      name.gsub('::', '')
    end

    def api_fields
      @api_fields ||= {}
    end

    def api_associations
      @api_associations ||= []
    end

    def api_views
      @api_views ||= {}
    end

    def api_identifier(name)
      api_fields[name] = { type: :string, required: true, nullable: false }
      identifier(name)
    end

    def api_field(name, options = {}, &)
      field_metadata = build_field_metadata(options)
      target = current_api_view ? api_views[current_api_view][:fields] : api_fields
      target[name] = field_metadata
      field(name, options, &)
    end

    def api_association(name, options = {})
      assoc_metadata = build_assoc_metadata(name, options)
      api_associations << assoc_metadata

      if current_api_view
        api_views[current_api_view][:associations] << assoc_metadata
      else
        api_views.each_value { |view_data| view_data[:associations] << assoc_metadata }
      end

      association(name, **options)
    end

    def api_view(name, &block)
      api_views[name] ||= { fields: {}, associations: [] }
      @current_api_view = name

      view(name) { instance_eval(&block) }

      @current_api_view = nil
    end

    def include_api_view(name)
      included_view = api_views[name]
      raise "View #{name} not found" unless included_view

      current_view = api_views[@current_api_view]
      current_view[:fields].merge!(included_view[:fields])
      current_view[:associations] += included_view[:associations]
      include_view(name)
    end

    private

    def build_field_metadata(options)
      is_array = options.fetch(:type, :string) == :array
      metadata = {
        type: is_array ? :array : options.fetch(:type, :string),
        required: options.fetch(:required, false),
        nullable: options.fetch(:nullable, false),
        enum: options[:enum],
        description: options[:description]
      }
      metadata[:items] = options.fetch(:items, { type: :object }) if is_array
      metadata
    end

    def build_assoc_metadata(name, options)
      is_array = options.fetch(:type, :object) == :array
      {
        name:,
        serializer: options[:blueprint],
        required: options.fetch(:required, false),
        nullable: options.fetch(:nullable, false),
        description: options[:description],
        view: current_api_view,
        nested_view: options[:view],
        type: is_array ? :array : :object
      }
    end
  end
end

class ApplicationBlueprint < Blueprinter::Base
  include CurrentContextHelper
  include ApiFieldHelpers

  def self.openapi_schema
    schemas = {}

    # Default schema
    add_default_schema(schemas)

    # Add global associations
    add_global_associations(schemas)

    # View-specific schemas
    add_view_specific_schemas(schemas)

    schemas
  end

  def self.openapi_properties(fields)
    fields.transform_values do |field|
      property = {
        type: field[:type],
        enum: field[:enum],
        description: field[:description],
        nullable: field[:nullable]
      }.compact

      # Add the `items` property for arrays
      property[:items] = field[:items] if field[:type] == :array

      property
    end
  end

  def self.openapi_required_fields(fields)
    fields.select { |_, v| v[:required] }.keys
  end

  def self.add_default_schema(schemas)
    schemas[openapi_schema_name] = {
      type: :object,
      properties: openapi_properties(api_fields),
      required: openapi_required_fields(api_fields)
    }
  end

  def self.add_global_associations(schemas)
    api_associations.each do |assoc|
      next if assoc[:view]

      schema_key = assoc[:type] == :array ? :items : :$ref
      schemas[openapi_schema_name][:properties][assoc[:name]] = {
        type: assoc[:type],
        schema_key => assoc[:type] == :array ? { '$ref' => ref_key(assoc) } : ref_key(assoc)
      }.compact
    end
  end

  def self.add_view_specific_schemas(schemas)
    api_views.each do |view_name, view_data|
      view_key = build_view_key(view_name)
      all_fields = api_fields.merge(view_data[:fields])

      schemas[view_key] = {
        type: :object,
        properties: openapi_properties(all_fields),
        required: openapi_required_fields(all_fields)
      }

      add_associations_to_schema(schemas, view_key, view_data[:associations])
    end
  end

  def self.build_view_key(view_name)
    "#{openapi_schema_name}#{view_name.to_s.camelize}"
  end

  def self.add_associations_to_schema(schemas, view_key, associations)
    associations.each do |assoc|
      schema_key = assoc[:type] == :array ? :items : :$ref
      schemas[view_key][:properties][assoc[:name]] = {
        type: assoc[:type],
        schema_key => assoc[:type] == :array ? { '$ref' => ref_key(assoc) } : ref_key(assoc)
      }.compact
    end
  end

  def self.ref_key(assoc)
    "#/components/schemas/#{assoc[:serializer].to_s.gsub('::', '')}#{assoc[:nested_view]&.to_s&.camelize}"
  end
end
