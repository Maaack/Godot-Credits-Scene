# Godot Credits Scene
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/Maaack/Godot-Credits-Scene)
![GitHub Release Date](https://img.shields.io/github/release-date/Maaack/Godot-Credits-Scene)
[![Discord members](https://img.shields.io/discord/772191827570720798.svg?label=&logo=discord&logoColor=ffffff)](https://discord.gg/AyZrJh5AMp)  

This credits scene scrolls text that is read from an attribution file in a markdown (`.md`) format.

For Godot 4.7 (4.3+ compatible)

[Example on itch.io](https://maaack.itch.io/godot-game-template)  
_Example is of [Maaack's Game Template](https://github.com/Maaack/Godot-Game-Template), which includes additional features._

[Featured Games](#featured-games)  

### Videos

[![Quick Intro Video](https://img.youtube.com/vi/U9CB3vKINVw/hqdefault.jpg)](https://youtu.be/U9CB3vKINVw)  
[More Videos](/addons/maaacks_credits_scene/docs/Videos.md)

### Screenshots

![Credits Screen](/addons/maaacks_credits_scene/media/Screenshot-3-5.png)  
[More Screenshots](/addons/maaacks_credits_scene/docs/Screenshots.md)  

## Objective

For adding scrolling credits to your scenes that can auto-update from a project's `ATTRIBUTION.md`, `CONTRIBUTORS.md`, or similar attribution markdown file.

## Features

- Classic scrolling text.
- Interactable:
  - Supports mouse-wheel and touch-pad scrolling.
  - Supports clicking on external links.
- Generates content from reading an attribution file in markdown (`.md`) format.
- End Credits example scene.
- Assisted plugin installation.

### How it Works

- `Credits.tscn` reads from `ATTRIBUTION.md` to automatically generate the content for it's scrolling text label.  

## Installation

### Godot Asset Store & Library
This package is available as a plugin, meaning it can be added to an existing project. 

![Package Icon](/addons/maaacks_credits_scene/media/credits_scene-icon-black-transparent-256x256.png)  

When editing an existing project:

1.  Go to the `Asset Store` tab.
2.  Search for "Maaack's Credits Scene".
3.  Click on the result to open the plugin details.
4.  Click to Download.
5.  Check that contents are getting installed to `addons/` and there are no conflicts.
6.  Click to Install.
7.  Reload the project (you may see errors before you do this).
8.  Enable the plugin from the Project Settings > Plugins tab.  
    1.  If it's enabled for the first time, the setup wizard will start.  
    2.  Close the window behind it and complete the setup wizard.  
9.  Continue with the [Basic Setup](/addons/maaacks_credits_scene/docs/BasicSetup.md)


### GitHub


1.  Download the latest release version from [GitHub](https://github.com/Maaack/Godot-Credits-Scene/releases/latest).  
2.  Extract the contents of the archive.
3.  Move the `addons/maaacks_credits_scene` folder into your project's `addons/` folder.  
4.  Open/Reload the project.  
5.  Enable the plugin from the Project Settings > Plugins tab.  
    1.  If it's enabled for the first time, the setup wizard will start.  
    2.  Close the window behind it and complete the setup wizard.  
6.  Continue with the [Basic Setup](/addons/maaacks_credits_scene/docs/BasicSetup.md)

### Extras or Components

Users that want additional features can try [Maaack's Game Template](https://github.com/Maaack/Godot-Game-Template) or other options from the [plugin suite](/addons/maaacks_credits_scene/docs/PluginSuite.md).  

## Usage

[Basic Setup](/addons/maaacks_credits_scene/docs/BasicSetup.md) is done through the _Setup Wizard_ at `Project > Tools > Run Maaack's Credits Scene Setup...`.

As part of setup, example scenes are copied out of `/addons/` into a desired folder (project root by default). These can be edited to fit requirements.

### More Documentation

[Automatic Updating](/addons/maaacks_credits_scene/docs/AutomaticUpdating.md)  

---

## Featured Games

| HeartFix Express | Baking Godium | Rent Seek Kill |  
| :-------:| :-------: | :-------: |
| ![HeartFix Express](/addons/maaacks_credits_scene/media/thumbnail-game-heartfix-express.png) | ![Baking Godium](/addons/maaacks_credits_scene/media/thumbnail-game-baking-godium.png) | ![Rent-Seek-Kill](/addons/maaacks_credits_scene/media/thumbnail-game-rent-seek-kill.png) |
|  [Find on Steam](https://store.steampowered.com/app/3983290/HeartFix_Express_Demo/)  | [Play on itch.io](https://maaack.itch.io/baking-godium) | [Play on itch.io](https://xandruher.itch.io/rent-seek-kill)  |


[All Shared Games](/addons/maaacks_credits_scene/docs/GamesMade.md)  


## Community

Join the [Discord server](https://discord.gg/AyZrJh5AMp) and share your work with others. It's also a space for getting or giving feedback, and asking for help. 


## Links
[Attribution](/addons/maaacks_credits_scene/ATTRIBUTION.md)  
[License](/addons/maaacks_credits_scene/LICENSE.txt)  
[Godot Asset Store](https://store.godotengine.org/asset/maaack/maaacks-credits-scene/)  
[Godot Asset Library](https://godotengine.org/asset-library/asset/2932)  
