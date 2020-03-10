# ZED::Spritesheet

A toolset to ease your life when dealing with sprite atlases.

## Features

 * creates a Ruby source file containing the sprite sheet declaration
   * readily compatible with DragonRuby's sprite API
   * pure core Ruby. No external dependency. Not even Ruby's stdlib. No Regexp.
 * a CLI tool that has sex in its name, legitimately
   * suitable for use with other game engines or other languages (Lua, Rust, you name it I code it.)
   
## Usage

	gem i zed-spritesheet
	
  ### With the DragonRuby game engine
  
  [TODO: Explain copy]
  
  #### Why not support import from game?
  
  Since DragonRuby now has a method to read XML and JSON resources, it is feasible to let the Spritesheet class perform
  the import directly from a running DragonRuby Game Toolkit game. It is in the works.
  
  However this tool is meant to be usable in various environements, possibly not even Ruby.
  So for now the prefered way is to use the command line tool.
   
  ### Standalone
  
  ### Auto-update using Guard
  
  When you're in a high-frequency update cycle, you can opt to let the import/export be handled through [Guard](https://guardgem.org/)
  
## Outputs to more languages?

Sure! Just ask away. I'll add whatever language output you need.

You can:

 * create a GitHub issue
 * send me an e-mail (arnaud@meuret.net)
 * chat on the DragonRuby Discord: https://discord.gg/UHrwbVS

## Inputs from more sprite atlases formats?

Yep! Do you need JSON and can't be bothered to do it yourself? 

## In the works

 - [ ] Native DragonRuby in-game import
 - [ ] Output templating to support universal and easy custom outputs

## The ZED toolset for game developers

This Sprite sheet utility set is part of an ongoing project offering turn-key solutions to
various basic tasks many game developers face when implementing their ideas.

The ZED Toolset currently include:

 - Spritesheet: a language/engine agnostic sprite atlas import/export toolkit (this gem)
 - Bezier: a Casteljau/Bezier curves manager and in-game editor for DragonRuby (𝛽)
 - GUI: an immediate mode GUI set of objects for DragonRuby (𝛼)
 - Utils: miscellaneous classes to make life easier (Timer, TimeBoolean, TimeVal, Color)  (𝛽)
 - Camera: 2D rich camera class for DragonRuby  (pan, zoom, rotate, POI, parallax, motion blur) (𝛼)
 - Map: an isometric map class featuring 3D multilayer display sorting (𝛽)
 - Path: a multi-agent, 3D path finding class implementing the A* algorithm (prepared)
 - Sight: a 2D visibility resolver (planned)
 - Maze: an elegant and useful maze generating class that will ease away your stress of the day (𝛼)
 - Domain: a boredom resistant Dungeon-like map generator featuring cyclic paths and opinionable randomness (planned)
 - Particles: a fast, multi-emitter, faux 3D, particle systems manager (𝛼)

Learn more about the ZED toolset here: https://meuret.itch.io/zed
