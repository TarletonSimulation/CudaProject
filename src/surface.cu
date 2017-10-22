#include <tsx/surface.h>

namespace tsx{

	glxSurface::glxSurface()
	:	Widget(){
		xvisual_info	= nullptr;
		glx_fbconfig	= nullptr;
	}

	glxSurface::~glxSurface(){

	}

}




