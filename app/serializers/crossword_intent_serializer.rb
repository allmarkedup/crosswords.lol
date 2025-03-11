class CrosswordIntentSerializer < ActiveJob::Serializers::ObjectSerializer
  def serialize(intent)
    super(
      "args" => intent.args,
      "kwargs" => intent.kwargs
    )
  end

  def deserialize(hash)
    CrosswordIntent.new(*hash["args"], **hash["kwargs"])
  end

  private

  def klass
    CrosswordIntent
  end
end
