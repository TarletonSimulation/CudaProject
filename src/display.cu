#include <tsx/display.h>

namespace	tsx{

	xDisplay::xDisplay( const std::string & X )
	:	xgeom(0.0f,0.0f), xname(X){
		xroot	= 0;
		xserv	= nullptr;
		xscrn	= nullptr;
	}

	xDisplay::~xDisplay(){
		disconnect();
	}


	bool
	xDisplay::connect(){
		if( (xname is "") or (xname is "NoHost") )
			xname = "DISPLAY";
		
		xserv	= XOpenDisplay( getenv(xname.c_str()) );
		if( xserv is null ){
			xname = "NoHost";
			std::cerr << "Failed to connect to XServer!" << std::endl;
			std::cerr << "\tExiting Program..." << std::endl;
			exit(1);
		}else	xconn = true;
		
		xscrn	= DefaultScreenOfDisplay(xserv);
		xnumb	= DefaultScreen(xserv);
		xroot	= RootWindow( xserv, xnumb );

		set( xgeom, (float)WidthOfScreen(xscrn), (float)HeightOfScreen(xscrn) );

	return	true;
	}

	bool
	xDisplay::connected(){
		return	(xconn is true);
	}

	bool
	xDisplay::disconnect(){
		if( connected() is true ){
			XCloseDisplay(xserv);
			xserv = nullptr;
			xscrn = nullptr;
			xconn = false;
		}else	return	false;
	}

	std::string
	xDisplay::screen_name(){
		if( connected() is false )
			return	"NoScreen";
		else	return	getenv( xname.c_str() );
	}

	std::string
	xDisplay::server_name(){
		if( connected() is false ){
			xname = "NoHost";
			return	"NoHost";
		}else	return	xname;
	}

	const Rectangle &
	xDisplay::geometry(){
		if( connected() is false )
			set(xgeom, 0.0f, 0.0f);
	return	xgeom;
	}

	int
	xDisplay::screen_number(){
		if( connected() is false )
			return	-1;
		else	return	xnumb;
	}

}
