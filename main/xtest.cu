#include <tsx/application.h>
#include <tsx/widget.h>
#include <tsx/file.h>


int
some_expose_event(void * widget, void * n1, void * n2){
	std::cout << "\tsome expose event from child" << std::endl;
return	0;
}




int app_prexpose(void * app, void * disp, void * ret_v){
	int & x = *static_cast<int *>(ret_v);
	tsx::Application * prog = static_cast<tsx::Application *>(app);
	Display *	display = static_cast<Display *>(disp);

	if( display is null ){
		x = -1;
	return	x;
}else	if( prog is null ){
		x = -2;
	return	x;
}else	x = 0;
return	x;
}

int
app_expose(void * app, void * disp, void * ret_v){
	
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

	glMatrixMode( GL_PROJECTION );
	glLoadIdentity();
	glOrtho(-1.0f,1.0f,-1.0f,1.0f,1.0f,20.0f);
return	x;
}

int app_resize(void * app, void * n1, void * ret_v){
	tsx::Application * prog	= static_cast<tsx::Application *>(app);
	int * x = static_cast<int *>(ret_v);

	if( *x lt 0 )	return *x;
	std::cout << "widget resize" << std::endl;
	tsx::Rectangle rect = prog->Widget::size();

	XResizeWindow(prog->XDisplayPtr(), prog->Widget::XWindow(), rect.width(), rect.height());
return	0;
}

int app_cleanup(void * app, void * n1, void * n2){
	std::cout << "application cleanup stage" << std::endl;
return	0;
}

int app_startup(void * app, void * n1, void * n2){
	std::cout << "some startup process" << std::endl;
}


int main(int argc, char ** argv){
	
	tsx::Application app(argc, argv);

	tsx::Rectangle	geom;
	tsx::Point	at;

	tsx::set(geom, 50,50);
	tsx::set(at, 0,0);

	int ret_v = 0;
	app.connect_action("startup", app_startup, null, null);
	app.connect_action("expose", app_prexpose, app.XDisplayPtr(), &ret_v);
	app.connect_action("expose", app_expose, app.XDisplayPtr(), &ret_v);
	app.connect_action("configure", app_resize, null, &ret_v);
	app.connect_action("cleanup", app_cleanup, null, null);


	app.start();

return	0;
}
