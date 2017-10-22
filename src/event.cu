#include <tsx/event.h>

namespace tsx{

	Event::Event(){
		xdisplay = nullptr;
		memset(&xevent, 0, sizeof(xevent));
	}
	
	Event::~Event(){
		xdisplay = nullptr;
	}


	int
	Event::type()
	{return	xevent.type;}

	int
	Event::next(){
		if( xdisplay is null )
			return	0;
		return	XNextEvent(xdisplay,&xevent);
	}

	int
	Event::pending(){
		if( xdisplay is null )
			return	0;
		else	return	XPending(xdisplay);
	}



}
