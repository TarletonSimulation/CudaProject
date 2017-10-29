src/
	
	+ Rectangle Class
	*	restrict width and height final values to gte 0
	*	i.e.:	sub(rect a, rect b);
	*		scale*(rect a, value lt 0);

	+ Point Class

	+ global values in tsx::*

	+ Handlers, Actions and Signals
	*	+ update actions to incorperate handler names to be blocked or called specifically

	+ DataBus
	*	+ stream, pipe and socket classes needed
	*	+ non-daemon dbus, run locally

	+ Windowing/Widgets
	*	+ basic widgets
	*	+ surfaces, fonts

scripts/
	
	+ Compilation script
	*	+ stat file for last modification time, to speed up compilation by not compiling sources that have already been built +

