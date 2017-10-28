#include <tsx/widget.h>

namespace	tsx{

	widget_base::widget_base(){
		winfo_t::cairo		= null;
		winfo_t::cairo_surface	= null;
		winfo_t::vis_info	= null;
		winfo_t::gl_iarr	= null;	// for opengl attributes //
		winfo_t::gl_farr	= null;	// for rotation possibly // could be changed later //

		winfo_t::window		= 0;
		memset(&(winfo_t::colormap), 0, sizeof(Colormap));

		winfo_t::created	= false;
		winfo_t::mapped		= false;
		winfo_t::update		= false;
	}

	widget_base::~widget_base(){}







	Widget::Widget()
	:	widget_base(){
	}

	Widget::~Widget(){
	}

	bool
	Widget::create_action(const std::string & title, Handler::Caller caller, void * a, void * b){
		if( xactions.size() gt 0 ){
			;
		}
		xactions.push_back( Action::create_action_pointer(title, caller, this, a, b) );
	return	true;
	}


	bool
	Widget::connect_action(const std::string & title, Handler::Caller caller, void * data, void * edata){
		if( xactions.size() gt 0 ){
			for( ActionList::iterator act = xactions.begin(); act != xactions.end(); ++act ){
				if( (*act)->name() is title ){
					return	(*act)->connect(caller, this, data, edata);
				}
			}
		return	false;
		}else	xactions.push_back( Action::create_action_pointer(title, caller, this, data, edata) );
	}

	uint
	Widget::action_count()
	const{return	xactions.size();}


	std::list<int>
	Widget::operator () (const std::string & action){
		std::list<int>	rv;
		if( xactions.size() is 0 ){
			rv.push_back(-1);
			return	rv;
		}else{
			for( ActionList::iterator act = xactions.begin(); act != xactions.end(); ++act ){
				if( (*act)->name() is action ){
					return	(*(*act))();
				}
			}
		}
	return	rv;
	}

}
