#if	!defined( __tsx_display__ )
#	 define	  __tsx_display__

#include <tsx/prefix.h>
#include <tsx/event.h>

namespace tsx{
	
	class	xDisplay
	:	public	xEvent{
		public:
			 xDisplay(std::string ="DISPLAY");
			~xDisplay();

			bool		connect(std::string ="DISPLAY");
			bool		connected();	// if connected or not //
			int		connection();	// return connection number //

			std::string	server_name();	// server name // usually DISPLAY //
			std::string	screen_name();	// get screen name // usually :0 //

			bool		disconnect();	// disconnect connection to display //

			unsigned int	width();	// width of screen //
			unsigned int	height();	// height of screen //

			unsigned int	depth();	// display depth //
			int		screen_count();	//

			Screen	*	screen();	// screen pointer //
			int		scrn_n();	// screen number //

			Drawable	root();		// xserver root window //
			Display	*	display();	// return display pointer //

			Visual	*	visual();	// default visual //
			GC		gc();		// default gc //
		protected:
			std::string	xserver_name;	// name of connected display //

			bool		is_connected;	// redundancy boolean //
			int		xscrn;		// screen number //
	};
}

#endif
