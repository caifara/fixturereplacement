module FixtureReplacementController
  # ARClassInstance = ActiveRecord Class Instance
  class ARClassInstance
    
    def initialize(attributes, hash={}, original_caller=self)
      @attributes, @hash_given_to_constructor, @caller = attributes, hash, original_caller
    end

    def to_created_instance
      created_obj = self.to_new_instance
      created_obj.save!
      created_obj
    end
    
    def hash_given_to_constructor
      @hash_given_to_constructor || Hash.new
    end

    def to_new_instance
      new_object = @attributes.of_class.new
      assign_values_to_instance new_object
      return new_object
    end
    
    def all_attributes
      @attributes.merge!
      @all_merged_attributes ||= attributes_hash.merge(self.hash_given_to_constructor)
    end

  private
  
    def attributes_hash
      @attributes.hash
    end

    def find_value_from_delayed_evaluation_proc(value)
      default_obj, params = value.call
      value = @caller.__send__("create_#{default_obj.fixture_name}", params)
    end

    def assign_values_to_instance instance_object
      all_attributes.each do |key, value|          
        if value.is_a? DelayedEvaluationProc
          value = find_value_from_delayed_evaluation_proc(value)
        end
        instance_object.__send__("#{key}=", value)             
      end
    end
  end
end