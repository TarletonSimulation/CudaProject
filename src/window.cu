#include <tsx/window.h>

namespace tsx{

	xwindow_attr::xwindow_attr(){
		
		xwidth_m	= XWIN_MIN_WIDTH;
		xheight_m	= XWIN_MIN_HEIGHT;

		xwidth_M	= 5000;	// some arbitrary large number for a screen //
		xheight_M	= 5000; // these will need to be set by the programmer // 

		xwidth	= xwidth_m;
		xheight	= xheight_m;

		xpos_m	= -5000;	// needs to be set by the programmer //
		ypos_m	= -5000;

		xpos_M	= 5000;
		ypos_M	= 5000;

		xpos	= 0;
		ypos	= 0;
		
		xevent_mask	= XEVT_DEFAULT_WINDOW_MASK;
		xattr_mask	= XWIN_ATTR_DEFAULT;
		xsize_mask	= USPosition | USSize;

		is_mapped	= false;
		is_created	= false;

		memset(&xwin_attr, 0, sizeof(xwin_attr));

		xwin_size_h	= XAllocSizeHints();
		if( xwin_size_h is null )
			std::cerr << "Failed to allocate XSizeHints" << std::endl;

		xwin_class_h	= XAllocClassHint();
		if( xwin_class_h is null )
			std::cerr << "Failed to allocate XClassHint" << std::endl;

		xwin_wm_h	= XAllocWMHints();
		if( xwin_wm_h is null )
			std::cerr << "Failed to allocate XWMHints" << std::endl;
	}

	xwindow_attr::~xwindow_attr(){
		if( xwin_size_h isnot null ){
			XFree(xwin_size_h);
			xwin_size_h = null;
		}
		if( xwin_class_h isnot null ){
			XFree(xwin_class_h);
			xwin_class_h = null;
		}
		if( xwin_wm_h isnot null ){
			XFree(xwin_wm_h);
			xwin_wm_h = null;
		}
	}

	// begin virtual methods //

	void
	xwindow_attr::set_showing(bool state){
		is_mapped = state;
	}

	void
	xwindow_attr::set_created(bool state){
		is_created = state;
	}

	void
	xwindow_attr::set_to_resize(bool state){
		resize_bool = state;
	}

	void
	xwindow_attr::set_to_repos(bool state){
		repos_bool = state;
	}

	// end virtual methods //


	void
	xwindow_attr::width(unsigned int W){
		if( W lt XWIN_MIN_WIDTH || W lt min_width() )
			xwidth = min_width();
		else	xwidth = W;
	}

	unsigned int
	xwindow_attr::min_width()
	{return	xwidth_m;}

	void
	xwindow_attr::min_width(unsigned int w){
		if( w lt XWIN_MIN_WIDTH )
			xwidth_m = XWIN_MIN_WIDTH;
	else	if( w lt xwidth_m )
			return;
		else	xwidth_m = w;
	}

	void
	xwindow_attr::max_width(unsigned int w){
		if( w lt XWIN_MIN_WIDTH )
			return;
	else	if( w lte xwidth_M )
			return;
		else	xwidth_M = w;
	}

	unsigned int
	xwindow_attr::max_width()
	{return	xwidth_M;}

	unsigned int
	xwindow_attr::width(){
		return	xwidth;
	}

	void
	xwindow_attr::height(unsigned int H){
		if( H lt XWIN_MIN_HEIGHT || H lt min_height() )
			xheight = min_height();
		else	xheight = H;
	}

	unsigned int
	xwindow_attr::height(){
		return	xheight;
	}

	unsigned int
	xwindow_attr::min_height()
	{return	xheight_m;}

	unsigned int
	xwindow_attr::max_height()
	{return	xheight_M;}


	int
	xwindow_attr::x()
	{return	xpos;}

	void
	xwindow_attr::x(int xp){
		if( xp lt x_min() )
			return;		// don't reset location if outside of position bounds //
	else	if( xp gt x_max() )
			return;
		else	xpos = xp;
	}

	int
	xwindow_attr::x_max()
	{return	xpos_M;}

	void
	xwindow_attr::x_max(int xp){
		if( xp lt x_min() )
			return;
		else	xpos_M = xp;
	}

	void
	xwindow_attr::x_min(int xp){
		if( xp gte x_max() )
			return;
		else	xpos_m = xp;
	}

	int
	xwindow_attr::x_min()
	{return	xpos_m;}

	int
	xwindow_attr::y()
	{return	ypos;}

	void
	xwindow_attr::y(int yp){
		if( yp lt y_min() || yp gt y_max() )
			return;
		else	ypos = yp;
	}

	int
	xwindow_attr::y_min()
	{return	ypos_m;}

	void
	xwindow_attr::y_min(int yp){
		if( yp gte y_max() )
			return;
		else	ypos_m = yp;
	}

	int
	xwindow_attr::y_max()
	{return	ypos_M;}

	void
	xwindow_attr::y_max(int yp){
		if( yp lte y_min() )
			return;
		else	ypos_M = yp;
	}

}
