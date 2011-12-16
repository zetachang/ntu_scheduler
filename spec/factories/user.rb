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
    
    factory :user1 do
      name "謝明華"
      student_id "B00502103"
      facebook_uid "100001157041249"
    end
    
    factory :user2 do
      name "吳東達"
      student_id "B00504101"
      facebook_uid "100002364744996"
    end
    
    factory :user3 do
      name "吳雨澄"
      student_id "B00902037"
      facebook_uid "100000068469354"
    end
    
    factory :user4 do
      name "白惠婷"
      student_id "B00902094"
      facebook_uid "100002324215514"
    end
  end

end


