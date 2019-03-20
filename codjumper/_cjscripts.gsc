#include maps\mp\_utility;
#include common_scripts\utility;

toggleRpgSwitch()
{
  if(self.cj["rpgsustain"])
    self toggleAmmoSustain();

  if(self.cj["rpgswitch"]){
    self.cj["rpgswitch"] = 0;
    self iprintlnbold("^1Rpg^7-switch ^1disabled!^3");
  }
  else{
    self.cj["rpgswitch"] = 1;
    self iprintlnbold("^1Rpg^7-switch ^1enabled!^3");
    self thread rpgSwitch();
  }
}

toggleAmmoSustain()
{
  if(self.cj["rpgswitch"])
    self toggleRpgSwitch();

  rpginhands = false;
  if(self.cj["rpgsustain"])
  {
      self.cj["rpgsustain"] = 0;
      if(self GetCurrentWeapon() == "rpg_sustain_mp")
        rpginhands = true;
      self takeWeapon("rpg_sustain_mp");
      self giveWeapon("rpg_mp");
      self SetActionSlot(4, "weapon", "rpg_mp");
      if(rpginhands)
        self switchToWeapon("rpg_mp");
      self iprintlnbold("^1Rpg^7-sustain disabled!^1");
  }
  else
  {
    if(self.cj["cheats"] == 1)
	{
      self.cj["rpgsustain"] = 1;
      if(self GetCurrentWeapon() == "rpg_mp")
        rpginhands = true;
      self takeWeapon("rpg_mp");
      self giveWeapon("rpg_sustain_mp");
      self SetActionSlot(4, "weapon", "rpg_sustain_mp");
      if(rpginhands)
        self switchToWeapon("rpg_sustain_mp");
      self iprintlnbold("^1Rpg^7-sustain enabled!^1");
    }
  }
}

rpgSwitch()
{
    self endon("disconnect");
    while (self.cj["rpgswitch"]) 
	{
        wait 0.05;
        if (self GetCurrentWeapon() == "rpg_mp" && self AttackButtonPressed())
		{
            wait 0.75;
            self switchToWeapon("deserteagle_mp");
            self switchToWeapon("deserteaglegold_mp");
            wait 0.8;
            self takeWeapon("rpg_mp");
            self giveWeapon("rpg_mp");
        }
    }
}
