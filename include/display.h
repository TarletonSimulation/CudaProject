#if	!defined( __tsx__display__ )
#	 define	  __tsx__display__

#include <tsx/geometry.h>

extern "C"{
#include <X11/Xlib.h>
#include <X11/X.h>
#include <X11/Xos.h>
#include <X11/Xresource.h>
#include <X11/Xatom.h>
#include <X11/keysym.h>
#include <X11/keysymdef.h>
}

namespace	tsx{

	class	xDisplay{
	public:
				 xDisplay(const std::string & ="");
				~xDisplay();

			bool	connect(const std::string &);
			bool	connect();
			bool	connected();
			int	connection();
			bool	disconnect();

		std::string	server_name();
		std::string	screen_name();
			int	screen_number();
			int	screen_count();

	const	Rectangle &	geometry();
		Window		root();
		Display	*	display_pointer();

	protected:
		Rectangle	xgeom;	// display size
		std::string	xname;	// server name
		Display	*	xserv;	// display pointer
		Window		xroot;	// root window to connection
		Screen	*	xscrn;	// current screen pointer
		int		xnumb;	// screen number
		bool		xconn;	// true when connected to display
	private:
	};



	class	xInfo
	:	public	Rectangle,
		public	Point{
	public:
				 xInfo();
				~xInfo();
			
			bool	set_display( xDisplay & );
	protected:
		Window		xwindow;
		xDisplay *	xserver;
		Visual	*	xvisual;
	private:
	};



}

#endif
