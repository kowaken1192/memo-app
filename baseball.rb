require "csv"

puts "1(新規でメモを作成)2(既存のメモを編集する)"
memo_type = gets.chomp.to_s
puts "選択：" + memo_type
input_number = memo_type.chomp

if input_number == "1"
  puts "新規でメモを作成します。拡張子を除いたファイル名を入力してください。"
  file_name = gets.chomp

  puts "メモの内容を記入して下さい。Ctrl+Dで保存します。"
  input_memo = STDIN.read
  memo = input_memo.chomp

  CSV.open("#{file_name}.csv", "a") do |csv|
    csv << [memo]
  end

elsif input_number == "2"
  puts "既存のメモを編集します。拡張子を除いた既存ファイル名を入力してください。"
  file_name = gets.chomp

  puts "以下のメモがあります。"
  memo_list = []
  CSV.foreach("#{file_name}.csv") do |row|
    memo_list << row[0]
    puts "#{memo_list.length}. #{row[0]}"
  end

  memo = ""
  CSV.foreach("#{file_name}.csv") do |row|
    memo = row[0]
  end

  puts "メモの内容を記入して下さい。Ctrl+Dで保存します。"
  input_memo = STDIN.read
  memo = input_memo.chomp

  CSV.open("#{file_name}.csv", "a") do |csv|
    memo_list.pop
    memo_list << memo
    memo_list.each do |m|
      csv << [m]
    end
  end

  puts "メモを更新しました。"


else
  puts "1か2の数字を入力してください"
end
