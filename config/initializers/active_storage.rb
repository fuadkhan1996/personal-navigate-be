Rails.application.config.to_prepare do
  ActiveStorage::Blob.table_name = 'nav_active_storage_blobs'
  ActiveStorage::Attachment.table_name = 'nav_active_storage_attachments'

  ActiveStorage::Blob.class_eval do
    def key
      "navigate/#{super}"
    end
  end
end
