User.destroy_all
Language.destroy_all
Feedback.destroy_all
Tone.destroy_all

User.create!(api_key: 'IADYZALPBPUBAOTLJYDX', role: 'admin')

User.create!(api_key: 'DBYHJAFVGHLAJQRORTGI')
User.create!(api_key: 'LDGKONCTMFXCXTYMLHDJ')
User.create!(api_key: 'MKTJAMBVHANLGRXNOFT')
User.create!(api_key: 'OWVXJROXRMLJVVSTKGVB')
User.create!(api_key: 'GCWCNVTAHTGQHRYNLLVM')
User.create!(api_key: 'PZWVCUGIHDXJTCTAOOKU')
User.create!(api_key: 'KPPXKFICUMUOBQAGJCBV')
User.create!(api_key: 'JJRUCHMKVDOZURSJAQDS')

IBMWatsonService.new.get_identifiable_languages.each do |language|
  Language.create!(abbr: language['language'], name: language['name'])
end

100.times do
  user = User.order('RANDOM()').first
  user.feedbacks.create!(message: Faker::Shakespeare.king_richard_iii_quote)
end
