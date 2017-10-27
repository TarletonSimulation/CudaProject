#include <tsx/prefix.h>
#include <tsx/geometry.h>

int main(int argc, char ** argv){
	
	tsx::Rectangle	A	= tsx::Rectangle::create(10,12);
	tsx::Rectangle	B	= tsx::Rectangle::create(5,4);

	A.lock_width(true);
	B.lock_height(true);

	tsx::set(A, 11,9);
	tsx::set(B, 9,11 );

	A.remove_locks();
	B.remove_locks();
	
	std::cout << "A: (" << A.width() << "," << A.height() << ")" << std::endl;
	std::cout << "B: (" << B.width() << "," << B.height() << ")" << std::endl;
	
return	0;
}
