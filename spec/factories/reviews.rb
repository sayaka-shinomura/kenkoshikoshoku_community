FactoryBot.define do
  factory :review, class: Review do
    star { "4" }
    comment { "テストコメント" }
    img {"Rack::Test::UploadedFile.new(File.join(Rails.root,'app/assets/images/star_off.png'))"}
  end
end
