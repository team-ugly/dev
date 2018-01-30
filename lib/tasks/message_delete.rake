namespace :message_delete do
  desc "Comment中のレコードが1000を超えたら古いものから削除"
  task :delete => :environment do
    if (Message.count > 1000)
      delete_num = Message.count - 1000
      delete_num.times do
        Message.first.destroy
      end
    end
  end
end
