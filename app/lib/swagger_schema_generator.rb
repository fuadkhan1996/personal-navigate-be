# frozen_string_literal: true

module SwaggerSchemaGenerator
  def self.generate_schemas
    schemas = {}
    ApplicationBlueprint.descendants.each do |blueprint|
      blueprint.openapi_schema.each do |blueprint_name, schema|
        schemas[blueprint_name] = schema
      end
    end

    schemas.merge(error_schemas, session_success_schema, success_message_schema)
  end

  def self.success_message_schema
    {
      'SuccessMessage' => generate_success_message_schema,
      'SuccessMessageWithId' => generate_success_message_schema.deep_merge(
        properties: {
          id: { type: :string } # Add the id property
        }
      )
    }
  end

  def self.generate_success_message_schema
    {
      type: :object,
      properties: {
        message: { type: :string }
      },
      nullable: false,
      required: true
    }
  end

  def self.session_success_schema
    schema = {}
    extended_schema = Dc::CompanyEmployeeBlueprint.openapi_schema['Dc::CompanyEmployeeBlueprintExtended']
    success_schema = extended_schema[:properties].merge(
      access_token: { type: :string, nullable: false, required: true },
      refresh_token: { type: :string, nullable: false, required: true },
      token_expires_in: { type: :integer, nullable: false, required: true }
    )

    schema['SessionSuccess'] = {
      type: :object,
      properties: success_schema
    }

    schema
  end

  def self.error_schemas
    {
      'Error422' => error_422_schema,
      'GeneralError' => generic_error_schema
    }
  end

  def self.generic_error_schema
    {
      type: :object,
      properties: {
        error: { type: :string }
      },
      required: ['error']
    }
  end

  def self.error_422_schema
    {
      type: :object,
      properties: {
        errors: {
          type: :object,
          additionalProperties: {
            type: :array,
            items: {
              type: :string
            }
          }
        }
      },
      required: ['errors']
    }
  end
end
