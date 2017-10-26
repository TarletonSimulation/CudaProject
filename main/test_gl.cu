#include <tsx/prefix.h>
#include <tsx/geometry.h>

int main(int argc, char ** argv){
	
	tsx::Rectangle	obj1 = tsx::Rectangle::create(10,10);
	tsx::Rectangle	obj2 = tsx::Rectangle::create(20,10);
	tsx::Rectangle	obj3 = obj1 + obj2;

	obj1.max_rectangle(15,20);
	obj1.min_rectangle(1,1);

	obj2.max_rectangle(35,35);
	obj2.min_rectangle(1,1);

	std::cout << "Info: obj1 w=" << obj1.width() << " h=" << obj1.height() << std::endl;
	std::cout << "Info: obj2 w=" << obj2.width() << " h=" << obj2.height() << std::endl;
	std::cout << "Info: obj3 w=" << obj3.width() << " h=" << obj3.height() << std::endl;

	std::cout << "Max Info: obj1 w=" << obj1.max_rectangle().width() << " h=" << obj1.max_rectangle().height() << std::endl;
	std::cout << "Max Info: obj2 w=" << obj2.max_rectangle().width() << " h=" << obj2.max_rectangle().height() << std::endl;
	std::cout << "Max Info: obj3 w=" << obj3.max_rectangle().width() << " h=" << obj3.max_rectangle().height() << std::endl;
	
	std::cout << "Min Info: obj1 w=" << obj1.min_rectangle().width() << " h=" << obj1.min_rectangle().height() << std::endl;
	std::cout << "Min Info: obj2 w=" << obj2.min_rectangle().width() << " h=" << obj2.min_rectangle().height() << std::endl;
	std::cout << "Min Info: obj3 w=" << obj3.min_rectangle().width() << " h=" << obj3.min_rectangle().height() << std::endl;

return	0;
}
