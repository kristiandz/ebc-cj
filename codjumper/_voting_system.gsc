#include maps\mp\_utility;
#include common_scripts\utility;

initVote()
{
  maplist = codjumper\_cj_maplist::getMapList();
  level.votemenu = [];
  level.votemenu["items_per_page"] = 30; 														     //Number of page items
  level.votemenu["page_count"] = calculatePageCount(maplist.size, level.votemenu["items_per_page"]); //Number of pages
  level.votemenu["nominations"] = []; 																 //Array with nominated mapsv
}

initVoteClient()
{
  while(!isDefined(self.cj) || !isDefined(self.cj["vote"])) wait 0.05;
  self.cj["vote"]["selected"] = ""; //Selected mapname
  self.cj["vote"]["page"] = 1;  	//Actual Page
  self.cj["vote"]["search"] = "";   //Input from search field

  //Autoselect first map in pool
  items = self getPageItems(self.cj["vote"]["page"]);
  if(isDefined(items[0]))
    self.cj["vote"]["selected"] = items[0];
  
  self setClientdvars
  (
    "ui_cj_map_list_pagecount", self.cj["vote"]["page"] + "/" + level.votemenu["page_count"],
    "ui_cj_map_list_textfield", "Type to search",
    "ui_cj_map_list_select", self.cj["vote"]["selected"]
   );
  updateDvars();
}

getMapList(endmap_vote, player)
{
  maplist = codjumper\_cj_maplist::getMapList();
  if(isDefined(player) && player.cj["vote"]["search"] != "")
  {
    items = [];
    for(i = 0; i < maplist.size; i++)
	{
      if(issubstr(maplist[i], player.cj["vote"]["search"]))
        items[items.size] = maplist[i];
    }
    player.cj["vote"]["page"] = 1;
    maplist = items;
  }
  return maplist;
}

createVoteEntry(mapname, votes)
{
  tmp = [];
  tmp["name"] = mapname;
  tmp["votes"] = votes;
  return tmp;
}

selectMap(mapID)
{
  maplist = self getPageItems(self.cj["vote"]["page"]);
  if(isDefined(maplist[mapID]))
  {
    self.cj["vote"]["selected"] = maplist[mapID];
    println("SELECTED : " + maplist[mapID]);
    self setClientDvar("ui_cj_map_list_select", maplist[mapID]);
  }
}

updateDvars()
{
  items = self getPageItems(self.cj["vote"]["page"]);
  println("^2UPDATEDVARS: " + items.size);
  for(i = 0; i < level.votemenu["items_per_page"]; i++)
  {
    if(isDefined(items[i])) self setClientDvar("ui_cj_map_list_" + i, items[i]);
    else self setClientDvar("ui_cj_map_list_" + i, "");
  }
}

doSearch(char)
{
  if(char != "backspace")
  {
    self.cj["vote"]["search"] = self.cj["vote"]["search"] + char;
  }
  else
  {
    self.cj["vote"]["search"] = getSubStr(self.cj["vote"]["search"], 0, self.cj["vote"]["search"].size -1);
  }
  self setClientDvar("ui_cj_map_list_textfield", self.cj["vote"]["search"]);
  self updateDvars();
}

//Pagination
setNextPage()
{
  self.cj["vote"]["page"]++;
  if(self.cj["vote"]["page"] > level.votemenu["page_count"])
  {
    self.cj["vote"]["page"] = level.votemenu["page_count"];
    println("^1Mapvote: ^3reached max page count");
  }
  self setClientdvar("ui_cj_map_list_pagecount", self.cj["vote"]["page"] + "/" + level.votemenu["page_count"]);
  self updateDvars();
}

setPrevPage()
{
  self.cj["vote"]["page"]--;
  if(self.cj["vote"]["page"] <= 1)
  {
    self.cj["vote"]["page"] = 1;
    println("^1Mapvote: ^3reached min page count");
  }
  self setClientdvar("ui_cj_map_list_pagecount", self.cj["vote"]["page"] + "/" + level.votemenu["page_count"]);
  self updateDvars();
}

setPage(value)
{
  self.cj["vote"]["page"] = value;
  if(self.cj["vote"]["page"] > level.votemenu["page_count"])
  {
    self.cj["vote"]["page"] = level.votemenu["page_count"];
    println("^1Mapvote setPage: ^3reached max page count");
  }
  if(self.cj["vote"]["page"] <= 1){
    self.cj["vote"]["page"] = 1;
    println("^1Mapvote setPage: ^3reached min page count");
  }
  self setClientdvar("ui_cj_map_list_pagecount", self.cj["vote"]["page"] + "/" + level.votemenu["page_count"]);
}

calculatePageCount(itemCount, items_per_page)
{
  pages = int(ceil(itemCount / items_per_page));
  return pages;
}

getPageItems(page)
{
  items = [];
  maplist = getMapList(false, self);

  start = level.votemenu["items_per_page"] * (page - 1);
  for(i = start; i < start + level.votemenu["items_per_page"]; i++)
  {
    if(!isDefined(maplist[i])) maplist[i] = "";
    items[items.size] = maplist[i];
  }
  return items;
}