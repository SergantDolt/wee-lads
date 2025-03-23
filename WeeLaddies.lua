SMODS.Atlas({
    key = "weelads",
    path = "w_jokers.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = 'wee_boosters',
    path = "boosters_wee.png",
    px = 71,
    py = 95
})

SMODS.Rarity({ --Miniature Rarity (All main cards should have this as their rarity.)--
    key = "small",
    loc_txt = {},
    badge_colour = HEX("5450C8"),
    pools = {["Joker"] = true},
})

SMODS.ObjectType({
    key = 'miniatures',
    default = 'j_wlads_morningladdies',
    cards = {
        ["j_wlads_morningladdies"] = true,
        ["j_wlads_royalassassin"] = true,
        ["j_wlads_pabloletter"] = true,
        ["j_wlads_pushpin"] = true,
        ["j_wlads_needle"] = true,
        ["j_wlads_pencil"] = true,
        ["j_wlads_germanengineering"] = true
    }
})

SMODS.Booster({
    key = 'wee_regular_pack_1',
    atlas = 'wee_boosters',
    discovered = true,
    pos = {x = 0, y = 0},
    config = {extra = 2, choose = 1},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.choose, card.ability.extra}}
    end,
    display_size = {49, 66},
    cost = 8,
    weight = 2,
    kind = "Jokers",
    create_card = function (self, card)
        return create_card('miniatures', G.pack_cards, nil, nil, true, nil)
    end
})

SMODS.Joker({ --Top of the Morning!--
    key = 'morningladdies',
    config = {extra = {money = 1, money_gain = 2}},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.money, card.ability.extra.money_gain}}
    end,
    rarity = "wlads_small",
    discovered = true,
    atlas = 'weelads',
    pos = {x = 0, y = 0},
    display_size = {w = 49.7, h = 66.5},
    calculate = function (self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 then
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_gain
            return {
                message = 'Lads!',
                money = card.ability.extra.money,
                money_gain = card.ability.extra.money_gain,
                color = G.C.GOLD
            }
        end
    end,
    calc_dollar_bonus = function (self, card)
        local bonus = card.ability.extra.money
        if bonus > 0 then return bonus end
    end
})

SMODS.Joker({ --Pablo's Letter--
    key = 'pabloletter',
    config = {extra = {Xmult = 1, Xmult_gain = 0.05}},
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.Xmult, card.ability.extra.Xmult_gain}}
    end,
    rarity = "wlads_small",
    discovered = true,
    atlas = 'weelads',
    pos = {x = 1, y = 0},
    display_size = {w = 49.7, h = 66.5},
    calculate = function (self, card, context)
        if context.joker_main and card.ability.extra.Xmult > 1 then
            return {
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}},
                Xmult_mod = card.ability.extra.Xmult
            }
        end

        if context.destroy_card and context.cardarea == G.play then
            local destroyed_id = context.destroying_card:get_id()
            local increase_multiplier = 0
            local destroy_check = destroyed_id == 14 or destroyed_id == 5 or destroyed_id == 4 or destroyed_id == 3 or destroyed_id == 2
            if destroy_check then
                increase_multiplier = increase_multiplier + 1
            end

            local multipler_to_add = card.ability.extra.Xmult_gain * increase_multiplier
            card.ability.extra.Xmult = card.ability.extra.Xmult + multipler_to_add
            if destroy_check then
                juice_card(card)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{
                    type = 'variable',
                    key = 'a_mult',
                    vars = {card.ability.extra.Xmult_gain}
                }})
                return {
                    remove = true,
                    destroying_card = context.destroying_card
                }
            end
        end
    end
})

SMODS.Joker({ --Pushpin--
    key = 'pushpin',
    config = {extra = {mult = 1, poker_hand = 'High Card'}},
    loc_vars = function (self, info_queue, card)
        return { vars = {
            card.ability.extra.mult,
            localize(card.ability.extra.poker_hand, 'poker_hands')
        }}
    end,
    rarity = "wlads_small",
    discovered = true,
    atlas = 'weelads',
    pos = {x = 2, y = 0},
    display_size = {w = 49.7, h = 66.5},
    calculate = function (self, card, context)
        if context.before and context.cardarea == G.jokers then
            if context.scoring_name == card.ability.extra.poker_hand then
                local calculated_additon = G.GAME.hands[card.ability.extra.poker_hand].level / 5
                card.ability.extra.mult = card.ability.extra.mult + calculated_additon
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = {calculated_additon}
                    },
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main then
            return {
                message = localize {
                    type = 'variable',
                    key = 'a_xmult',
                    vars = {card.ability.extra.mult}
                },
                Xmult_mod = card.ability.extra.mult
            }
        end

        if context.end_of_round and context.cardarea == G.jokers then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible and k ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands+1] = k
                end
            end
            local old_hand = card.ability.extra.poker_hand
            card.ability.extra.poker_hand = nil
            while not card.ability.extra.poker_hand do
                card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed('thumbtack'))
                if card.ability.extra.poker_hand == old_hand then card.ability.extra.poker_hand = nil end
            end
            return {
                message = localize('k_reset')
            }
        end
    end
})

SMODS.Joker({ --Needle--
    key = 'needle',
    config = {extra = {mult = 0}},
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    rarity = 'wlads_small',
    discovered = true,
    atlas = 'weelads',
    pos = {x = 3, y = 0},
    display_size = {w = 49.7, h = 66.5},
    calculate = function (self, card, context)
        if context.before then
            local mult_cal = math.floor(G.GAME.hands[context.scoring_name].mult / 2)
            if mult_cal == 0 then
                mult_cal = mult_cal + 1
            end
            card.ability.extra.mult = card.ability.extra.mult + mult_cal
            return {
                message = localize {
                    type = 'variable',
                    key = 'a_mult',
                    vars = {mult_cal}
                }
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end

})

SMODS.Joker({ --Pencil--
    key = 'pencil',
    rarity = 'wlads_small',
    discovered = true,
    atlas = 'weelads',
    pos = {x = 4, y = 0},
    display_size = {w = 49.7, h = 66.5},
    config = {extra = {chips = 0}},
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function (self, card, context)
        if context.before then
            local chips_cal = math.floor(G.GAME.hands[context.scoring_name].chips / 4)
            if chips_cal == 0 then
                chips_cal = chips_cal + 10
            end
            card.ability.extra.chips = card.ability.extra.chips + chips_cal
            return {
                message = localize{
                    type = 'variable',
                    key = 'a_chips',
                    vars = {chips_cal}
                }
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})

SMODS.Joker({ --Royal Assassin--
    key = 'royalassassin',
    config = {extra = {required_discards = 4, current_discards = 0, discard_size = 0, discard_gain = 1}},
    rarity = 'wlads_small',
    discovered = true,
    atlas = 'weelads',
    pos = {x = 5, y = 0},
    display_size = {w = 49.7, h = 66.5},
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.required_discards,
                card.ability.extra.current_discards,
                card.ability.extra.required_discards,
                card.ability.extra.discard_size
            }
        }
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            ease_discard(G.GAME.round_resets.discards + card.ability.extra.discard_size)
        end

        if context.discard then
            local d_card = context.other_card
            local is_king_or_queen = d_card:get_id() == 12 or d_card:get_id() == 13
            if is_king_or_queen then

                if card.ability.extra.current_discards >= card.ability.extra.required_discards then
                    card.ability.extra.current_discards = 0
                    card.ability.extra.discard_size = card.ability.extra.discard_size + card.ability.extra.discard_gain

                    G.E_MANAGER:add_event(Event {
                        trigger = 'immediate',
                        func = function ()
                            SMODS.calculate_effect({
                                message = localize {
                                    type = 'variable',
                                    key = 'a_discards',
                                    vars = {card.ability.extra.discard_gain}
                                }
                            }, card)
                            return true
                        end
                    })
                end

                if card.ability.extra.current_discards < card.ability.extra.required_discards then
                    card.ability.extra.current_discards = card.ability.extra.current_discards + 1

                    local increased_numbers = 0
                    for i = 1, card.ability.extra.current_discards, 1 do
                        increased_numbers = increased_numbers + 1
                    end

                    G.E_MANAGER:add_event(Event {
                        trigger = 'immediate',
                        func = function ()
                            SMODS.calculate_effect({
                                message = localize {
                                    type = 'variable',
                                    key = 'remaining_discards',
                                    vars = {
                                        increased_numbers,
                                        card.ability.extra.required_discards
                                    }
                                }
                            }, card)
                            return true
                        end
                    })
                end
                return {
                    remove = true
                }
            end
        end
    end
})

SMODS.Joker({ --German Engineering--
    key = 'germanengineering',
    rarity = "wlads_small",
    discovered = true,
    atlas = 'weelads',
    pos = {x = 0, y = 1},
    display_size = {w = 49.7, h = 66.5}
})

SMODS.PokerHand({ --Special Poker Hand for German Engineering--
    key = 'German Engineered',
    chips = 255,
    mult = 255,
    l_chips = 64,
    l_mult = 16,
    above_hand = 'High Card',
    visible = false,
    example = {
        {'S_A', true},
        {'S_K', false},
        {'S_Q', false},
        {'S_J', false},
        {'S_T', false}
    },
    loc_txt = {
        ['en-us'] = {
            name = 'German Engineered',
            description = {
                'Only available if you have the',
                'German Engineering Joker. Replaces High Card.',
                'Functionally identical to High Card.'
            }
        }
    },
    evaluate = function (parts, hand)
        local joker_found = false
        for i = 1, #G.jokers.cards do
            local joker_card = G.jokers.cards[i]
            joker_found = joker_card.config.center_key == 'j_wlads_germanengineering'
        end
        if next(parts._highest) then
            if joker_found then
                return parts._highest
            end
            return nil
        end
    end
})