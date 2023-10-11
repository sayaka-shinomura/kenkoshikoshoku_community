module Public::ReviewsHelper

  def comment_text
    <<-"EOS".strip_heredoc
レシピへのコメントを入力してください。
コメントは入力しなくても、レシピ評価はできます。
    EOS
  end

end
