FactoryBot.define do
  factory :user do
    nickname {Faker::Name.initials(number: 2)}
    email {Faker::Internet.free_email}
    password {"1a" + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    family_name {"山田"}
    first_name {"剛"}
    family_name_kana {"ヤマダ"}
    first_name_kana {"ツヨシ"}
    birthday{"2005-10-15"}
  end
end