#include <tsx/event.h>

namespace tsx{

	xEvent::xEvent(){
		xdisplay = nullptr;
		memset(&xevent, 0, sizeof(xevent));
	}
	
	xEvent::~xEvent(){
		xdisplay = nullptr;
	}


	int
	xEvent::type()
	{return	xevent.type;}

	int
	xEvent::next(){
		if( xdisplay is null )
			return	0;
		return	XNextEvent(xdisplay,&xevent);
	}

	int
	xEvent::pending(){
		if( xdisplay is null )
			return	0;
		else	return	XPending(xdisplay);
	}



}
