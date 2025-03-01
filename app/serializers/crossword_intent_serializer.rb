class CrosswordIntentSerializer < ActiveJob::Serializers::ObjectSerializer
  def serialize(intent)
    super(
      "identifier" => intent.identifier,
      "args" => intent.args,
      "kwargs" => intent.kwargs
    )
  end

  def deserialize(hash)
    CrosswordIntent.resolve(hash["identifier"]).new(*hash["args"], **hash["kwargs"])
  end

  private

  def klass
    CrosswordIntent
  end
end
