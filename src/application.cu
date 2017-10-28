#include <tsx/application.h>

namespace	tsx{

	static	int
	tsx_startup(void *a, void *b, void *c){
		return	0;
	}

	Application::Application(int argc, char ** argv)
	:	Widget(), xDisplay(){
		xDisplay::connect();	// just for the moment //

		if( xDisplay::connected() is false ){
			std::cerr << "Failed to connect to XServer" << std::endl;
			std::cerr << "\tExiting program..." << std::endl;
			exit(1);
		}else	std::cout << "Connected to XServer" << std::endl;

		xrun = false;

		Widget::create_action("startup", tsx_startup, null, null);


	}

	Application::~Application(){}



	bool
	Application::start(){
		std::list<int> init_rv;
		if( action_count() gt 0 ){
			std::cout << "Attempting to initialize application" << std::endl;
			for(
				Widget::ActionList::iterator item = Widget::xactions.begin();
				item != Widget::xactions.end(); ++item
			){
				if( (*item)->name() is "startup" ){
					init_rv = (*(*item))();
				}
			}
		}

		xrun = true;
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
