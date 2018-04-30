require 'test_helper'

class FirebaseCloudMessenger::FirebaseObjectTest < MiniTest::Spec
  FIELDS = %i(field1 field2)

  class FireBaseObjectSubclass < FirebaseCloudMessenger::FirebaseObject
    attr_accessor(*FIELDS)

    def initialize(data)
      super(data, FIELDS)
    end
  end

  describe '#new' do
    it 'throws an ArgumentError if key is not in fields' do
      args = FIELDS.each_with_object({}) { |field, hash| hash[field] = true }.
        merge(missing_key: true)

      assert_raises ArgumentError do
        FireBaseObjectSubclass.new(args)
      end
    end

    it 'does not alter the original hash arg' do
      args = FIELDS.each_with_object({}) { |field, hash| hash[field] = true }
      duped_args = args.dup

      FireBaseObjectSubclass.new(args)

      assert_equal args, duped_args
    end
  end
end
