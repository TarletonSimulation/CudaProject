#include <tsx/prefix.h>
#include <tsx/display.h>
#include <tsx/widget.h>
#include <tsx/application.h>

int main(int argc, char ** argv){
	
	tsx::xApp	app(argc,argv);

	app.width(500);
	app.height(500);

	app.start();

	while( app.running() ){
		app.next_event();

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
