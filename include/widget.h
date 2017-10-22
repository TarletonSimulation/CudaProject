#if	!defined( __tsx_widget__ )
#	 define	  __tsx_widget__

#include <tsx/prefix.h>
#include <tsx/display.h>

#include <tsx/bits/widget.h>

namespace tsx{

	class	xwidget_attr{
		public:
			 xwidget_attr();
			 xwidget_attr(unsigned int, unsigned int, int, int);
			~xwidget_attr();

			bool	check_event(unsigned long);	// checks for a particular event in mask //
			bool	set_event(unsigned long);	// sets event mask //
		unsigned long	event_mask();			// gets event mask //

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
			
virtual			void	background_pixel(unsigned long);	// sets background pixel for xwin_attr //
		unsigned long	background_pixel();			// gets background pixel //

virtual			void	border_pixel(unsigned long);	// sets border pixel //
		unsigned long	border_pixel();			// gets ... //

		unsigned int	border_width();
			void	border_width(unsigned int);

		unsigned int	depth();
			bool	depth(unsigned int);

			bool	showing();		// does not show // checks for mapping //
			bool	created();		// not a creator // checks for creation //

virtual			bool	needs_resize();
virtual			bool	needs_repos();
virtual			bool	needs_reattr();

			bool	operator	== ( const xwidget_attr & );
			bool	operator	!= ( const xwidget_attr & );

	const	xwidget_attr &	operator	 = ( const xwidget_attr & );
			
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

			long	xattr_udm;		// update mask //
			long	xevent_udm;		//
			long	xsize_udm;		//

			bool	is_mapped;		// mapped boolean //
			bool	is_created;		// created boolean //

			int	xclass;			// InputOutput, OutputOnly, CopyFromParent // ONLY ACCEPTED VALUES! //
			long	xsize_mask;		// used for size hints flags //
			long	xwm_mask;		// window manager mask //

		unsigned int	xborder_width;
			int	xdepth;
			bool	update_xattr;		// update needed for window attributes //

			long	tsx_mask;		// for use in local library functions //
		
			// xlib classures //
		XSetWindowAttributes	xwin_attr;	// Xlib settable window attributes //
			XID	xgroup;
			
			// use XFree to free data classures //
		XSizeHints	*	xwin_size_h;	// xwindow size hints //
		XWMHints	*	xwin_wm_h;	// window manager hints //
		XClassHint	*	xwin_class_h;	// window class hint //
	};


	class	xWidget
	:	public	xwidget_attr{
		public:
			 xWidget();
			~xWidget();
	typedef	int	(*Action)(void *, void *);
			
			bool		show();		// shows self and all children //
			bool		hide();		// hides self and all children //
			bool		destroy();	// destroys all children //

			Drawable	drawable();	// xlib window value //
			Pixmap		pixmap();	// xlib pixmap //

			void		background_pixel(unsigned long)	override;
			void		border_pixel(unsigned long)	override;

			int		wid();
			XID		xid();
			int		cid();

		// virtual functions //
			xWidget	&	spawn(unsigned int, unsigned int, int, int);
		static	xWidget	&	create(xWidget &, unsigned int, unsigned int, int, int);
		// end virtual functions //
		virtual	bool		update_widget();
		protected:

			bool		create_root(xDisplay *);
			bool		widget_is_app;

			xWidget	*	w_parent;	// widget parent //
			xDisplay *	xdisplay;

			Drawable	xwindow;
			Pixmap		xpixmap;
			XVisualInfo *	xvisual_info;
			Visual	*	xvisual;
			GC		xgc;

			Colormap	xcolor_map;
	};
}

#endif
