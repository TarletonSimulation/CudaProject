#include <tsx/prefix.h>
#include <tsx/geometry.h>

int main(int argc, char ** argv){
	
	tsx::Point at_1 = tsx::Point::create(12,10);
	tsx::Point at_2 = tsx::Point::create(10,2);
	std::cout << "The distance from 1 -> 2 is " << tsx::distance(at_1, at_2) << std::endl;

return	0;
}
