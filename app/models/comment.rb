class Comment < ActiveRecord::Base
  opinio

  def bit
    commentable if commentable.kind_of?(Bit)
  end
end
