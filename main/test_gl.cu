#include <tsx/prefix.h>
#include <tsx/geometry.h>

int main(int argc, char ** argv){
	
	tsx::Rectangle	rect1 = tsx::Rectangle::create(12,13);

	rect1.scale_width((1.0/3));
	rect1.scale_height(2);

	std::cout << "Width: " << rect1.width() << std::endl;
	std::cout << "Hiehgt: " << rect1.height() << std::endl;

return	0;
}
