include Comparable

BOARD_MARK = ['　', '●', '○']
COUNT_Y = 8
COUNT_X = 8

@player = 1
@board = Array.new(COUNT_Y) { Array.new(COUNT_X, 0) }
@board[3][3] = 1
@board[4][4] = 1
@board[3][4] = 2
@board[4][3] = 2


# 置けるかチェックする
def is_put_board(y, x, add_y, add_x)
    count = 0
    if @board[y][x] == 0 then
        while true
            if (y + add_y).between?(0, COUNT_Y-1) && (x + add_x).between?(0, COUNT_X-1) then
                if @board[y + add_y][x + add_x] == 0 then
                     count = 0
                     break
                elsif @board[y + add_y][x + add_x] == @player then
                    break
                else
                    y += add_y
                    x += add_x
                    count+=1
                end
            else
                count = 0
                break
            end
        end
    end
    return count > 0, y, x
end

# コマをひっくり返す
def flip_board(y, x, add_y, add_x, max_y, max_x)
    while true
        @board[y + add_y][x + add_x] = @player
        if y + add_y == max_y && x + add_x == max_x then
            break
        end
        y += add_y
        x += add_x
    end
end

# コマを置く
def put_board(y, x)
    b_put = false
    if !y.between?("0", (COUNT_Y-1).to_s) || !x.between?("0", (COUNT_X-1).to_s) then
        return b_put
    end
    for i in -1..1 do
        for j in -1..1 do
            # コマが置けるかチェックする
            check, max_y, max_x = is_put_board(y.to_i, x.to_i, i, j)
            if check then
                flip_board(y.to_i, x.to_i, i, j, max_y, max_x)
                b_put = true
            end
        end
    end
    if b_put then
        @board[y.to_i][x.to_i] = @player
    end
    return b_put
end

# メイン処理
while true
    p "----------------"
    print 'player: ', @player, "\n"
    COUNT_Y.times do |y|
        p @board[y].map{|x| BOARD_MARK[x]}
    end

    print "y,x: "
    input_val = gets.chomp
    if input_val == "q" then
        break
    end
    ary_val = input_val.split(',')
    if  ary_val.length == 2 then
        # コマを置く
        if put_board(ary_val[0], ary_val[1]) then
            @player = (@player % 2) + 1
        end
    end
end
