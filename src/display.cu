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


	void
	xDisplay::connect(){
		// for the moment disallow multiple connections to the XServer //
		if( connected() is true )	return;

		if( (xname is "") )
			xname = "DISPLAY";
		
		xserv	= XOpenDisplay( getenv(xname.c_str()) );
		if( xserv is null ){
			std::cerr << "Failed to connect to XServer!" << std::endl;
			std::cerr << "\tExiting Program..." << std::endl;
			exit(1);
		}else	xconn = true;
		
		xscrn	= DefaultScreenOfDisplay(xserv);
		xnumb	= DefaultScreen(xserv);
		xroot	= RootWindow( xserv, xnumb );

		set( xgeom, (float)WidthOfScreen(xscrn), (float)HeightOfScreen(xscrn) );
	}

	void
	xDisplay::connect(const std::string & Server){
		if( Server is "" )
			xname = "DISPLAY";
		else	xname = Server;
	}

	bool
	xDisplay::connected()
	const{
		return	(xconn is true);
	}

	void
	xDisplay::disconnect(){
		if( connected() is true ){
			XCloseDisplay(xserv);
			xserv = nullptr;
			xscrn = nullptr;
			xconn = false;
		}
	}

	std::string
	xDisplay::screen_name()
	const{
		if( connected() is false )
			return	"NoScreen";
		else	return	getenv( xname.c_str() );
	}

	std::string
	xDisplay::server_name()
	const{
		if( connected() is false ){
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
	xDisplay::screen_number()
	const{
		if( connected() is false )
			return	-1;
		else	return	xnumb;
	}

	Display *
	xDisplay::display_pointer()
	const{
		if( connected() is true )
			return	xserv;
		else	return	null;
	}

	Screen	*
	xDisplay::screen_pointer()
	const{
		if( connected() is true )
			return	xscrn;
		else	return	null;
	}

	Window
	xDisplay::root()
	const{
		if( connected() is true )
			return	xroot;
		else	return	0;
	}


	int
	xDisplay::connection()
	const{
		if( connected() is true )
			return	ConnectionNumber(xserv);
		else	return	-1;
	}


	int
	xDisplay::screen_count()
	const{
		if( connected() is true )
			return	ScreenCount(xserv);
		else	return	0;
	}

}
