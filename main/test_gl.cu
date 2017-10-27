#include <tsx/prefix.h>
#include <tsx/geometry.h>
#include <tsx/display.h>

int main(int argc, char ** argv){
	
	tsx::xDisplay	server;
	tsx::Rectangle	geometry;

	server.connect();

	geometry = server.geometry();
	
	std::cout << "Screen Size:	(" << geometry.width() << "," << geometry.height() << ")" << std::endl;
	std::cout << "Screen Numb:	 " << server.screen_number() << std::endl;
	
return	0;
}
