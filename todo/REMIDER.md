src/
	
	+ Rectangle Class
	*	+ restrict width and height final values to gte 0
	*	+ i.e.:	sub(rect a, rect b);
	*		scale*(rect a, value lt 0);

	+ Point Class

	+ global values in tsx::*

	+ Handlers, Actions and Signals
	*	+ update actions to incorperate handler names to be blocked or called specifically

	+ DataBus/Main Application
	*	+ stream, pipe and socket classes needed
	*	+ non-daemon dbus, run locally
	*	+ create localized environment to be able to change ported-program behavior
	*	+ i.e: port opengl/cuda program into GLAppViewer (*doesnt exist yet*)
	*	+	-> port other programs into localized environment

	+ Windowing/Widgets
	*	+ basic widgets
	*	+ surfaces, fonts

scripts/
	
	+ Compilation script
	*	+ stat file for last modification time, to speed up compilation by not compiling sources that have already been built +

