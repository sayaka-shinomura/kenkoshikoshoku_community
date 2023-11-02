module Public::HomesHelper

  def content_text
    <<-"EOS".strip_heredoc
ご意見・ご要望を入力してください。
頂いたご意見・ご要望は管理者が確認後、対応させていただきます。

リクエスト例
・〇〇〇のレシピを投稿したいので、野菜一覧に追加してほしい
・△△△の栄養素情報を充実させてほしい

※リクエストの投稿にはユーザー登録が必要です。
    EOS
  end


end
