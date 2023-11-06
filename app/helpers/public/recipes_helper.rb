module Public::RecipesHelper

  def process_text
    <<-"EOS".strip_heredoc
    内容を入力してください。
    手順番号は自動で付けられますので、重複記入にお気をつけください。
    EOS
  end

end
