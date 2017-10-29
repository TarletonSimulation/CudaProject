#include <tsx/application.h>

namespace	tsx{

	static	int
	tsx_startup(void *a, void *b, void *c){
		return	0;
	}

	Application::Application(int argc, char ** argv)
	:	Widget(this), xDisplay(){
		xDisplay::connect();	// just for the moment //

		XSetWindowAttributes	swin_attr;
		ulong	vmask = CWBackPixel | CWBorderPixel | CWEventMask;

		swin_attr.background_pixel = 0x0;
		swin_attr.border_pixel = 0x0;
		swin_attr.event_mask = XEVT_DEFAULT_APP_MASK;

		if( xDisplay::connected() is false ){
			std::cerr << "Failed to connect to XServer" << std::endl;
			std::cerr << "\tExiting program..." << std::endl;
			exit(1);
		}

		xrun = false;

		Widget::create_action("startup", tsx_startup, null, null);

		Widget::wparent	= new Widget;

		Widget::wparent->winfo_t::window = xDisplay::root();

		set(Widget::winfo_t::geometry, 800, 500);

		Widget::winfo_t::window	= XCreateWindow(
			xDisplay::display_pointer(), Widget::wparent->winfo_t::window,
			(int)Widget::winfo_t::at.x(), (int)Widget::winfo_t::at.y(),
			(uint)Widget::winfo_t::geometry.width(), (uint)Widget::winfo_t::geometry.height(),
			1, DefaultDepth( xDisplay::xserv, xDisplay::xnumb ), InputOutput,
			DefaultVisual( xDisplay::xserv, xDisplay::xnumb ), vmask, &swin_attr
		);

		if( Widget::winfo_t::window is 0 )
			Widget::winfo_t::created = false;
		else	Widget::winfo_t::created = true;
	}

	Application::~Application(){
		delete	Widget::wparent;
		if( xDisplay::connected() is false ){
			std::cerr << "Failed to disconnect from XServer" << std::endl;
			exit(2);
		}
	}



	bool
	Application::start(){
		std::list<int> init_rv;
		if( xDisplay::connected() is false )
			return	false;

		if( action_count() gt 0 ){
			for(
				Widget::ActionList::iterator act = Widget::xactions.begin();
				act != Widget::xactions.end(); ++act
			){
				if( (*act)->name() is "startup" ){
					init_rv = (*(*act))();
				}
			}
		}

		xrun = true;

		Widget::show();
		XFlush(xDisplay::display_pointer());
		sleep(5);
	}

	uint
	Application::action_count()
	const{
		return	Widget::action_count();
	}

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

	std::list<int>
	Application::operator ()(const std::string & action){
		Widget * w = (Widget *)this;
		return	(*w)(action);
	}

}
