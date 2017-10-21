#include <tsx/prefix.h>
#include <tsx/display.h>
#include <tsx/widget.h>
#include <tsx/application.h>

int main(int argc, char ** argv){
	
	tsx::xApp	app(argc,argv);
	tsx::xWidget	child1 = tsx::xWidget::create(app.widget(), 50,25 , 10,10);

	app.width(500);
	app.height(500);

	app.x(50);
	app.y(33);

	app.start();

	child1.background_pixel(0xffffff);
	child1.border_pixel(0xdead);

	while( app.running() ){
		app.next_event();
		if( child1.showing() is false ){
			child1.show();

			if( child1.update_widget() is true ){
				std::cout << "Child window updated" << std::endl;
			}
		}
		
		switch( app.event_type() ){
			case	KeyPress:
				std::cout << "A key was pressed" << std::endl;
				app.stop();
				break;
		}
	}

	app.destroy();
	
return	0;
}
