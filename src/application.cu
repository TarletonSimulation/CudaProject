#include <tsx/application.h>

namespace tsx{

	App::App(int Argc, char ** Argv)
	: xDisplay("DISPLAY"), looped(false)
	{
		argv = new std::string [Argc];
		for(int i=0;i<Argc;i++){
			argv[i] = Argv[i];
		}

		if( !xDisplay::connected() ){
			std::cerr << "Failed to connect to '" << xDisplay::server_name() << "' XServer" << std::endl;
			exit(1);
		}

		Widget::create_root( (xDisplay *)this );

		Widget::depth( xDisplay::depth() );

		Widget::xwindow = XCreateWindow(
			xDisplay::display(), Widget::w_parent->drawable(),
			Widget::x(), Widget::y(), Widget::width(), Widget::height(),
			Widget::widget_attr::border_width(), Widget::depth(),
			Widget::widget_attr::xclass, xDisplay::visual(),
			Widget::widget_attr::xattr_mask, &(Widget::widget_attr::xwin_attr)
		);

		Widget::widget_attr::is_created = true;
		Widget::widget_attr::is_mapped = false;
		
	}

	App::~App(){
		if( xDisplay::connected() ){
			xDisplay::disconnect();
			if(xDisplay::connected() is false)
				std::cout << "No longer connected to XServer" << std::endl;
		}

		delete Widget::w_parent;
		Widget::w_parent = nullptr;
	}

	bool
	App::destroy(){
		if( running() )
			stop();
		Widget::destroy();
		xDisplay::disconnect();
	}

	Widget &
	App::widget(){
		return	(Widget &)*this;
	}

	int
	App::start(){
		if( !created() ){
			std::cout << "window not created" << std::endl;
			return	false;
		}

		Widget::show();

		if( looped )
			return	0;
		else	looped = true;

		if( Widget::widget_attr::created() and Widget::widget_attr::showing() ){
			if( Widget::widget_attr::needs_resize() ){
				XResizeWindow( xDisplay::display(), Widget::drawable(), Widget::width(), Widget::height() );
			}

			if( Widget::widget_attr::needs_repos() ){
				XMoveWindow( xDisplay::display(), Widget::drawable(), Widget::x(), Widget::y() );
			}

			XFlush(xDisplay::display());
		}
		return	running();
	}

	int
	App::stop(){
		if( !looped )
			return	0;
		else	looped = false;
		return	(running() is false);
	}

	bool
	App::running(){
		return	looped;
	}

	void
	App::width(unsigned int w){
		Widget::widget_attr::width(w);
	}

	unsigned int
	App::width()
	{return	Widget::widget_attr::width();}

	void
	App::height(unsigned int h){
		Widget::widget_attr::height(h);
	}

	unsigned int
	App::height()
	{return	Widget::widget_attr::height();}

	int
	App::next_event()
	{return	xDisplay::Event::next();}

	int
	App::event_type()
	{return	xDisplay::Event::type();}

	void
	App::x(int X){
		Widget::x(X);
	}

	int
	App::x()
	{return	Widget::x();}

	void
	App::y(int Y)
	{Widget::y(Y);}

	int
	App::y()
	{return	Widget::y();}

	Drawable
	App::event_window()
	{return	xDisplay::Event::xevent.xany.window;}

	void
	App::flush(){
		if( xDisplay::connected() ){
			XFlush(xDisplay::display());
		}
	}
}

