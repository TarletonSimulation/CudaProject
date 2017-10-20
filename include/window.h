#if	!defined( __tsx_window__ )
#	 define	  __tsx_window__

#include <tsx/prefix.h>
#include <tsx/display.h>

#include <tsx/bits/window.h>

namespace tsx{

	class	xwindow_attr{
		public:
			 xwindow_attr();
			 xwindow_attr(unsigned int, unsigned int, int, int);
			~xwindow_attr();
			
			bool	check_event(long);	// checks for a particular event in mask //
			bool	set_event(long);	// sets event mask //
			long	event_mask();		// gets event mask //

			void	x(int);
			int	x();
			int	x_min();
			void	x_min(int);
			int	x_max();
			void	x_max(int);

			void	y(int);
			int	y();
			int	y_min();
			void	y_min(int);
			int	y_max();
			void	y_max(int);

			void	width(unsigned int);
		unsigned int	width();
			void	max_width(unsigned int);
			void	min_width(unsigned int);
		unsigned int	max_width();
		unsigned int	min_width();
			
			void	height(unsigned int);
		unsigned int	height();
			void	max_height(unsigned int);
			void	min_height(unsigned int);
		unsigned int	min_height();
		unsigned int	max_height();

		unsigned int	pixel_area();		// returns width*height of pixels //
			
			void	back_pixel(long);	// sets background pixel for xwin_attr //
			long	back_pixel();		// gets background pixel //

			void	border_pixel(long);	// sets border pixel //
			long	border_pixel();		// gets ... //

			bool	showing();		// does not show // checks for mapping //
virtual			void	set_showing(bool);	// sets mapping value // true if mapped //

			bool	created();		// not a creator // checks for creation //
virtual			void	set_created(bool);	// set creation value // true if created //

virtual			bool	needs_resize();
virtual			void	set_to_resize(bool);
virtual			bool	needs_repos();
virtual			void	set_to_repos(bool);
		protected:
			// used for current values //
			unsigned int	xwidth, xheight;
			unsigned int	xwidth_m, xheight_m;	// min //
			unsigned int	xwidth_M, xheight_M;	// max //
			
			// used for current values //
			int	xpos, ypos;
			int	xpos_m, xpos_M;
			int	ypos_m, ypos_M;		// min and max //

			long	xevent_mask;		// widnow event mask // used with window creation //
			long	xattr_mask;		// window attribute mask // for window attributes //
			long	xgeom_mask;		// window geometry mask // for size hints //

			bool	is_mapped;		// mapped boolean //
			bool	is_created;		// created boolean //
			bool	resize_bool;
			bool	repos_bool;

			int	xclass;			// InputOutput, OutputOnly, CopyFromParent // ONLY ACCEPTED VALUES! //
			long	xsize_mask;		// used for size hints flags //
			long	xwm_mask;		// window manager mask //

			long	tsx_mask;		// for use in local library functions //
		
			// xlib structures //
		XSetWindowAttributes	xwin_attr;	// Xlib settable window attributes //
			
			// use XFree to free data structures //
		XSizeHints	*	xwin_size_h;	// xwindow size hints //
		XWMHints	*	xwin_wm_h;	// window manager hints //
		XClassHint	*	xwin_class_h;	// window class hint //
	};


	class	xwindow_base
	:	public	xwindow_attr{
		public:
			 xwindow_base();
			~xwindow_base();

			bool		show();
			bool		hide();
		protected:
			void		set_showing(bool)	override;
			void		set_created(bool)	override;
			bool		needs_resize()		override;
			bool		needs_repos()		override;

			void		set_to_repos(bool)	override;
			void		set_to_resize(bool)	override;

			xDisplay *	xdisplay;
			Drawable	xwindow;
			Pixmap		xpixmap;
	};
}

#endif
