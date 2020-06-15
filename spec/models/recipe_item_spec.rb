require 'rails_helper'

RSpec.describe RecipeItem do
  []
  .each { |attr| it { is_expected.to validate_presence_of(attr) } }
end
