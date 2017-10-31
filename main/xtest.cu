#include <tsx/application.h>
#include <tsx/widget.h>
#include <tsx/file.h>

// pre-expose checking function //
int app_prexpose(void * app, void * disp, void * ret_v){
	int & x = *static_cast<int *>(ret_v);
	tsx::Application * prog = static_cast<tsx::Application *>(app);
	Display *	display = static_cast<Display *>(disp);

	std::cout << "application pre-expose" << std::endl;

	if( display is null ){
		x = -1;
	return	x;
}else	if( prog is null ){
		x = -2;
	return	x;
}else	x = 0;
return	x;
}

// attempt at an expose event //
int app_expose(void * app, void * disp, void * ret_v){
	
	tsx::Application * prog	= static_cast<tsx::Application *>(app);
	Display	*	display = static_cast<Display *>(disp);
	int 	&	x	= *static_cast<int *>(ret_v);

	XWindowAttributes wa;
	std::cout << "expose" << std::endl;

	if( x is -1 ){
		std::cout << "Failed to connect to XDisplay()" << std::endl;
	return	x;
}else	if( x is -2 ){
		std::cout << "Failed to locat tsx::Application()" << std::endl;
	return	x;
}else	x = 0;

	glClearColor(1.0f,1.0f,1.0f,1.0f);
	glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

return	x;
}


// attempt at a reconfigure event //
int app_resize(void * app, void * n1, void * ret_v){
	tsx::Application * prog	= static_cast<tsx::Application *>(app);
	int * x = static_cast<int *>(ret_v);

	if( *x lt 0 )	return *x;
	std::cout << "widget resize" << std::endl;
	tsx::Rectangle rect = prog->Widget::size();
	
	// test xlib function //
	// * later reconfigure all window structure items //
	// * set resize and repos to false //
	XResizeWindow(prog->XDisplayPtr(), prog->Widget::XWindow(), rect.width(), rect.height());
return	0;
}

// application finalization function //
int app_cleanup(void * app, void * n1, void * n2){
	std::cout << "finalizing database" << std::endl;
return	0;
}

// application initialization function //
int app_startup(void * app, void * n1, void * n2){
	std::cout << "initializing database" << std::endl;
}


int main(int argc, char ** argv){
	
	tsx::Application app(argc, argv);

	tsx::Rectangle	geom;
	tsx::Point	at;

	tsx::set(geom, 500,500);
	tsx::set(at, 0,0);

	app.Widget::size(geom);
	app.Widget::position(at);

	int ret_v = 0;
	app.connect_action("startup", app_startup, null, null);
	app.connect_action("expose", app_prexpose, app.XDisplayPtr(), &ret_v);
	app.connect_action("expose", app_expose, app.XDisplayPtr(), &ret_v);
	app.connect_action("configure", app_resize, null, &ret_v);
	app.connect_action("cleanup", app_cleanup, null, null);

	app.start();		// run application main loop //
return	0;
}
