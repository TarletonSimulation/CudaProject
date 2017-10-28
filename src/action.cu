#include <tsx/action.h>

namespace	tsx{

	Handler::Handler(){
		p1	= null;
		p2	= null;
		p3	= null;
		call	= null;
	}

	Handler::~Handler(){
		clear();
	}


	void
	Handler::clear(){
		p1 = null;
		p2 = null;
		p3 = null;
		call = null;
	}

	void
	Handler::set(Caller cb, void * a1, void * a2, void * a3){
		if( cb is null )
			call = null;
		else	call = cb;

		p1 = a1;
		p2 = a2;
		p3 = a3;
	}

	int
	Handler::operator ()(void){
		if( call is null )
			return	-1;
		else	call(p1,p2,p3);
	}

	int
	Handler::operator ()(void * a, void * b, void * c){
		p1 = a;
		p2 = b;
		p3 = c;
	return	call(p1,p2,p3);
	}

	int
	Handler::operator ()(void * b, void * c){
		p2 = b;
		p3 = c;
	return	(*this)();
	}

	int
	Handler::operator ()(void * c){
		p3 = c;
	return	(*this)();
	}

	bool
	Handler::operator == (const Handler & action){
		if( call isnot action.call )
			return	false;
	else	if( p1 isnot action.p1 )
			return	false;
	else	if( p2 isnot action.p2 )
			return	false;
	else	if( p3 isnot action.p3 )
			return	false;
		else	return	true;
	}

	bool
	Handler::operator != (const Handler & action){
		return	( (*this is action) isnot true );
	}

}




