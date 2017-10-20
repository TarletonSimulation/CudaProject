#if	!defined( __tsx_display__ )
#	 define	  __tsx_display__

#include <tsx/prefix.h>

extern "C"{
#include <X11/X.h>
#include <X11/Xlib.h>
#include <X11/Xos.h>
#include <X11/Xutil.h>
#include <X11/Xresource.h>
#include <X11/keysym.h>
#include <X11/keysymdef.h>
}

namespace tsx{
	
	class	xDisplay{
		public:
			 xDisplay(std::string ="DISPLAY");
			~xDisplay();

			bool		connect(std::string ="DISPLAY");
			bool		connected();	// if connected or not //
			int		connection();	// return connection number //

			std::string	server_name();	// server name // usually DISPLAY //
			std::string	screen_name();	// get screen name // usually :0 //

			bool		close();	// close connection to display //

			unsigned int	width();	// width of screen //
			unsigned int	height();	// height of screen //

			int		depth();	// display depth //

			Screen	*	screen();	// screen pointer //
			int		scrn_n();	// screen number //

			Drawable	root();		// xserver root window //
			int		next_event();	// next event for ease of use //
			int		event_type();	// for ease of use //
			Drawable	event_window();	// window id that had the event //

		protected:
			std::string	xserver_name;	//

			Display	*	xdisplay;	// display pointer //
			bool		is_connected;	// redundancy boolean //
			int		xscrn;		// screen number //
			XEvent		xevent;		// 
	};
}

#endif
