#encoding: UTF-8

FactoryGirl.define do
  
  factory :user do
    name "Test User"
    student_id "B00902109"
    facebook_uid 1

    factory :raincole do
      name "賴宇宣"
      student_id "B00902109"
      facebook_uid "100000353465634"
    end

    factory :zeta do
      name "David Chang"
      student_id "B00902090"
      facebook_uid "1548642426"
    end
  end

end


