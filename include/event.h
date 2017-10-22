#if	!defined( __tsx_event__ )
#	 define	  __tsx_event__

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
	
	class	Event{
		public:
			 Event();
			~Event();
			
			int	type();
			int	next();
			int	id();

			int	pending();
			int	queued();

		protected:
			Display	*	xdisplay;
			XEvent		xevent;
	};
	
}

#endif
