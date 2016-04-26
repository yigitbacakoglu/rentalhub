class Image < Asset
  has_attached_file :attachment, styles: {large: '1024x768>', medium: "300x300>", thumb: "100x100>"},
                    default_url: "/assets/missing.png"

  validates_attachment_content_type :attachment, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)'


end