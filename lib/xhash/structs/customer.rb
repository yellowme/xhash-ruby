module Xhash
  Customer =
    Struct.new(
      :id,
      :name,
      :last_name,
      :mothers_last_name,
      :gender,
      :birth_date,
      :birth_city,
      :birth_country,
      :curp,
      :renapo_match,
      :rfc,
      :rfc_match,
      :rfc_is_cancelled,
      :zip_code,
      :neighborhood,
      :province,
      :city,
      :country,
      :address,
      :activity,
      :electoral_key,
      :clabe,
      :ext_address,
      :email,
      :phone_number,
      :in_black_list,
      :black_list_name,
      :liveness_video,
      :liveness_check,
      :document_id,
      :client_id,
      :external_customer_id,
      :update_key,
      :device_fingerprint_id,
      :token_email,
      :email_verified_at,
      :token_sm,
      :sms_verified_at,
      :deleted_at,
      :created_at,
      :updated_at,
      :ip_uniqueness,
      :fingerprint_uniqueness,
      :documents
    )
end