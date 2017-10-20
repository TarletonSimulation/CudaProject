#include <tsx/display.h>

namespace tsx{

static	bool	block_connection = false;

	xDisplay::xDisplay(std::string Server){
		xdisplay = nullptr;
		xscrn	= -1;

		if( !block_connection ){
			if( Server is "" )
				xserver_name = "DISPLAY";
			else	xserver_name = Server;
			xdisplay = XOpenDisplay( getenv( xserver_name.c_str() ) );

			if(xdisplay is null){
				xserver_name = "FailedToConnect";
			}else	is_connected = true;

			xscrn	= DefaultScreen(xdisplay);
			memset(&xevent,0,sizeof(xevent));
		}

	}


	xDisplay::~xDisplay(){
		if( connected() ){
			close();
			xdisplay = nullptr;
		}
	}


	std::string
	xDisplay::screen_name(){
		return	std::string( DisplayString(xdisplay) );
	}

	std::string
	xDisplay::server_name(){
		return	xserver_name;
	}

	bool
	xDisplay::connected(){
		if( xdisplay is null )
			return	false;
	else	if( is_connected is true )
			return	is_connected;
		else	return	false;
	}

	int
	xDisplay::connection(){
		if( connected() )
			return	ConnectionNumber(xdisplay);
		else	return	-1;
	}

	bool
	xDisplay::connect(std::string Server){
		if( connected() )
			return	false;
		else{
			if( Server is "" )
				xserver_name = "DISPLAY";
			else	xserver_name = Server;

			xdisplay = XOpenDisplay( xserver_name.c_str() );
			if( xdisplay isnot null ){
				is_connected = true;
			}else	is_connected = false;
		}
	return	is_connected;
	}

	bool
	xDisplay::close(){
		if( xdisplay isnot null && connected() ){
			XCloseDisplay(xdisplay);
		
			xdisplay = nullptr;
			xscrn = -1;
			is_connected = false;
		}
	return	!connected();
	}

	int
	xDisplay::depth(){
		if( !connected() )
			return	0;
		else	return	DefaultDepth(xdisplay,xscrn);
	}

	unsigned int
	xDisplay::width(){
		if( !connected() )
			return	0;
		else	return	DisplayWidth(xdisplay,xscrn);
	}

	unsigned int
	xDisplay::height(){
		if( !connected() )
			return	0;
		else	return	DisplayHeight(xdisplay,xscrn);
	}

	Screen *
	xDisplay::screen(){
		if( !connected() )
			return	nullptr;
		else	return	ScreenOfDisplay(xdisplay,xscrn);
	}

	int
	xDisplay::scrn_n(){
		if( !connected() )
			return	-1;
		else	return	xscrn;
	}

	int
	xDisplay::next_event(){
		if( !connected() )
			return	0;
		else	return	XNextEvent(xdisplay, &xevent);
	}

	int
	xDisplay::event_type(){
		return	xevent.type;
	}

	Drawable
	xDisplay::root(){
		if( !connected() )
			return	0;
		else	return	RootWindow(xdisplay,xscrn);
	}

}
