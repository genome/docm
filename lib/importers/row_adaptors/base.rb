module Importers
  module RowAdaptors
    class Base
      def self.create_from_row(row)
        model_class.where(get_property_hash_from_row(row))
          .first_or_create
      end

      def self.get_property_hash_from_row(row)
        column_map.inject({}) do |object_hash, (column_name, object_property)|
          value = row[column_name].strip
          object_hash.tap { |h| h[object_property] = value.blank? ? nil : value }
        end
      end

      def self.model_class
        raise 'Not implemented!'
      end

      def self.column_map
        raise 'Not implemented!'
      end

    end
  end
end
