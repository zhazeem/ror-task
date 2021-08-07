module Serializable
  extend ActiveSupport::Concern

  def render_serializable(data, serializer = nil)
    if serializer
      ActiveModelSerializers::SerializableResource.new(data, each_serializer: serializer)
    else
      ActiveModelSerializers::SerializableResource.new(data)
    end
  end
end