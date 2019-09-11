module Xhash
  ProofOfAddress =
    Struct.new(
      :full_name,
      :street,
      :neighborhood,
      :zip_code,
      :city,
      :province,
      :type,
      :exception
    )
end
