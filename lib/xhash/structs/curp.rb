module Xhash
  CURP =
    Struct.new(
      :curp,
      :name,
      :last_name,
      :mothers_last_name,
      :gender,
      :province_of_birth,
      :day_of_birth,
      :updated_at,
      :created_at,
      :id
    )
end
