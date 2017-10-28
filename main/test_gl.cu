#include <tsx/prefix.h>
#include <tsx/geometry.h>
#include <tsx/display.h>
#include <tsx/action.h>


class	Test
:	public tsx::Rectangle,
	public tsx::Point{
public:
		 Test(){}
		~Test(){}

static	int foo(void * a, void * b, void * c){
		Test *	x = (Test *)a;
		std::cout << "Some print stuff here" << std::endl;
		
		x->print_size();
		x->print_pos();
	return	0;
	}
	
	void	print_size(){
		printf("Size: (%.2f,%.2f)\n", tsx::Rectangle::width(), tsx::Rectangle::height());
	}

	void	print_pos(){
		printf("Pos:  (%.2f,%.2f)\n", tsx::Point::x(), tsx::Point::y());
	}

protected:

private:
};


int main(int argc, char ** argv){
	
	tsx::Handler	call;
	Test		test;

	call.set(Test::foo, &test, null, null);

	tsx::set(test.rectangle_ref(), 1.2f, 2.3f);
	tsx::set(test.point_ref(), 0.1f, 1.2f);

	call();

return	0;
}
