class Document < ApplicationRecord
  mount_uploader :content, DocumentUploader

  belongs_to :documentable, polymorphic: true

  validates :content, presence: true

  def name
    if new_record?
      super
    else
      self[:name] = self[:name].blank? ? content.file.filename : self[:name]
    end
  end
end
