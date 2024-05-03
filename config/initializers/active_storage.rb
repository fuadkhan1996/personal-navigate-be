Rails.application.config.to_prepare do
  ActiveStorage::Blob.table_name = 'nav_active_storage_blobs'
  ActiveStorage::Attachment.table_name = 'nav_active_storage_attachments'

  ActiveStorage::Blob.class_eval do
    before_create :generate_key_with_prefix

    def generate_key_with_prefix
      self.key = if prefix
        File.join prefix, self.class.generate_unique_secure_token
      else
        self.class.generate_unique_secure_token
      end
    end

    def prefix
      'navigate'
    end
  end
end
