module Xhash
  ProofOfAddress =
    Struct.new(
      :full_name,
      :full_address,
      :street,
      :neighborhood,
      :zip_code,
      :city,
      :province,
      :type,
      :date,
      :exception
    )
end
