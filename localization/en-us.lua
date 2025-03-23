return {
    descriptions = {
        Joker = {
            j_wlads_morningladdies = {
                name = 'Top of the Morning!',
                text = {
                    "Earn {C:money}$#1#{} at the end of round,",
                    "increase payout by {C:money}$#2#{}",
                    "for each {C:attention}first hand{}."
                }
            },
            j_wlads_royalassassin = {
                name = 'Royal Assassin',
                text = {
                    "If a {C:attention}King{} or {C:attention}Queen{} is discarded,",
                    "destroy them. Every {C:attention}#1#{} times",
                    "a card is destroyed, add a {C:mult}discard{}.",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#3#)",
                    "{C:inactive}(Currently {C:mult}+#4#{C:inactive} discards)"
                }
            },
            j_wlads_pabloletter = {
                name = "Letter to Pablo",
                text = {
                    "If played hand contains a",
                    "{C:attention}Ace{}, {C:attention}5{}, {C:attention}4{}, {C:attention}3{}, or {C:attention}2{}, destroy",
                    "them and gain {C:white,X:mult}X#2#{}",
                    "for each card destroyed.",
                    "{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive} Mult)"
                }
            },
            j_wlads_pushpin = {
                name = "Pushpin",
                text = {
                    "If a {C:attention}#2#{} is played,",
                    "add one fifth of its level",
                    "to this card's {C:white,X:mult}Xmult{}.",
                    "Hand changes every round.",
                    "{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive} mult.)"
                }
            },
            j_wlads_needle = {
                name = "Needle",
                text = {
                    "When a {C:attention}hand{} is played,",
                    "add half the hand's",
                    "base {C:mult}mult{} to this card.",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} mult.)"
                }
            },
            j_wlads_pencil = {
                name = "Pencil",
                text = {
                    "When a {C:attention}hand{} is played,",
                    "add a quarter of the hand's",
                    "base {C:chips}chips{} to this card.",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} chips.)"
                }
            },
            j_wlads_germanengineering = {
                name = "German Engineering",
                text = {
                    "Replaces {C:attention}High Card{} with its {C:attention}unique hand{}."
                }
            }
        },
        Other = {
            p_wlads_wee_regular_pack_1 = {
                name = "Wee Booster Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} Miniature{} Jokers."
                }
            }
        }
    },
    misc = {
        labels = {
            k_wlads_small = "Miniature"
        },
        dictionary = {
            k_wlads_small = "Miniature"
        },
        v_dictionary = {
            a_discards = "+#1# discards",
            remaining_discards = "#1#/#2# discards"
        }
    }
}