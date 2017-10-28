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

static	int bar(void * a, void * b, void * c){
		Test  * x = (Test *)a;
		float * y = (float *)b;
		float * z = (float *)c;

		x->Point::set(*y,*z);
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
	
	tsx::Action	action;
	Test		test;

	float	x,y;

	x = 12.0f;
	y = 1.0f;

	action.connect(Test::bar, &test, &x, &y);
	action.connect(Test::foo, &test, null, null);

	action();

return	0;
}
