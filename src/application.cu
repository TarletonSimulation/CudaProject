#include <tsx/application.h>

namespace	tsx{

	Application::Application(int argc, char ** argv)
	:	Widget(this), xDisplay(){
		xDisplay::connect();	// later change to allow multiple connection choices //

		Widget::create_action("startup",null,null,null);
		Widget::create_action("cleanup",null,null,null);

		if( xDisplay::connected() is false ){
			std::cerr << "Failed to connect to XServer" << std::endl;
			exit(1);
		}

		xargc = argc;
		xargv = new std::string [xargc];
		Widget::wparent = null;

		for(int i=0;i<xargc;i++){
			xargv[i] = std::string(argv[i]);
		}

		if( Widget::widget_base::geometry.width() lte 5 ){
			Widget::widget_base::geometry.width(300);
		}

		if( Widget::widget_base::geometry.height() lte 5 ){
			Widget::widget_base::geometry.height(300);
		}

		GLint	glattr[]	= {GLX_DOUBLEBUFFER, GLX_RGBA, GLX_DEPTH_SIZE, 24, None};
XSetWindowAttributes	swin_attr;
		ulong	vmask		= CWColormap | CWEventMask;
		long	emask		= KeyPressMask | ButtonPressMask | StructureNotifyMask | ExposureMask;

		Widget::widget_base::vis_info	= glXChooseVisual(xDisplay::display_pointer(), null, glattr);
		if(Widget::widget_base::vis_info is null){
			std::cerr << "glXChooseVisual failed to execute properly: tsx::Application()" << std::endl;
			exit(1);
		}

		Widget::widget_base::colormap	= XCreateColormap(xDisplay::display_pointer(), xDisplay::root(), Widget::widget_base::vis_info->visual, AllocNone);

		swin_attr.event_mask	= emask;
		swin_attr.colormap	= Widget::widget_base::colormap;

		Widget::widget_base::window	= XCreateWindow(
								xDisplay::display_pointer(), xDisplay::root(),
								Widget::widget_base::at.x(), Widget::widget_base::at.y(),
								Widget::widget_base::geometry.width(), Widget::widget_base::geometry.height(),
								1, Widget::widget_base::vis_info->depth,
								InputOutput, Widget::widget_base::vis_info->visual,
								vmask, &swin_attr
							);
		if( Widget::widget_base::window is 0 ){
			std::cerr << "Failed to create tsx::Application window" << std::endl;
			std::cerr << "Exiting program" << std::endl;
			exit(1);
		}else{
			Widget::created(true);
			Widget::showing(false);
			Widget::active(false);
		}

		XStoreName(xDisplay::display_pointer(), Widget::widget_base::window, xargv[0].c_str());

		Widget::widget_base::glx_context = glXCreateContext(xDisplay::display_pointer(), Widget::widget_base::vis_info, null, true);
		glXMakeCurrent(xDisplay::display_pointer(), Widget::widget_base::window, Widget::widget_base::glx_context);
		glEnable(GL_DEPTH_TEST);
	}

	Application::~Application(){
		call_actions("cleanup");
		if( xDisplay::connected() is true ){
			xDisplay::disconnect();
			
			if( xDisplay::connected() is true ){
				std::cerr << "Failed to disconnect from XServer" << std::endl;
				exit(2);
			}
		}
	}



	bool
	Application::start(){
		std::list<int> init_rv;
		if( xDisplay::connected() is false )
			return	false;
	else	if( Widget::winfo_t::created is false )
			return	false;

		xrun = true;
		bool	startup_called = false;

		Widget::show();
		XEvent	evt;
		XWindowAttributes win_attr;

		bool	no_act = false;

		if( Widget::child_list.size() gt 0 ){
			for(
				WidgetList::iterator child = Widget::child_list.begin();
				child isnot Widget::child_list.end();
				++child
			){
				(*child)->show();
			}
		}

		while( running() ){
			if( startup_called is false ){
				Widget::call_actions("startup");
				startup_called = true;
			}

			if( startup_called is true ){
				XNextEvent(XDisplayPtr(), &evt);

			switch( evt.type ){
				case	ButtonPress:
					break;
				case	KeyPress:
					switch( XLookupKeysym( &(evt.xkey), 0 ) ){
						case	XK_Escape:
							stop();	// end app main loop //
							break;
					}
					break;
				case	ConfigureNotify:
					// needs to be changed to be more specific with handleing children widgets //
					// + ^WITH ALL EVENTS + //
					// + Missing connected actions to sub_class:Widget + from Widget initialization //
					if( Widget::widget_base::resize_needed() is true ){
						Widget::call_actions("configure", evt.xany.window);
					}
					break;
				case	Expose:
					Widget::size(win_attr.width, win_attr.height);
					
					Widget::call_actions("expose", evt.xany.window);
					glXSwapBuffers(XDisplayPtr(), Widget::XWindow());
					break;
			}
		}	// end next event //
		}	// end while loop //

		XDestroyWindow(xDisplay::display_pointer(), Widget::winfo_t::window);
	return	true;
	}

	bool
	Application::stop(){
		if( xrun is false )
			;
		else	xrun = false;
		return	(xrun is false);
	}

	uint
	Application::action_count()
	const{
		return	Widget::action_count();
	}

	bool
	Application::running()
	const{return (xrun is true);}

	bool
	Application::connect_action(const std::string & title, Handler::Caller caller, void * a, void * b){
		return	Widget::connect_action(title,caller,a,b);
	}

	bool
	Application::disconnect_action(const std::string & title, Handler::Caller caller){
		return	Widget::disconnect_action(title, caller);
	}

	bool
	Application::create_action(const std::string & title, Handler::Caller caller, void *a, void *b){
		return	Widget::create_action(title,caller,a,b);
	}

	bool
	Application::destroy_action(const std::string & title){
		return	Widget::destroy_action(title);
	}

	const Widget::ActionList &
	Application::actions()
	const{
		return	Widget::actions();
	}

	Widget::ActionList &
	Application::actions_ref(){
		return	Widget::actions_ref();
	}

	Widget::ActionList *
	Application::actions_pointer(){
		return	Widget::actions_pointer();
	}

	const Widget &
	Application::widget()
	const{
		return	Widget::widget();
	}

	Widget &
	Application::widget_ref(){
		return	Widget::widget_ref();
	}

	Widget *
	Application::widget_pointer(){
		return	Widget::widget_pointer();
	}

	Display *
	Application::XDisplayPtr()
	const{
		if( xDisplay::connected() is false )
			return	null;
		else	return	xDisplay::xserv;
	}

	std::list<int>
	Application::operator ()(const std::string & action){
		Widget & w = *static_cast<Widget *>(this);
		return	(w)(action);
	}

}
