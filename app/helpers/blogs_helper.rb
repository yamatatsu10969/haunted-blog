# frozen_string_literal: true

module BlogsHelper
  def split_content_to_lines(blog)
    blog.content.split("\n")
  end
end
