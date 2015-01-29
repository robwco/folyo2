json.array!(@faqs) do |faq|
  json.extract! faq, :id, :category, :question, :answer, :notes
  json.url faq_url(faq, format: :json)
end
