#include <tsx/application.h>

namespace	tsx{

	static	int
	tsx_startup(void *a, void *b, void *c){
		return	0;
	}

	Application::Application(int argc, char ** argv){
		xDisplay::connect();	// just for the moment //

		if( xDisplay::connected() is false ){
			std::cerr << "Failed to connect to XServer" << std::endl;
			std::cerr << "\tExiting program..." << std::endl;
			exit(1);
		}

		xrun = false;

		Widget::create_action("startup", tsx_startup, null, null);
	}

	Application::~Application(){}



	bool
	Application::start(){
		(*this)("startup");

		xrun = true;
	}

}
