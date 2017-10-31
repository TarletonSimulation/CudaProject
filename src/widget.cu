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
		winfo_t::xclass		= InputOutput;
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


	Widget &
	Widget::create(Widget & Parent, const Rectangle & geom, const Point & place){
		if( Parent.xdisplay->connected() is false ){
			std::cerr << "Function Widget::create(...) failed to create widget" << std::endl;
			std::cerr << "\tParent widget not connected to display" << std::endl;
			exit(2);
		}

		Widget * child = new Widget;

		Rectangle::set(child->widget_base::geometry, geom);
		Point::set(child->widget_base::at, place);

		child->wparent	= &Parent;
		child->xdisplay	= Parent.xdisplay;

		ulong	vmask	= CWColormap | CWEventMask;
		long	emask	= ButtonPressMask | EnterWindowMask | LeaveWindowMask | ExposureMask | StructureNotifyMask;
XSetWindowAttributes	swa;
		GLint	glattr[]= {GLX_RGBA, GLX_DOUBLEBUFFER, GLX_DEPTH_SIZE, 24};
		
		child->widget_base::vis_info	= Parent.widget_base::vis_info;

		if( child->widget_base::vis_info is null ){
			std::cerr << "Failed to create visual info pointer" << std::endl;
			std::cerr << "Function: Widget::create(...)" << std::endl;
			exit(3);
		}

		child->widget_base::colormap	= XCreateColormap(
								child->xdisplay->display_pointer(),
								child->xdisplay->root(),
								child->widget_base::vis_info->visual,
								AllocNone
								);

		swa.event_mask	= emask;
		swa.colormap	= child->widget_base::colormap;

		child->widget_base::window = XCreateWindow(
								child->xdisplay->display_pointer(), Parent.widget_base::window,
								child->widget_base::at.x(), child->widget_base::at.y(),
								child->widget_base::geometry.width(), child->widget_base::geometry.height(),
								2, child->widget_base::vis_info->depth, CopyFromParent,
								child->widget_base::vis_info->visual, vmask, &swa
							);
		
		if( child->widget_base::window is 0 ){
			std::cerr << "Function Widget::create(...) failed to craeate widget" << std::endl;
			std::cerr << "\tExiting program..." << std::endl;
			exit(2);
		}else	child->winfo_t::created = true;
		
		child->widget_base::glx_context	= glXCreateContext(child->xdisplay->display_pointer(), child->widget_base::vis_info, null, true);

		Parent.child_list.push_back(child);
	return	*child;
	}

	Widget &
	create_widget(Widget & Parent, const Rectangle & geom, const Point & place){
		return	Widget::create(Parent, geom, place);
	}

	Widget &
	Widget::create(const Rectangle & geom, const Point & place){
		return	tsx::create_widget(*this,geom,place);
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
		XFlush(xdisplay->display_pointer());
		widget_base::mapped = true;
	}

	bool
	Widget::showing()
	const{return winfo_t::mapped;}

	bool
	Widget::showing(const Widget & w)
	{return	w.showing();}

	void
	Widget::size(float w, float h)
	{Rectangle::set(widget_base::geometry,w,h);}

	void
	Widget::size(Widget & widg, float w, float h)
	{widg.size(w,h);}

	const Rectangle &
	Widget::size()
	const{return widget_base::geometry;}

	const Rectangle &
	Widget::size(const Widget & widg)
	{return	widg.size();}


	void
	Widget::position(float x, float y)
	{tsx::Point::set(widget_base::at,x,y,0.0f);}

	void
	Widget::position(Widget & widg, float x, float y)
	{widg.position(x,y);}

	const Point &
	Widget::position()
	const{return widget_base::at;}

	const Point &
	Widget::position(const Widget & widg)
	{return widg.position();}



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
