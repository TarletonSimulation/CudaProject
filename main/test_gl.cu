#include <tsx/prefix.h>
#include <tsx/display.h>
#include <tsx/widget.h>
#include <tsx/application.h>

#define	ThreadCount	1024

GPU
void	cuda_main(){
}

int main(int argc, char ** argv){
	
	tsx::App	app(argc, argv);
	tsx::Widget	child1 = app.spawn(50,25, 5,5);
	tsx::Widget	child2 = app.spawn(50,25, 5,35);

	app.width(500);
	app.height(500);

	app.x(50);
	app.y(150);

	app.start();

	child1.border_pixel(0xbeef);
	child1.show();

	child2.border_pixel(0xbeef);
	child2.show();

	while( app.running() ){
		app.next_event();

		child1.update_widget();
		child2.update_widget();

		switch( app.event_type() ){
			case	KeyPress:
				std::cout << "Ending Program" << std::endl;
				app.stop();
				break;
			case	EnterNotify:
				if( app.event_window() is child1.drawable() ){
					child1.border_pixel(0xdead);
				}
				if( app.event_window() is child2.drawable() ){
					child2.border_pixel(0xdead);
				}
				break;
			case	LeaveNotify:
				if( app.event_window() is child1.drawable() ){
					child1.border_pixel(0xbeef);
				}
				if( app.event_window() is child2.drawable() ){
					child2.border_pixel(0xbeef);
				}
				break;
			case	ButtonPress:
				if( app.event_window() is child1.drawable() ){
					std::cout << "button 1 clicked" << std::endl;
				}

				if( app.event_window() is child2.drawable() ){
					std::cout << "button 2 clicked" << std::endl;
				}
				break;
		}
	}

	app.destroy();
		
return	0;
}
