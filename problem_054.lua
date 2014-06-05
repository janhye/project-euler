local helper = require "lib.helper"
local lines = io.lines
local gmatch = string.gmatch
local byte = string.byte
local sort = table.sort


local function rank (cards)
  local ROYAL_FLUSH = 10
  local STRAIGHT_FLUSH = 9
  local FOUR_OF_A_KIND = 8
  local FULL_HOUSE = 7
  local FLUSH = 6
  local STRAIGHT = 5
  local THREE_OF_A_KIND = 4
  local TWO_PAIRS = 3
  local ONE_PAIR = 2
  local HIGH_CARD = 1

  local CARD_T,CARD_J,CARD_Q,CARD_K,CARD_A = byte("TJQKA", 1, -1)

  local function to_card_number (card)
    local b = byte(card, 1)
    if b == CARD_T then
      return 10
    elseif b == CARD_J then
      return 11
    elseif b == CARD_Q then
      return 12
    elseif b == CARD_K then
      return 13
    elseif b == CARD_A then
      return 14
    else
      -- '1' byte is 49
      return b - 48
    end
  end

  local highest_cards = {}

  sort(cards, function (card1, card2)
    return to_card_number(card1) < to_card_number(card2)
  end)

  -- check flush
  local is_flush = true
  for i = 2, #cards do
    if byte(cards[1], -1) ~= byte(cards[i], -1) then
      is_flush = false
    end
  end

  -- check straight
  local is_straight = true
  local cards_count = #cards
  -- for special straight: (A,2,3,4,5) {2,3,4,5,14} 
  if to_card_number(cards[5]) == 14 and to_card_number(cards[1]) == 2 then
    cards_count = cards_count - 1
  end
  local pre_cn = to_card_number(cards[1])
  for i = 2, cards_count do
    cn = to_card_number(cards[i])
    if pre_cn + 1 ~= cn then
      is_straight = false
      break
    end
    pre_cn = cn
  end

  if is_flush and is_straight then
    if to_card_number(cards[1]) == 10 then
      return ROYAL_FLUSH, highest_cards
    else
      highest_cards[1] = to_card_number(cards[5])
      return STRAIGHT_FLUSH, highest_cards
    end
  end

  if is_flush then
    for i = #cards, 1, -1 do
      highest_cards[#highest_cards+1] = to_card_number(cards[i])
    end
    return FLUSH, highest_cards
  end

  if is_straight then
    highest_cards[1] = to_card_number(cards[5])
    return STRAIGHT, highest_cards
  end

  -- check four of a kind
  local is_four_of_a_kind = false
  if byte(cards[1], 1) == byte(cards[2], 1) and
     byte(cards[1], 1) == byte(cards[3], 1) and
     byte(cards[1], 1) == byte(cards[4], 1) then
    is_four_of_a_kind = true
    highest_cards[1] = to_card_number(cards[1])
  elseif byte(cards[2], 1) == byte(cards[3], 1) and
         byte(cards[2], 1) == byte(cards[4], 1) and
         byte(cards[2], 1) == byte(cards[5], 1) then
    is_four_of_a_kind = true
    highest_cards[1] = to_card_number(cards[2])
  end

  if is_three_of_a_kind then
    return FOUR_OF_A_KIND, highest_cards
  end

  -- check full house
  local is_full_house = false
  if byte(cards[1], 1) == byte(cards[2], 1) and
     byte(cards[3], 1) == byte(cards[4], 1) and
     byte(cards[3], 1) == byte(cards[5], 1) then
    is_full_house = true
    highest_cards[1] = to_card_number(cards[3])
  elseif byte(cards[1], 1) == byte(cards[2], 1) and
         byte(cards[1], 1) == byte(cards[3], 1) and
         byte(cards[4], 1) == byte(cards[5], 1) then
    is_full_house = true
    highest_cards[1] = to_card_number(cards[1])
  end

  if is_full_house then
    return FULL_HOUSE, highest_cards
  end

  -- check three of a kind
  local is_three_of_a_kind = false
  if byte(cards[1], 1) == byte(cards[2], 1) and
     byte(cards[1], 1) == byte(cards[3], 1) then
    is_three_of_a_kind = true
    highest_cards[1] = to_card_number(cards[1])
  elseif
     byte(cards[2], 1) == byte(cards[3], 1) and
     byte(cards[2], 1) == byte(cards[4], 1) then
    is_three_of_a_kind = true
    highest_cards[1] = to_card_number(cards[2])
  elseif
     byte(cards[3], 1) == byte(cards[4], 1) and
     byte(cards[3], 1) == byte(cards[5], 1) then
    is_three_of_a_kind = true
    highest_cards[1] = to_card_number(cards[3])
  end

  if is_three_of_a_kind then
    return THREE_OF_A_KIND, highest_cards
  end

  -- check two pairs
  local is_two_pairs = false
  if byte(cards[1], 1) == byte(cards[2], 1) and
     byte(cards[3], 1) == byte(cards[4], 1) then
    is_two_pairs = true
    highest_cards[1] = to_card_number(cards[3])
    highest_cards[2] = to_card_number(cards[1])
    highest_cards[3] = to_card_number(cards[5])
  elseif
     byte(cards[1], 1) == byte(cards[2], 1) and
     byte(cards[4], 1) == byte(cards[5], 1) then
    is_two_pairs = true
    highest_cards[1] = to_card_number(cards[4])
    highest_cards[2] = to_card_number(cards[1])
    highest_cards[3] = to_card_number(cards[3])
  elseif
     byte(cards[2], 1) == byte(cards[3], 1) and
     byte(cards[4], 1) == byte(cards[5], 1) then
    is_two_pairs = true
    highest_cards[1] = to_card_number(cards[4])
    highest_cards[2] = to_card_number(cards[2])
    highest_cards[3] = to_card_number(cards[1])
  end

  if is_two_pairs then
    return TWO_PAIRS, highest_cards
  end

  -- check one pair
  local is_one_pair = false
  if byte(cards[1], 1) == byte(cards[2], 1) then
    is_one_pair = true
    highest_cards[1] = to_card_number(cards[1])
    highest_cards[2] = to_card_number(cards[5])
    highest_cards[3] = to_card_number(cards[4])
    highest_cards[4] = to_card_number(cards[3])
  elseif byte(cards[2], 1) == byte(cards[3], 1) then
    is_one_pair = true
    highest_cards[1] = to_card_number(cards[2])
    highest_cards[2] = to_card_number(cards[5])
    highest_cards[3] = to_card_number(cards[4])
    highest_cards[4] = to_card_number(cards[1])
  elseif byte(cards[3], 1) == byte(cards[4], 1) then
    is_one_pair = true
    highest_cards[1] = to_card_number(cards[3])
    highest_cards[2] = to_card_number(cards[5])
    highest_cards[3] = to_card_number(cards[2])
    highest_cards[4] = to_card_number(cards[1])
  elseif byte(cards[4], 1) == byte(cards[5], 1) then
    is_one_pair = true
    highest_cards[1] = to_card_number(cards[4])
    highest_cards[2] = to_card_number(cards[3])
    highest_cards[3] = to_card_number(cards[2])
    highest_cards[4] = to_card_number(cards[1])
  end

  if is_one_pair then
    return ONE_PAIR, highest_cards
  end

  for i = #cards, 1, -1 do
    highest_cards[#highest_cards+1] = to_card_number(cards[i])
  end
  return HIGH_CARD, highest_cards
end

local function answer ()
  local player1_wins = 0
  for line in lines("problem_054_poker.txt") do
    local player1_cards = {}
    local player2_cards = {}
    for card in gmatch(line, "[^%s]+") do
      if #player1_cards < 5 then
        player1_cards[#player1_cards+1] = card
      else
        player2_cards[#player2_cards+1] = card
      end
    end

    local r1, hcs1 = rank(player1_cards)
    local r2, hcs2 = rank(player2_cards)
    
    if r1 > r2 then
      player1_wins = player1_wins + 1
    elseif r1 == r2 then
      for i = 1, #hcs1 do
        if hcs1[i] > hcs2[i] then
          player1_wins = player1_wins + 1
          break
        elseif hcs1[i] < hcs2[i] then
          break
        end
      end
    end
  end

  return player1_wins
end

helper.elapsed_time(function ()
  print(answer())
end)
