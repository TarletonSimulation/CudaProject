#include <tsx/widget.h>

namespace	tsx{

	widget_base::widget_base(){
		winfo_t::cairo		= null;
		winfo_t::cairo_surface	= null;
		winfo_t::vis_info	= null;
		winfo_t::gl_iarr	= null;	// for opengl attributes //
		winfo_t::gl_farr	= null;	// for rotation possibly // could be changed later //

		winfo_t::window		= 0;
		memset(&(winfo_t::colormap), 0, sizeof(Colormap));

		winfo_t::created	= false;
		winfo_t::mapped		= false;
		winfo_t::update		= false;
		winfo_t::blocking	= false;
	}

	widget_base::~widget_base(){
	}







	Widget::Widget(xDisplay * server)
	:	widget_base(){
		wparent	= null;
		xdisplay= server;
	}

	Widget::~Widget(){
		wparent = null;
	}

	
	const Widget &
	Widget::widget()
	const{return *this;}

	Widget &
	Widget::widget_ref()
	{return	*this;}

	Widget *
	Widget::widget_pointer()
	{return	this;}


	Widget *
	Widget::create_widget(Widget * Parent, const Rectangle & geom, const Point & place){
		if( Parent is null )
			return	null;
	else	if( Parent->xdisplay isnot null ){
			if( Parent->xdisplay->connected() is false )
				return	null;
			else{
				Widget * child = new Widget(Parent->xdisplay);

				child->winfo_t::geometry = geom;
				child->winfo_t::at = place;
				child->wparent	= Parent;

				XSetWindowAttributes	swin_attr;
				ulong	vmask = CWBackPixel | CWBorderPixel | CWEventMask;

				swin_attr.background_pixel = 0xdead;
				swin_attr.border_pixel = 0xbeaf;
				swin_attr.event_mask = XEVT_DEFAULT_WINDOW_MASK;

				if( child->winfo_t::geometry.width() is 0 )
					child->winfo_t::geometry.width(10);
				if( child->winfo_t::geometry.height() is 0 )
					child->winfo_t::geometry.height(10);

				child->winfo_t::window = XCreateWindow(
					child->xdisplay->display_pointer(), child->wparent->winfo_t::window,
					child->winfo_t::at.x(), child->winfo_t::at.y(),
					child->winfo_t::geometry.width(), child->winfo_t::geometry.height(),
					2, child->xdisplay->depth(), InputOutput, child->xdisplay->visual(),
					vmask, &swin_attr
				);

				if( child->winfo_t::window is 0 )
					return	null;
				else
					child->winfo_t::created = true;
			return	child;
			}
		}
	return	null;
	}

	Widget *
	create_widget(Widget * Parent, const Rectangle & geom, const Point & place){
		return	Widget::create_widget(Parent, geom, place);
	}


	bool
	Widget::create_action(const std::string & title, Handler::Caller caller, void * a, void * b){
		if( xactions.size() gt 0 ){
			;
		}
		xactions.push_back( Action::create_action_pointer(title, caller, this, a, b) );
	return	true;
	}

	bool
	Widget::destroy_action(const std::string & action){
		return	false;
	}


	bool
	Widget::connect_action(const std::string & title, Handler::Caller caller, void * data, void * edata){
		if( xactions.size() gt 0 ){
			for( ActionList::iterator act = xactions.begin(); act != xactions.end(); ++act ){
				if( (*act)->name() is title ){
					return	(*act)->connect(caller, this, data, edata);
				}
			}
		return	false;
		}else	xactions.push_back( Action::create_action_pointer(title, caller, this, data, edata) );
	return	true;
	}

	bool
	Widget::disconnect_action(const std::string & action, Handler::Caller caller){
		return	false;
	}

	const Widget::ActionList &
	Widget::actions()
	const{
		return	xactions;
	}

	Widget::ActionList &
	Widget::actions_ref(){
		return	xactions;
	}

	Widget::ActionList *
	Widget::actions_pointer(){
		return	&xactions;
	}

	uint
	Widget::action_count()
	const{return	xactions.size();}


	void
	Widget::show(){
		if( winfo_t::created is false )
			return;
	else	if( winfo_t::mapped is true )
			return;
	else	if( winfo_t::window is 0 )
			return;
	else	if( xdisplay is null )
			return;
		else	XMapWindow(xdisplay->display_pointer(), winfo_t::window);
	}

	bool
	Widget::showing()
	const{
		return	winfo_t::mapped;
	}

	bool
	Widget::showing(const Widget & w){
		return	w.showing();
	}

	std::list<int>
	Widget::operator () (const std::string & action){
		std::list<int>	rv;
		if( xactions.size() is 0 ){
			rv.push_back(-1);
			return	rv;
		}else{
			for( ActionList::iterator act = xactions.begin(); act != xactions.end(); ++act ){
				if( (*act)->name() is action ){
					return	(*(*act))();
				}
			}
		}
	return	rv;
	}

}
