#include <tsx/surface.h>

namespace tsx{

	glxSurface::glxSurface()
	:	xWidget(){
		xvisual_info	= nullptr;
		glx_fbconfig	= nullptr;
	}

	glxSurface::~glxSurface(){

	}

}




