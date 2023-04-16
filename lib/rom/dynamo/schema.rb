# frozen_string_literal: true

require "rom/types"
require "rom/schema"

module Rom
  module Dynamo
    # Dynamo relation schema
    #
    # @api public
    class Schema < ROM::Schema
      # Return a hash with mapping properties
      #
      # @api private
      def to_properties
        select(&:properties?).map { |attr| [attr.name, attr.properties] }.to_h
      end

      # Customized output hash constructor which symbolizes keys
      # and optionally applies custom read-type coercions
      #
      # @api private
      def to_output_hash
        ROM::Types::Hash
          .schema(map { |attr| [attr.key, attr.to_read_type] }.to_h)
          .with_key_transform(&:to_sym)
      end
    end
  end
end
