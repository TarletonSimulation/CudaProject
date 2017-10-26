#include <tsx/prefix.h>
#include <tsx/geometry.h>

namespace	tsx{

	Rectangle::Rectangle()
	: w(0), h(0){
		w_lock = false;
		h_lock = false;
	}

	Rectangle::Rectangle(float W, float H)
	: w(W), h(H){
		w_lock = false;
		h_lock = false;
	}

	Rectangle::Rectangle(const Rectangle & rect)
	: w(rect.w), h(rect.h){
		w_lock = rect.w_lock;
		h_lock = rect.h_lock;
	}

	Rectangle::~Rectangle(){}

	// friend functions //

	void
	set( Rectangle & A, float W, float H ){
		if( A.width_locked() is false )
			A.width( W );
		if( A.height_locked() is false )
			A.height( H );
	}

	void
	set( Rectangle & A, const Rectangle & B ){
		set(A,B.width(),B.height());
		
		A.lock_width( B.width_locked() );
		A.lock_height( B.height_locked() );
	}

	Rectangle
	add( const Rectangle & A, const Rectangle & B ){
		Rectangle C( A.width() + B.width(), A.height() + B.height() );

		if( (A.width_locked() is true) or (B.width_locked() is true) )
			C.lock_width(true);
		else	C.lock_width(false);

		if( (A.height_locked() is true) or (B.height_locked() is true) )
			C.lock_height(true);
		else	C.lock_height(false);
	}

	const Rectangle &
	add_to( Rectangle & A, const Rectangle & B ){
		if( A.width_locked() is false )
			A.width( A.width() + B.width() );
		if( A.height_locked() is false )
			A.height( A.height() + B.height() );
	return	A;
	}

	Rectangle
	sub(const Rectangle & A, const Rectangle & B){
		Rectangle C( A.width() - B.width(), A.height() - B.height() );

		if( (A.width_locked() is true) or (B.width_locked() is true) )
			C.lock_width(true);
		else	C.lock_width(false);

		if( (A.height_locked() is true) or (B.height_locked() is true) )
			C.lock_height(true);
		else	C.lock_height(false);
	}

	const Rectangle &
	sub_from(Rectangle & A, const Rectangle & B){
		if( A.width_locked() is false )
			A.width( A.width() - B.width() );
		if( A.height_locked() is false )
			A.height( A.height() - B.height() );
	return	A;
	}

	
	void
	scale(Rectangle & A, float x){
		if( A.width_locked() is false )
			A.width( (float)(A.width()*x) );
		if( A.height_locked() is false )
			A.height( (float)(A.height()*x) );
	}

	void
	scale_width(Rectangle & A, float x){
		if( A.width_locked() is false )
			A.width( A.width()*x );
	}

	void
	scale_height(Rectangle & A, float x){
		if( A.height_locked() is false )
			A.height( A.height()*x );
	}

	// end friend functions //

	// static methods //

	Rectangle
	Rectangle::create(float W, float H){
		return	Rectangle(W,H);
	}

	Rectangle
	Rectangle::create(const Rectangle & rect){
		return	Rectangle(rect);
	}

	Rectangle *
	Rectangle::create_address(float W, float H){
		return	new Rectangle(W,H);
	}

	Rectangle *
	Rectangle::create_address(const Rectangle & rect){
		return	new Rectangle(rect);
	}

	float
	Rectangle::area(const Rectangle & rect){
		return	rect.area();
	}

	float
	Rectangle::width(const Rectangle & rect){
		return	rect.width();
	}

	float
	Rectangle::height(const Rectangle & rect){
		return	rect.height();
	}

	bool
	Rectangle::width_locked(const Rectangle & rect){
		return	rect.width_locked();
	}

	bool
	Rectangle::height_locked(const Rectangle & rect){
		return	rect.height_locked();
	}

	// end static methods //
	
	void
	Rectangle::remove_locks(){
		w_lock = false;
		h_lock = false;
	}

	void
	Rectangle::width(float W){
		if( w_lock is true )
			return;
		else	w = W;
	}

	float
	Rectangle::width()
	const{return	w;}

	void
	Rectangle::lock_width(bool lock){
		w_lock = lock;
	}

	void
	Rectangle::height(float H){
		if( h_lock is true )
			return;
		else	h = H;
	}

	void
	Rectangle::lock_height(bool lock){
		h_lock = lock;
	}

	bool
	Rectangle::height_locked()
	const{return	(h_lock is true);}

	bool
	Rectangle::width_locked()
	const{return	(w_lock is true);}

	float
	Rectangle::height()
	const{return	h;}

	void
	Rectangle::rectangle(float W, float H){
		if( w_lock is false )
			w = W;
		if( h_lock is false )
			h = H;
	}

	void
	Rectangle::rectangle(const Rectangle & rect){
		rectangle(rect.w, rect.h);

		w_lock = rect.w_lock;
		h_lock = rect.h_lock;
	}

	const Rectangle &
	Rectangle::rectangle()
	const{return	*this;}

	Rectangle *
	Rectangle::rectangle_address()
	{return	this;}

	Rectangle &
	Rectangle::rectangle_ref()
	{return	*this;}

	float
	Rectangle::area()
	const {return	width()*height();}

	void
	Rectangle::scale(float x){
		scale_width(x);
		scale_height(x);
	}

	void
	Rectangle::scale_width(float x){
		if( w_lock is false )
			w *= x;
	}

	void
	Rectangle::scale_height(float x){
		if( h_lock is false )
			h *= x;
	}

	float
	Rectangle::perimeter()
	const{return 2*(w+h);}

	float
	Rectangle::magnitude(){
		return	sqrtf( area() );
	}



	bool
	Rectangle::operator	== (const Rectangle & rect){
		if( w isnot rect.w )
			return	false;
	else	if( h isnot rect.h )
			return	false;
	else	if( w_lock isnot rect.w_lock )
			return	false;
	else	if( h_lock isnot rect.h_lock )
			return	false;
		else	return	true;
	}

	const Rectangle &
	Rectangle::operator	=  (const Rectangle & rect){
		set(*this,rect);
	return	*this;
	}

	const Rectangle &
	Rectangle::operator	+ (const Rectangle & rect){
		return add(*this,rect);
	}

	const Rectangle &
	Rectangle::operator	+= (const Rectangle & rect){
		return	add_to(*this,rect);
	}

	const Rectangle &
	Rectangle::operator	-  (const Rectangle & rect){
		return	sub(*this,rect);
	}

	const Rectangle &
	Rectangle::operator	-= (const Rectangle & rect){
		return	sub_from(*this,rect);
	}

	const Rectangle &
	Rectangle::operator	*  ( float x ){
		scale(x);
	}

	// private methods //
	
	bool
	Point::can_set_x()
	const{
		if( point_locked() is true )
			return	false;
	else	if( (ly is true) or (lz is true) )
			return	false;
		else	return	true;
	}

	bool
	Point::can_set_y()
	const{
		if( point_locked() is true )
			return	false;
	else	if( (lx is true) or (lz is true) )
			return	false;
		else	return	true;
	}

	bool
	Point::can_set_z()
	const{
		if( point_locked() is true )
			return	false;
	else	if( (ly is true) or (lx is true) )
			return	false;
		else	return	true;
	}

	// end private //


	Point::Point()
	: px(0.0f), py(0.0f), pz(0.0f){
		lx = ly = lz = false;
	}

	Point::Point(float X, float Y, float Z)
	: px(X), py(Y), pz(Z){
		lx = ly = lz = false;
	}

	Point::~Point(){}
	
	bool
	Point::point_locked()
	const{return ( (lx is true) and (ly is true) and (lz is true) );}

	void
	Point::lock_point(bool lock){
		lx = ly = lz = lock;
	}

	float
	Point::x()
	const{return px;}

	void
	Point::x(float nx){
		if( can_set_x() is true )
			px = nx;
	}

	void
	Point::y(float ny){
		if( can_set_y() is true )
			py = ny;
	}

	void
	Point::z(float nz){
		if( can_set_z() is true )
			pz = nz;
	}

	float
	Point::y()
	const{return py;}

	float
	Point::z()
	const{return pz;}

	float
	Point::distance(float a, float b, float c)
	const{
		float	dx = x() - a;
		float	dy = y() - b;
		float	dz = z() - c;

		float	sx = dx*dx;
		float	sy = dy*dy;
		float	sz = dz*dz;

	return	sqrtf(sx+sy+sz);
	}

	float
	Point::distance( const Point & at )
	const{
		return	distance( at.x(), at.y(), at.z() );
	}

	float
	Point::magnitude()
	const{
		return	distance(0.0f, 0.0f, 0.0f);
	}


	bool
	Point::x_locked()
	const{return lx;}

	bool
	Point::y_locked()
	const{return ly;}

	bool
	Point::z_locked()
	const{return lz;}


	void
	Point::lock_x(bool lock)
	{lx=lock;}

	void
	Point::lock_y(bool lock)
	{ly=lock;}

	void
	Point::lock_z(bool lock)
	{lz=lock;}

	void
	Point::remove_locks(){
		lx = ly = lz = false;
	}





}



