#include <tsx/display.h>

namespace tsx{

static	bool	block_connection = false;

	xDisplay::xDisplay(std::string Server){
		xEvent::xdisplay = nullptr;
		xscrn	= -1;

		if( !block_connection ){
			if( Server is "" )
				xserver_name = "DISPLAY";
			else	xserver_name = Server;
			xEvent::xdisplay = XOpenDisplay( getenv( xserver_name.c_str() ) );

			if(xEvent::xdisplay is null){
				xserver_name = "FailedToConnect";
			}else	is_connected = true;

			xscrn	= DefaultScreen(xEvent::xdisplay);
			memset(&xevent,0,sizeof(xevent));
		}

	}


	xDisplay::~xDisplay(){
		if( connected() ){
			disconnect();
			xEvent::xdisplay = nullptr;
		}
	}
	
	Display *
	xDisplay::display(){
		if( xEvent::xdisplay is null )
			return	null;
		else	return	xEvent::xdisplay;
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
		return	std::string( DisplayString(xEvent::xdisplay) );
	}

	std::string
	xDisplay::server_name(){
		return	xserver_name;
	}

	bool
	xDisplay::connected(){
		if( xEvent::xdisplay is null )
			return	false;
	else	if( is_connected is true )
			return	is_connected;
		else	return	false;
	}

	int
	xDisplay::connection(){
		if( connected() )
			return	ConnectionNumber(xEvent::xdisplay);
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

			xEvent::xdisplay = XOpenDisplay( xserver_name.c_str() );
			if( xEvent::xdisplay isnot null ){
				is_connected = true;
			}else	is_connected = false;
		}
	return	is_connected;
	}

	bool
	xDisplay::disconnect(){
		if( xEvent::xdisplay isnot null && connected() ){
			XCloseDisplay(xEvent::xdisplay);
		
			xEvent::xdisplay = nullptr;
			xscrn = -1;
			is_connected = false;
		}
	return	!connected();
	}

	unsigned int
	xDisplay::width(){
		if( !connected() )
			return	0;
		else	return	DisplayWidth(xEvent::xdisplay,xscrn);
	}

	unsigned int
	xDisplay::height(){
		if( !connected() )
			return	0;
		else	return	DisplayHeight(xEvent::xdisplay,xscrn);
	}

	Screen *
	xDisplay::screen(){
		if( !connected() )
			return	nullptr;
		else	return	ScreenOfDisplay(xEvent::xdisplay,xscrn);
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
		else	return	RootWindow(xEvent::xdisplay,xscrn);
	}

}
