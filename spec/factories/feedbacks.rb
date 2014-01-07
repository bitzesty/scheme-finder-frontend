include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :feedback do
    scheme_id 1
    score 1
    description "They provide good knowledge base"
  end
end
