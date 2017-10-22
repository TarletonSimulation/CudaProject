#include <tsx/widget.h>

namespace tsx{

	xwidget_attr::xwidget_attr(){
		
		xwidth_m	= XWIN_MIN_WIDTH;
		xheight_m	= XWIN_MIN_HEIGHT;

		xwidth_M	= 5000;	// some arbitrary large number for a screen //
		xheight_M	= 5000; // these will need to be set by the programmer // 

		xwidth		= xwidth_m;
		xheight		= xheight_m;

		xpos_m		= -5000;	// needs to be set by the programmer //
		ypos_m		= -5000;

		xpos_M		= 5000;
		ypos_M		= 5000;

		xpos		= 0;
		ypos		= 0;
		tsx_mask	= 0;
		xgroup		= 0;
		xdepth		= 24;
		xborder_width	= 4;
		
		xevent_mask	= XEVT_DEFAULT_WINDOW_MASK;
		xattr_mask	= XWIN_ATTR_DEFAULT;
		xsize_mask	= USPosition | USSize;

		xevent_udm	= 0;
		xattr_udm	= 0;
		xsize_udm	= 0;

		xclass		= InputOutput;

		is_mapped	= false;
		is_created	= false;
		update_xattr	= false;

		memset(&xwin_attr, 0, sizeof(xwin_attr));

		xwin_attr.event_mask		= XEVT_BUTTON_PRESS_MASK | XEVT_KEY_PRESS_MASK | XEVT_WINDOW_MASK;
		xwin_attr.border_pixel		= 0x000000;	// default values that can be changed by the programmer or user //
		xwin_attr.background_pixel	= 0x000000;
		xwin_attr.override_redirect	= false;

		xwin_size_h	= XAllocSizeHints();
		if( xwin_size_h is null ){
			std::cerr << "Failed to allocate XSizeHints" << std::endl;
		}else{
			xwin_size_h->min_width	= xwidth_m;
			xwin_size_h->max_width	= xwidth_M;

			xwin_size_h->min_height	= xheight_m;
			xwin_size_h->max_height	= xheight_M;

			xwin_size_h->x		= xpos;
			xwin_size_h->y		= ypos;

			xwin_size_h->width	= xwidth;
			xwin_size_h->height	= xheight;
		}

		xwin_class_h	= XAllocClassHint();
		if( xwin_class_h is null )
			std::cerr << "Failed to allocate XClassHint" << std::endl;

		xwin_wm_h	= XAllocWMHints();
		if( xwin_wm_h is null )
			std::cerr << "Failed to allocate XWMHints" << std::endl;

	}

	xwidget_attr::~xwidget_attr(){
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

	bool
	xwidget_attr::needs_resize(){
		if( xwin_size_h is null )
			return	false;
		else{
			if( xwin_size_h->width isnot xwidth || xwin_size_h->height isnot xheight )
				return	true;
			else	return	false;
		}
	}

	bool
	xwidget_attr::needs_repos(){
		if( xwin_size_h is null )
			return	false;
		else{
			if( xwin_size_h->x isnot xpos || xwin_size_h->y isnot ypos )
				return	true;
			else	return	false;
		}
	}
	
	bool
	xwidget_attr::needs_reattr(){
		if( update_xattr is false )
			return	false;
	else	if( created() and showing() ){
			return	true;
		}else	return	false;
	}
	// end virtual methods //
	
	bool
	xwidget_attr::set_event(unsigned long m){
		return	true;
	}

	unsigned long
	xwidget_attr::event_mask(){
		return	xwin_attr.event_mask;
	}

	void
	xwidget_attr::width(unsigned int W){
		if( W lt XWIN_MIN_WIDTH || W lt min_width() )
			xwidth = min_width();
		else	xwidth = W;
	}

	unsigned int
	xwidget_attr::min_width()
	{return	xwidth_m;}

	void
	xwidget_attr::min_width(unsigned int w){
		if( w lt XWIN_MIN_WIDTH )
			xwidth_m = XWIN_MIN_WIDTH;
	else	if( w gte max_width() )
			return;
		else	xwidth_m = w;

		if( xwin_size_h isnot null )
			xwin_size_h->min_width = xwidth_m;
	}

	void
	xwidget_attr::max_width(unsigned int w){
		if( w lt XWIN_MIN_WIDTH )
			return;
	else	if( w lte xwidth_M )
			return;
		else	xwidth_M = w;
		
		if( xwin_size_h isnot null )
			xwin_size_h->max_width = xwidth_M;
	}

	unsigned int
	xwidget_attr::max_width()
	{return	xwidth_M;}

	unsigned int
	xwidget_attr::width(){
		return	xwidth;
	}

	void
	xwidget_attr::height(unsigned int H){
		if( H lt XWIN_MIN_HEIGHT || H lt min_height() )
			xheight = min_height();
		else	xheight = H;
	}

	unsigned int
	xwidget_attr::height(){
		return	xheight;
	}

	unsigned int
	xwidget_attr::min_height()
	{return	xheight_m;}

	unsigned int
	xwidget_attr::max_height()
	{return	xheight_M;}

	void
	xwidget_attr::min_height(unsigned int h){
		if( h lt XWIN_MIN_HEIGHT || h gte max_height() )
			return;
		else{
			xheight_m = h;

			if( xwin_size_h isnot null )
				xwin_size_h->min_height = xheight_m;
		}
	}

	void
	xwidget_attr::max_height(unsigned int h){
		if( h lte min_height() )
			return;

		xheight_M = h;
		if( xwin_size_h isnot null )
			xwin_size_h->max_height = xheight_M;
	}


	int
	xwidget_attr::x()
	{return	xpos;}

	void
	xwidget_attr::x(int xp){
		if( xp lt x_min() )
			return;		// don't reset location if outside of position bounds //
	else	if( xp gt x_max() )
			return;
		else	xpos = xp;
	}

	int
	xwidget_attr::x_max()
	{return	xpos_M;}

	void
	xwidget_attr::x_max(int xp){
		if( xp lt x_min() )
			return;
		else	xpos_M = xp;
	}

	void
	xwidget_attr::x_min(int xp){
		if( xp gte x_max() )
			return;
		else	xpos_m = xp;
	}

	int
	xwidget_attr::x_min()
	{return	xpos_m;}

	int
	xwidget_attr::y()
	{return	ypos;}

	void
	xwidget_attr::y(int yp){
		if( yp lt y_min() || yp gt y_max() )
			return;
		else	ypos = yp;
	}

	int
	xwidget_attr::y_min()
	{return	ypos_m;}

	void
	xwidget_attr::y_min(int yp){
		if( yp gte y_max() )
			return;
		else	ypos_m = yp;
	}

	int
	xwidget_attr::y_max()
	{return	ypos_M;}

	void
	xwidget_attr::y_max(int yp){
		if( yp lte y_min() )
			return;
		else	ypos_M = yp;
	}

	bool
	xwidget_attr::created(){
		return	is_created;
	}

	bool
	xwidget_attr::showing(){
		return	is_mapped;
	}

	unsigned int
	xwidget_attr::border_width(){
		return	xborder_width;
	}

	void
	xwidget_attr::border_width(unsigned int x){
		if( x lt 1 )
			xborder_width = 1;
		else	xborder_width = x;
	}

	unsigned int
	xwidget_attr::depth(){
		return	xdepth;
	}

	bool
	xwidget_attr::depth(unsigned int x){
		// create a depth test //
		if( x lt 1 )
			return	false;
		if( x%8 isnot 0 )
			return	false;
		else	xdepth = x;
	return	true;
	}

	void
	xwidget_attr::border_pixel(unsigned long c){
		if( c gt 0xffffff )
			xwin_attr.border_pixel = 0xffffff;
		else	xwin_attr.border_pixel = c;

		if( created() is true ){
			update_xattr = true;
//			xattr_udm |= XWIN_ATTR_BACKGROUND_PIXEL;
		}
	}

	unsigned long
	xwidget_attr::border_pixel()
	{return	xwin_attr.border_pixel;}

	void
	xwidget_attr::background_pixel(unsigned long c){
		if( c gt 0xffffff )
			xwin_attr.background_pixel = 0xffffff;
		else	xwin_attr.background_pixel = c;

		if( created() is true ){
			update_xattr = true;
//			xattr_udm |= XWIN_ATTR_BORDER_PIXEL;
		}
	}

	unsigned long
	xwidget_attr::background_pixel()
	{return	xwin_attr.background_pixel;}

	
	bool
	xwidget_attr::operator == ( const xwidget_attr & attr ){
		if( xwidth != attr.xwidth )
			return	false;
	else	if( xheight != attr.xheight )
			return	false;
	else	if( xpos != attr.xpos )
			return	false;
	else	if( ypos != attr.ypos )
			return	false;
	else	if( xevent_mask != attr.xevent_mask )
			return	false;
	else	if( xattr_mask != attr.xattr_mask )
			return	false;
	else	if( xsize_mask != attr.xsize_mask )
			return	false;
	else	if( xclass != attr.xclass )
			return	false;
	else	if( xdepth != attr.xdepth )
			return	false;
	else	if( is_mapped != attr.is_mapped )
			return	false;
	else	if( is_created != attr.is_created )
			return	false;
	else	if( tsx_mask != attr.tsx_mask )
			return	false;
	else	if( xgroup != attr.xgroup )
			return	false;
	}

	bool
	xwidget_attr::operator != ( const xwidget_attr & attr ){
		return	((*this == attr) is false);
	}








	xWidget::xWidget()
	:	xwidget_attr(){
		xdisplay	= nullptr;
		w_parent	= nullptr;

		xwindow		= 0;
		memset(&xpixmap, 0, sizeof(xpixmap));
	}

	xWidget::~xWidget(){
		xdisplay = nullptr;
	}


	Drawable
	xWidget::drawable(){
		return	xwindow;
	}

	Pixmap
	xWidget::pixmap(){
		return	xpixmap;
	}

	xWidget &
	xWidget::create( xWidget & Parent, unsigned int W, unsigned int H, int X, int Y ){
		xWidget	* child = new xWidget;

		child->x(X);
		child->y(Y);

		child->width(W);
		child->height(H);

		child->w_parent = &Parent;
		child->xdisplay = Parent.xdisplay;

		child->background_pixel(0x0);
		child->border_pixel(0x0);
		child->xborder_width = 1;

		child->xwindow	= XCreateWindow(
			Parent.xdisplay->display(), Parent.drawable(),
			child->x(), child->y(), child->width(), child->height(),
			child->xborder_width, child->depth(), child->xwidget_attr::xclass,
			child->xdisplay->visual(), child->xwidget_attr::xattr_mask,
			&(child->xwidget_attr::xwin_attr)
		);
		
		if( child->drawable() gt 0 )
			child->xwidget_attr::is_created = true;
		else	child->xwidget_attr::is_created = false;

		child->xwidget_attr::is_mapped = false;
		child->xwidget_attr::update_xattr = true;

	return	*child;
	}

	xWidget &
	xWidget::spawn(unsigned int W, unsigned int H, int X, int Y){
		return	create(*this,W,H,X,Y);
	}

	void
	xWidget::background_pixel(unsigned long	bp){
		xwidget_attr::background_pixel(bp);
		if( xdisplay is null )
			return;
		if( created() is true and showing() is true ){
			XSetWindowBackground(
				xdisplay->display(), drawable(),
				xwidget_attr::background_pixel()
			);
		}
	}

	void
	xWidget::border_pixel(unsigned long bp){
		xwidget_attr::border_pixel(bp);
		if( xdisplay is null )
			return;
		if( created() is true and showing() is true ){
			XSetWindowBorder(
				xdisplay->display(), drawable(),
				xwidget_attr::border_pixel()
			);
		}
	}

	bool
	xWidget::show(){
		if( xdisplay is null )
			return	false;
	else	if( xwindow isnot 0 and xwidget_attr::showing() is false and xwidget_attr::created() is true ){
			int mw = XMapWindow( xdisplay->display(), drawable() );
			if( mw is 1 ){
				xwidget_attr::is_mapped = true;
				return	true;
			}else	return	false;
		}
	else	return	false;
	}

	bool
	xWidget::hide(){
		if( xdisplay is null )
			return	false;
		if( xwidget_attr::created() is false )
			return	false;
		if( xwidget_attr::showing() is false )
			return	false;

		int uw = XUnmapWindow( xdisplay->display(), xwindow );
		if( uw is 1 ){
			xwidget_attr::is_mapped = false;
		}else	return	false;
	}

	bool
	xWidget::destroy(){
		if( xdisplay is null )
			return	false;
		if( xwidget_attr::created() is false )
			return	false;

		int dw = XDestroyWindow( xdisplay->display(), xwindow );
		if( dw is 1 ){
			xwidget_attr::is_mapped = false;
			xwidget_attr::is_created= false;
			xwindow = 0;
		return	true;
		}else	return	false;
	}

	bool
	xWidget::create_root( xDisplay * server ){
		if( server is null )
			return	false;
		w_parent = new xWidget;
		
		xdisplay = server;
		w_parent->xwidget_attr::width( server->width() );
		w_parent->xwidget_attr::height( server->height() );
		w_parent->xwindow = server->root();

		widget_is_app = true;
	return	true;
	}

	bool
	xWidget::update_widget(){
		if( xdisplay is null )
			return	false;
	else	if( created() is false or showing() is false )
			return	false;
	else	if( xwidget_attr::needs_reattr() is false )
			return	false;
		else{
			XChangeWindowAttributes(xdisplay->display(), drawable(), xwidget_attr::xattr_mask, &(xwidget_attr::xwin_attr));

			xwidget_attr::update_xattr = false;
			xwidget_attr::xattr_udm = 0;
		}
	}


}
