package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxG;
import flixel.FlxState;

class Main extends Sprite 
{
	var gameWidth:Int = 640; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 480; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	/*
	40 Tiles in Width 
	34 Tiles in Height or 29/59 to see the tiles for experiment
							60 tiles
	16 by 16 px tiles

	// normal gamewidth is 320
	// normal gameheight is 240
	*/


	var initialState:Class<FlxState> = MenuState; // The FlxState the game starts with.
	var zoom:Float = 1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = true; // Whether to start the game in fullscreen on desktop targets

	// You can pretty much ignore everything from here on - your code should go in your states.
	
	public static function main():Void
	{	
		Lib.current.addChild(new Main());
	}

	public function new() 
	{
		super();

		if (stage != null) 
		{
			init();
		}
		else 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void 
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}
		
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
		FlxG.sound.playMusic(AssetPaths.DUCKSONG__wav, 1, true);
	}
}