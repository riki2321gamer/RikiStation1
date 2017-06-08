/datum/reagent/secret/triplecoffee
    name = "Triple Coffee"
    id = "tcoffee"
    description = "A ghetto chemical that can stop a heart."
    reagent_state = LIQUID
    color = "#7F10C0"
    metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/secret/triplecoffee/on_mob_life(mob/living/M)
    if(prob(25))
        var/picked_option = rand(1,3)
        switch(picked_option)
            if(1)
                M.Stun(3, 0)
                M.Weaken(3, 0)
                . = 1
            if(2)
                M.losebreath += 10
                M.adjustOxyLoss(rand(5,25), 0)
                . = 1
            if(3)
                if(ishuman(M))
                    var/mob/living/carbon/human/H = M
                    if(H.stat == CONSCIOUS)
                        H.visible_message("<span class='userdanger'>[H] clutches at [H.p_their()] chest as if [H.p_their()] heart stopped!</span>")
                        H.losebreath += 10
                        H.adjustOxyLoss(rand(5,25), 0)
                        . = 1
    return ..() || .