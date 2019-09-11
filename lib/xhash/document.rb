module Xhash
  Document =
    Struct.new(
      :lines,
      :cic,
      :cic_digit_check,
      :is_cic_digit_check_consistent,
      :section_and_consecutive,
      :date,
      :date_check_digit,
      :gender,
      :expiration_date,
      :expiration_date_digit,
      :nationality,
      :emission_and_fuar,
      :name,
      :mothers_last_name,
      :last_name,
      :last_names
    )
end
