module FixtureReplacementController
  module ClassFactory
    
    module_function

    def active_record_factory
      ActiveRecordFactory
    end

    def method_generator
      MethodGenerator
    end
    
    def attribute_collection
      AttributeCollection
    end
    
    def fixture_replacement_module
      ::FixtureReplacement
    end
    
    def delayed_evaluation_proc
      ::DelayedEvaluationProc
    end
    
    def fake_active_record_instance
      OpenStruct
    end
  end
end