module Xhash
  Identification =
    Struct.new(
      :lines,
      :cic,
      :cic_digit_check,
      :is_cic_digit_check_consistent,
      :section_and_consecutive,
      :date,
      :date_check_digit,
      :expiration_date,
      :expiration_date_digit,
      :nationality,
      :emission_and_fuar,
      :name,
      :mothers_last_name,
      :last_name,
      :last_names,
      :birth_date,
      :gender,
      :elector_key,
      :curp,
      :street,
      :neighborhood,
      :zip_code,
      :city,
      :province,
      :type
    )
end
