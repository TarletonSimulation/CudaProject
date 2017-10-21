#include <tsx/application.h>

namespace tsx{

	xApp::xApp(int Argc, char ** Argv)
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

		xWidget::create_root( (xDisplay *)this );

		xWidget::xwindow = XCreateWindow(
			xDisplay::display(), xWidget::w_parent->drawable(),
			xWidget::x(), xWidget::y(), xWidget::width(), xWidget::height(),
			xWidget::xwidget_attr::border_width(), xWidget::xwidget_attr::depth(),
			xWidget::xwidget_attr::xclass, xDisplay::visual(),
			xWidget::xwidget_attr::xattr_mask, &(xWidget::xwidget_attr::xwin_attr)
		);

		xWidget::xwidget_attr::is_created = true;
		
	}

	xApp::~xApp(){
		if( xDisplay::connected() ){
			xDisplay::disconnect();
			if(xDisplay::connected() is false)
				std::cout << "No longer connected to XServer" << std::endl;
		}

		delete xWidget::w_parent;
		xWidget::w_parent = nullptr;
	}

	bool
	xApp::destroy(){
		if( running() )
			stop();
		xWidget::destroy();
		xDisplay::disconnect();
	}

	int
	xApp::start(){
		if( !created() ){
			std::cout << "window not created" << std::endl;
			return	false;
		}

		xWidget::show();

		if( looped )
			return	0;
		else	looped = true;

		if( xWidget::xwidget_attr::created() ){
			if( xWidget::xwidget_attr::needs_resize() ){
				XResizeWindow( xDisplay::display(), xWidget::drawable(), xWidget::width(), xWidget::height() );
			}

			if( xWidget::xwidget_attr::needs_repos() ){
				XMoveWindow( xDisplay::display(), xWidget::drawable(), xWidget::x(), xWidget::y() );
			}
		}
		return	running();
	}

	int
	xApp::stop(){
		if( !looped )
			return	0;
		else	looped = false;
		return	!running();
	}

	bool
	xApp::running(){
		return	looped;
	}

	void
	xApp::width(unsigned int w){
		xWidget::xwidget_attr::width(w);
	}

	unsigned int
	xApp::width()
	{return	xWidget::xwidget_attr::width();}

	void
	xApp::height(unsigned int h){
		xWidget::xwidget_attr::height(h);
	}

	unsigned int
	xApp::height()
	{return	xWidget::xwidget_attr::height();}

	int
	xApp::next_event()
	{return	xDisplay::xEvent::next();}

	int
	xApp::event_type()
	{return	xDisplay::xEvent::type();}

	void
	xApp::x(int X){
		xWidget::x(X);
	}

	int
	xApp::x()
	{return	xWidget::x();}

	void
	xApp::y(int Y)
	{xWidget::y(Y);}

	int
	xApp::y()
	{return	xWidget::y();}
}

