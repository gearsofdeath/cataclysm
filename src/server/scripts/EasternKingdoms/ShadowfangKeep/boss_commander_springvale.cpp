/*
 * Copyright (C) 2005-2011 MaNGOS <http://www.getmangos.com/>
 *
 * Copyright (C) 2008-2011 Trinity <http://www.trinitycore.org/>
 *
 * Copyright (C) 2006-2011 ScriptDev2 <http://www.scriptdev2.com/>
 *
 * Copyright (C) 2010-2011 Project Trinity <http://www.projecttrinity.org/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include "ScriptPCH.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "shadowfang_keep.h"

enum Spells
{
   SPELL_DESECRATION                      = 93687,
   SPELL_MALEFIX_STRIKE                   = 93685,

   // Normal Mode
   SPELL_SHIELD_OF_THE_PERFIDIOUS         = 93693,
   SPELL_UNHOLY_POWER                     = 93686,

   // Heroic Mode
   SPELL_FORSAKEN_ABILITY_ARMOR           = 91436,
   SPELL_FORSAKEN_ABILITY_HEALING         = 91442,
   SPELL_FORSAKEN_ABILITY_HEALTH          = 91444,
   SPELL_SEPARATION_ANXIETY               = 96272,
   SPELL_WORD_OF_SHAME                    = 93852,
   SPELL_UNHOLY_POWER_H                   = 93735,
   SPELL_SHIELD_OF_THE_PERFIDIOUS_H       = 93736,
   SPELL_UNHOLY_EMPOWERMENT               = 93844,
};

enum Events
{
   EVENT_DESECRATION                      = 1,
   EVENT_MALEFIX_STRIKE,
   EVENT_SUMMONS,
   EVENT_POWER,
};

enum Yells
{
   SAY_AGGRO                   = 0,
   SAY_SUMMON_GUARDS           = 1,
   SAY_KILL_1                  = 2,
   SAY_KILL_2                  = 3,
   SAY_DEATH                   = 4,
};

class boss_commander_springvale : public CreatureScript
{
    struct boss_commander_springvaleAI : public BossAI
    {
        boss_commander_springvaleAI(Creature * creature) : BossAI(creature, BOSS_COMMANDER_SPRINGVALE)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        std::list<uint64> SummonList;

        bool Achievement;

        void Reset()
        {
            Achievement = true;
            RemoveSummons();
            _Reset();

            if (instance)
            {
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_WORD_OF_SHAME);
                instance->SetData(DATA_COMMANDER_SPRINGVALE_EVENT, NOT_STARTED);
            }
        }

        void KilledUnit(Unit* /*victim*/)
        {
            switch(urand(0,1))
            {
                case 0:
                    Talk(SAY_KILL_1);
                    break;
                case 1:
                    Talk(SAY_KILL_2);
                    break;
            }
        }

        void SpellHit(Unit* hitter, const SpellInfo* spell)
        {
            if (!hitter || !spell)
                return;

            if (spell->Id != SPELL_UNHOLY_EMPOWERMENT)
                return;

            Achievement = false;
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);

            if (instance)
            {
                instance->SetData(DATA_COMMANDER_SPRINGVALE_EVENT, IN_PROGRESS);
            }
            events.ScheduleEvent(EVENT_DESECRATION, 10000);
            events.ScheduleEvent(EVENT_MALEFIX_STRIKE, 15000);
            events.ScheduleEvent(EVENT_POWER, 1000);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SUMMONS, 40000);
        }

        void JustSummoned(Creature* pSummon)
        {
            if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM,0))
                pSummon->AI()->AttackStart(pTarget);
            SummonList.push_back(pSummon->GetGUID());
        }

        void RemoveSummons()
        {
            if (SummonList.empty())
                return;

            for (std::list<uint64>::const_iterator itr = SummonList.begin(); itr != SummonList.end(); ++itr)
            {
                if (Creature* pTemp = Unit::GetCreature(*me, *itr))
                    if (pTemp)
                        pTemp->DisappearAndDie();
            }
            SummonList.clear();
        }

        void JustDied(Unit * /*killer*/)
        {
            Talk(SAY_DEATH);
            RemoveSummons();

            if (instance)
            {
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_WORD_OF_SHAME);
                if (Achievement && IsHeroic())
                    //instance->DoCompleteAchievement(ACHIEVEMENT_TO_THE_GROUND);
                    instance->SetData(DATA_COMMANDER_SPRINGVALE_EVENT, DONE);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if(!UpdateVictim())
                return;

            events.Update(diff);

            if(me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if(uint32 eventId = events.ExecuteEvent())
            {
                switch(eventId)
                {
               case EVENT_DESECRATION:
                    DoCast(SPELL_DESECRATION);
                    events.ScheduleEvent(EVENT_DESECRATION, urand(14000, 20000));
                    break;
               case EVENT_MALEFIX_STRIKE:
                    DoCast(SPELL_MALEFIX_STRIKE);
                    events.ScheduleEvent(EVENT_MALEFIX_STRIKE, urand(12000, 18000));
                    break;
               case EVENT_SUMMONS:
                if (IsHeroic())
                    Talk(SAY_SUMMON_GUARDS);
                    Position pos;
                    me->GetPosition(&pos);
                    me->SummonCreature(NPC_TORMENTED_OFFICER, pos, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    me->SummonCreature(NPC_WAILING_GUARDSMAN, pos, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    events.ScheduleEvent(EVENT_SUMMONS, 40000);
                    break;
               case EVENT_POWER:
                if (Aura* aura = me->GetAura(DUNGEON_MODE(SPELL_UNHOLY_POWER,SPELL_UNHOLY_POWER_H)))
                    if (aura->GetStackAmount() == 3)
                    {
                        switch (urand(0,1))
                        {
                            case 0:
                                DoCast(DUNGEON_MODE(SPELL_SHIELD_OF_THE_PERFIDIOUS, SPELL_SHIELD_OF_THE_PERFIDIOUS_H));
                                break;
                            case 1:
                                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                    DoCast(target, SPELL_WORD_OF_SHAME, true);
                                break;
                        }
                        me->RemoveAura(aura);
                    }
                    events.ScheduleEvent(EVENT_POWER, 1000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
public:
    boss_commander_springvale() : CreatureScript("boss_commander_springvale") {}

    CreatureAI * GetAI(Creature * creature) const
    {
        return new boss_commander_springvaleAI(creature);
    }
};

void AddSC_boss_commander_springvale()
{
    new boss_commander_springvale();
}