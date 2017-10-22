#include <tsx/prefix.h>
#include <tsx/display.h>
#include <tsx/widget.h>
#include <tsx/application.h>

int main(int argc, char ** argv){
	
	tsx::xApp	app(argc, argv);

	app.width(500);
	app.height(500);

	app.x(50);
	app.y(150);

	app.start();

	while( app.running() ){
		app.next_event();

		switch( app.event_type() ){
			case	KeyPress:
				std::cout << "Ending Program" << std::endl;
				app.stop();
				break;
		}
	}

	app.destroy();
		
return	0;
}
