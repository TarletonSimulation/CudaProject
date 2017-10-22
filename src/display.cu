#include <tsx/display.h>

namespace tsx{

static	bool	block_connection = false;

	xDisplay::xDisplay(std::string Server){
		Event::xdisplay = nullptr;
		xscrn	= -1;

		if( !block_connection ){
			if( Server is "" )
				xserver_name = "DISPLAY";
			else	xserver_name = Server;
			Event::xdisplay = XOpenDisplay( getenv( xserver_name.c_str() ) );

			if(Event::xdisplay is null){
				xserver_name = "FailedToConnect";
			}else	is_connected = true;

			xscrn	= DefaultScreen(Event::xdisplay);
			memset(&xevent,0,sizeof(xevent));
		}

	}


	xDisplay::~xDisplay(){
		if( connected() ){
			disconnect();
			Event::xdisplay = nullptr;
		}
	}
	
	Display *
	xDisplay::display(){
		if( Event::xdisplay is null )
			return	null;
		else	return	Event::xdisplay;
	}

	Visual	*
	xDisplay::visual(){
		if( connected() )
			return	DefaultVisual(display(), xscrn);
		else	return	nullptr;
	}

	unsigned int
	xDisplay::depth(){
		if( !connected() )
			return	0;
		else	return	DefaultDepth(display(),xscrn);
	}

	std::string
	xDisplay::screen_name(){
		return	std::string( DisplayString(Event::xdisplay) );
	}

	std::string
	xDisplay::server_name(){
		return	xserver_name;
	}

	bool
	xDisplay::connected(){
		if( Event::xdisplay is null )
			return	false;
	else	if( is_connected is true )
			return	is_connected;
		else	return	false;
	}

	int
	xDisplay::connection(){
		if( connected() )
			return	ConnectionNumber(Event::xdisplay);
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

			Event::xdisplay = XOpenDisplay( xserver_name.c_str() );
			if( Event::xdisplay isnot null ){
				is_connected = true;
			}else	is_connected = false;
		}
	return	is_connected;
	}

	bool
	xDisplay::disconnect(){
		if( Event::xdisplay isnot null && connected() ){
			XCloseDisplay(Event::xdisplay);
		
			Event::xdisplay = nullptr;
			xscrn = -1;
			is_connected = false;
		}
	return	!connected();
	}

	unsigned int
	xDisplay::width(){
		if( !connected() )
			return	0;
		else	return	DisplayWidth(Event::xdisplay,xscrn);
	}

	unsigned int
	xDisplay::height(){
		if( !connected() )
			return	0;
		else	return	DisplayHeight(Event::xdisplay,xscrn);
	}

	Screen *
	xDisplay::screen(){
		if( !connected() )
			return	nullptr;
		else	return	ScreenOfDisplay(Event::xdisplay,xscrn);
	}

	int
	xDisplay::scrn_n(){
		if( !connected() )
			return	-1;
		else	return	xscrn;
	}

	Drawable
	xDisplay::root(){
		if( !connected() )
			return	0;
		else	return	RootWindow(Event::xdisplay,xscrn);
	}

}
