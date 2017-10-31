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

	bool
	widget_base::created()
	const{return (winfo_t::created is true);}

	void
	widget_base::created(bool v)
	{winfo_t::created = v;}

	bool
	widget_base::showing()
	const{return (winfo_t::mapped is true);}

	void
	widget_base::showing(bool v)
	{winfo_t::mapped = v;}

	bool
	widget_base::active()
	const{return (winfo_t::active is true);}

	void
	widget_base::active(bool v)
	{winfo_t::active = v;}




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

	Drawable
	Widget::XWindow()
	const{
		return	widget_base::window;
	}

	Drawable
	Widget::XWindow(const Widget & widg){
		return	widg.XWindow();
	}

	bool
	Widget::created()
	const{return widget_base::created();}

	bool
	Widget::showing()
	const{return widget_base::showing();}

	void
	Widget::created(bool v)
	{widget_base::created(v);}

	void
	Widget::showing(bool v)
	{widget_base::showing(v);}

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
		glXMakeCurrent( child->xdisplay->display_pointer(), child->Widget::widget_base::window, child->widget_base::glx_context );
		
		child->xactions.push_back( Action::create_action_pointer("expose",null,null,null) );
		child->xactions.push_back( Action::create_action_pointer("configure",null,null,null) );
		child->xactions.push_back( Action::create_action_pointer("resize",null,null,null) );
		child->xactions.push_back( Action::create_action_pointer("button-press",null,null,null) );
		child->xactions.push_back( Action::create_action_pointer("button-release",null,null,null) );
		child->xactions.push_back( Action::create_action_pointer("cursor-enter",null,null,null) );
		child->xactions.push_back( Action::create_action_pointer("cursor-leave",null,null,null) );
		child->xactions.push_back( Action::create_action_pointer("on-hide",null,null,null) );
		child->xactions.push_back( Action::create_action_pointer("on-show",null,null,null) );
		child->xactions.push_back( Action::create_action_pointer("on-activate",null,null,null) );
		child->xactions.push_back( Action::create_action_pointer("on-deactivate",null,null,null) );
		child->xactions.push_back( Action::create_action_pointer("on-destroy",null,null,null) );
		
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


	void
	Widget::call_actions(const std::string & label){
		if( xactions.size() is 0 )	return;
		for(
			ActionList::iterator action = actions_ref().begin();
			action isnot actions_ref().end(); ++action
		){
			if( (*action)->name() is label ){
				(*(*action))();
				break;
			}
		}

		for(
			WidgetList::iterator child = child_list.begin();
			child isnot child_list.end(); ++child
		){
			for(
				ActionList::iterator action = (*child)->actions_ref().begin();
				action isnot (*child)->actions_ref().end(); ++action
			){
				if( (*action)->name() is label ){
					(*(*action))();
					break;
				}
			}
		}
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
	Widget::showing(const Widget & w)
	{return	w.showing();}

	void
	Widget::size(float w, float h){
		if( (can_use_scalar(w) is false) or (can_use_scalar(h) is false) )
			return;
		else{
			widget_base::geometry.width(w);
			widget_base::geometry.height(h);
		}
	return;
	}
	
	void
	Widget::size(Widget & widg, float w, float h)
	{widg.size(w,h);}

	const Rectangle &
	Widget::size()
	const{return widget_base::geometry;}

	const Rectangle &
	Widget::size(const Widget & widg)
	{return	widg.size();}

	Rectangle &
	Widget::size_ref()
	{return	widget_base::geometry;}

	Rectangle &
	Widget::size_ref(Widget & widg)
	{return	widg.size_ref();}

	Rectangle *
	Widget::size_pointer()
	{return &(widget_base::geometry);}

	Rectangle *
	Widget::size_pointer(Widget & widg)
	{return widg.size_pointer();}


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

	Point &
	Widget::position_ref()
	{return	widget_base::at;}

	Point &
	Widget::position_ref(Widget & widg)
	{return widg.position_ref();}

	Point *
	Widget::position_pointer()
	{return &(widget_base::at);}

	Point *
	Widget::position_pointer(Widget & widg)
	{return widg.position_pointer();}



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
