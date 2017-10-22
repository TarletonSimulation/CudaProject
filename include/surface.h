#if	!defined( __tsx__glx_surface__ )
#	 define	  __tsx__glx_surface__

#include <tsx/prefix.h>
#include <tsx/display.h>
#include <tsx/widget.h>

namespace tsx{

	class	glxSurface
	:	public	Widget{
		public:
			 glxSurface();
			~glxSurface();

		protected:
			XVisualInfo *	xvisual_info;
			GC		xgc;
			Colormap	xcolor_map;

			GLXFBConfig *	glx_fbconfig;
			GLXContext	glx_context;
			GLXWindow	glx_window;
	};

}

#endif	// end __tsx__glx_surface__
