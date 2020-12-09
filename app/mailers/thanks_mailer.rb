class ThanksMailer < ApplicationMailer
  
  def send_confirm_to_user(user, thanks)
    # ユーザー情報
    @user = user
    # 返信内容
    @answer = thanks.reply_text
    # mail to:(宛先) user.email => send_confirm_to_userメソッドを呼び出す時に渡されるユーザーの情報から、emailアドレスだけを取り出してメールの送信先とする
    #      subject:(件名) => メールのタイトル
    mail to: user.email, subject: '【TEST】 登録完了'
  end
end
