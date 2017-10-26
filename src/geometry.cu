#include <tsx/prefix.h>

namespace	tsx{

	Rectangle::Rectangle()
	: w(0), h(0){
		limits.max.width	= null;
		limits.max.height	= null;
		limits.min.width	= null;
		limits.min.height	= null;
	}

	Rectangle::Rectangle(uint W, uint H)
	: w(W), h(H){
		limits.max.width	= null;
		limits.max.height	= null;
		limits.min.width	= null;
		limits.min.height	= null;
	}

	Rectangle::Rectangle(const Rectangle & rect)
	: w(rect.w), h(rect.h){
		
	}

	Rectangle::~Rectangle(){
		if( limits.max.width isnot null )
			delete	limits.max.width;

		if( limits.max.height isnot null )
			delete	limits.max.height;

		if( limits.min.width isnot null )
			delete	limits.min.width;

		if( limits.min.height isnot null )
			delete	limits.min.height;

		limits.max.width = limits.max.height = null;
		limits.min.width = limits.min.height = null;
	}

}


