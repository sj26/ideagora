require "state_machine"

StateMachine::Integrations::ActiveModel.send(:public, :around_validation)
