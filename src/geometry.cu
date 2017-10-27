#include <tsx/prefix.h>
#include <tsx/geometry.h>

namespace	tsx{

	Rectangle::Rectangle()
	: w(0.0f), h(0.0f){
		w_lock = false;
		h_lock = false;

		auto_lock_set = false;
	}

	Rectangle::Rectangle(float W, float H)
	: w(W), h(H){
		w_lock = false;
		h_lock = false;

		auto_lock_set = false;
	}

	Rectangle::Rectangle(const Rectangle & rect){
		if( rect.w lte 0.0f )
			w = 1.0f;
		if( rect.h lte 0.0f )
			h = 1.0f;

		w_lock = rect.w_lock;
		h_lock = rect.h_lock;
		auto_lock_set = rect.auto_lock_set;
	}

	Rectangle::~Rectangle(){
		// just in case the object holds an address for whatever reason //
		w_lock  = false;
		h_lock  = false;
		auto_lock_set = false;
	}

	// friend functions //

	void
	auto_lock(Rectangle & rect, bool lock){
		rect.auto_lock_set = lock;
	}

	bool
	auto_locked(const Rectangle & rect){
		return	rect.auto_locked();
	}

	bool
	Rectangle::auto_locked(const Rectangle & rect){
		return	rect.auto_locked();
	}

	bool
	Rectangle::auto_locked()
	const{
		return	(auto_lock_set is true);
	}

	float
	safe_mult(float x){
		float y = 0.0f;
		if( can_use_scalar(x) is false )
			y = -x;
		else	y = x;
	return	y;
	}

	bool
	can_use_scalar(float x){
		if( x lte 0.0f )
			return	false;
		else	return	true;
	}

	float
	magnitude(const Rectangle & rect){
		return	rect.magnitude();
	}

	Rectangle
	copy_to_scale(const Rectangle & A, float x){
		if( can_use_scalar(x) is true )
			return	Rectangle( A.width()*x, A.height()*x );
		else	return	Rectangle( A );
	}

	Rectangle
	Rectangle::copy_to_scale(const Rectangle & A, float x){
		return	tsx::copy_to_scale(A,x);
	}

	Rectangle
	Rectangle::copy_to_scale(float x)
	const{
		return	tsx::copy_to_scale(*this,x);
	}

	Rectangle
	copy_to_scale(const Rectangle & A, float x, float y){
		float	u, v;
		if( can_use_scalar(x) is true )
			u = x;
		else	u = 1.0f;
		if( can_use_scalar(y) is true )
			v = y;
		else	v = 1.0f;
	return	Rectangle(A.width()*x, A.height()*y);
	}

	Rectangle
	Rectangle::copy_to_scale(const Rectangle & A, float x, float y){
		return	tsx::copy_to_scale(A,x,y);
	}

	Rectangle
	Rectangle::copy_to_scale(float x, float y)
	const{
		return	tsx::copy_to_scale(*this,x,y);
	}

	void
	set( Rectangle & A, float W, float H ){
		float x = safe_mult(W);
		float y = safe_mult(H);

		A.width(W);
		A.height(H);
	}

	void
	Rectangle::set( Rectangle & A, float W, float H ){
		tsx::set(A,W,H);
	}

	void
	Rectangle::set(float a, float b){
		tsx::set(*this,a,b);
	}

	void
	set( Rectangle & A, const Rectangle & B ){
		set(A,B.width(),B.height());
		
		if( A.auto_locked() is true ){
			A.lock_width( B.width_locked() );
			A.lock_height( B.height_locked() );
		}
	}

	void
	Rectangle::set( Rectangle & A, const Rectangle & B ){
		tsx::set(A,B);
	}

	void
	Rectangle::set(const Rectangle & A){
		tsx::set(*this,A);
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
	return	C;
	}

	Rectangle
	Rectangle::add(const Rectangle & A, const Rectangle & B){
		return	tsx::add(A,B);
	}

	const Rectangle &
	Rectangle::add(const Rectangle & A)
	const{
		return	tsx::add(*this,A);
	}

	Rectangle
	add(const Rectangle & A, float a, float b){
		Rectangle C(A);

		if( can_use_scalar(a) is false ){
			if( a isnot 0.0f ){
				if( (-1.0*a gte C.width()) is false )
					C.width( C.width() + a );
			}
		}

		if( can_use_scalar(b) is false ){
			if( b isnot 0.0f ){
				if( (-1.0*b gte C.height()) is false )
					C.height( C.height() + b );
			}
		}
	return	C;
	}

	Rectangle
	Rectangle::add(const Rectangle & A, float a, float b){
		return	tsx::add(A,a,b);
	}

	const Rectangle &
	Rectangle::add(float a, float b)
	const{
		return	tsx::add(*this,a,b);
	}

	const Rectangle &
	add_to( Rectangle & A, const Rectangle & B ){
		if( A.width_locked() is false )
			A.width( A.width() + B.width() );
		if( A.height_locked() is false )
			A.height( A.height() + B.height() );
	return	A;
	}

	const Rectangle &
	Rectangle::add_to( Rectangle & A, const Rectangle & B ){
		return	tsx::add_to(A,B);
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

	Rectangle
	Rectangle::sub( const Rectangle & A, const Rectangle & B ){
		return	tsx::sub(A,B);
	}

	Rectangle
	sub(const Rectangle & A, float W, float H){
		Rectangle C( A.width() - W, A.height() - H );
		
		if( A.width_locked() is true )
			C.lock_width();
		if( A.height_locked() is true )
			C.lock_height();

	return	C;
	}

	Rectangle
	Rectangle::sub(const Rectangle & A, float W, float H){
		return	tsx::sub(A,W,H);
	}

	const Rectangle &
	Rectangle::sub(float W, float H)
	const{
		return	tsx::sub(*this,W,H);
	}

	const Rectangle &
	sub_from(Rectangle & A, const Rectangle & B){
		if( A.width_locked() is false )
			A.width( A.width() - B.width() );
		if( A.height_locked() is false )
			A.height( A.height() - B.height() );
	return	A;
	}

	const Rectangle &
	Rectangle::sub_from(Rectangle & A, const Rectangle & B){
		return	tsx::sub_from(A,B);
	}
	
	const Rectangle &
	scale(Rectangle & A, float x){
		A.width( (float)(A.width()*x) );
		A.height( (float)(A.height()*x) );
	return	A;
	}

	const Rectangle &
	Rectangle::scale(Rectangle & A, float X){
		return	tsx::scale(A,X);
	}

	const Rectangle &
	scale(Rectangle & A, float x, float y){
		A.width( A.width()*x );
		A.height( A.height()*y );
	return	A;
	}

	const Rectangle &
	Rectangle::scale(Rectangle & A, float x, float y){
		return	tsx::scale(A,x,y);
	}


	Rectangle *
	free_rectangle(Rectangle * rect){
		if( rect is null )
			return	rect;
		else	delete	rect;

	return	(rect = null);
	}

	Rectangle *
	Rectangle::free_rectangle(Rectangle * rect){
		return	tsx::free_rectangle(rect);
	}

	void
	lock(Rectangle & A, bool lock_w, bool lock_h){
		A.lock_width(lock_w);
		A.lock_height(lock_h);
	}

	void
	lock_width(Rectangle & A, bool lock){
		Rectangle::lock_width(A,lock);
	}

	void
	lock_height(Rectangle & A, bool lock){
		Rectangle::lock_height(A,lock);
	}

	void
	Rectangle::lock(Rectangle & A, bool x, bool y){
		tsx::lock(A,x,y);
	}

	void
	Rectangle::lock(bool x, bool y){
		tsx::lock(*this, x,y);
	}

	void
	Rectangle::lock_width(Rectangle & A, bool l){
		A.w_lock = l;
	}

	void
	Rectangle::lock_height(Rectangle & A, bool l){
		A.h_lock = l;
	}

	bool
	has_lock(const Rectangle & A){
		return	A.has_lock();
	}

	bool
	Rectangle::has_lock(const Rectangle & A){
		return	A.has_lock();
	}

	bool
	Rectangle::has_lock()
	const{
		return	( (w_lock is true) or (h_lock is true) );
	}

	// end statics and friend functions //

	Rectangle
	Rectangle::create(float W, float H){
		return	Rectangle(W,H);
	}

	Rectangle *
	Rectangle::create_address(float W, float H){
		return	new Rectangle(W,H);
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
	remove_locks(Rectangle & a){
		a.w_lock = false;
		a.h_lock = false;
	}

	void
	Rectangle::remove_locks(Rectangle & a){
		tsx::remove_locks(a);
	}
	
	void
	Rectangle::remove_locks(){
		tsx::remove_locks(*this);
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

	float
	Rectangle::perimeter()
	const{return 2*(w+h);}

	float
	Rectangle::magnitude()
	const{
		float	sx = width()*width();
		float	sy = height()*height();
	return	sqrt(sx+sy);
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

	bool
	Rectangle::operator	!= (const Rectangle & rect){
		return	( (*this is rect) is false );
	}

	const Rectangle &
	Rectangle::operator	=  (const Rectangle & rect){
		tsx::set(*this,rect);
	return	*this;
	}

	Rectangle
	Rectangle::operator	+ (const Rectangle & rect){
		return	tsx::add(*this,rect);
	}

	const Rectangle &
	Rectangle::operator	+= (const Rectangle & rect){
		return	tsx::add_to(*this,rect);
	}

	Rectangle
	Rectangle::operator	-  (const Rectangle & rect){
		return	tsx::sub(*this,rect);
	}

	const Rectangle &
	Rectangle::operator	-= (const Rectangle & rect){
		return	tsx::sub_from(*this,rect);
	}

	Rectangle
	Rectangle::operator	*  ( float x ){
		Rectangle u(*this);
		tsx::scale(u,x);
	return	u;
	}

	const Rectangle &
	Rectangle::operator	*= ( float x ){
		tsx::scale(*this,x);
	return	*this;
	}






	Point::Point()
	: px(0.0f), py(0.0f), pz(0.0f){
		lx = ly = lz = false;
		auto_lock_set = false;
	}

	Point::Point(float X, float Y, float Z)
	: px(X), py(Y), pz(Z){
		lx = ly = lz = false;
		auto_lock_set = false;
	}

	Point::Point(const Point & A){
		px = A.x();
		py = A.y();
		pz = A.z();

		lx = A.x_locked();
		ly = A.y_locked();
		lz = A.z_locked();

		auto_lock_set = A.auto_lock_set;
	}

	Point::~Point(){}

	const Point &
	Point::point()
	const{return *this;}

	Point *
	Point::point_address()
	{return this;}

	Point &
	Point::point_ref()
	{return *this;}

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




	// statics and friend zone //

	Point
	Point::create(float a, float b, float c){
		return	Point(a,b,c);
	}

	Point *
	Point::create_address(float a, float b, float c){
		return	new Point(a,b,c);
	}

	Point *
	free_point(Point * at){
		if( at is null )
			return	null;

		delete	at;
	return	(at = null);
	}

	Point *
	Point::free_point(Point * at){
		return	tsx::free_point(at);
	}

	void
	set(Point & at, const Point & place){
		at.x( place.x() );
		at.y( place.y() );
		at.z( place.z() );

		if( auto_locked(at) ){
			tsx::lock_x(at, place.x_locked());
			tsx::lock_y(at, place.y_locked());
			tsx::lock_z(at, place.z_locked());
		}
	}

	void
	Point::set(Point & at, const Point & place){
		tsx::set(at,place);
	}

	void
	Point::set(const Point & place){
		tsx::set(*this,place);
	}

	void
	set(Point & at, float u, float v, float p){
		Point place(u,v,p);
		tsx::set(at,place);
	}

	void
	Point::set(Point & at, float u, float v, float p){
		tsx::set(at,u,v,p);
	}

	void
	Point::set(float u, float v, float p){
		tsx::set(*this,u,v,p);
	}

	Point
	add(const Point & a, const Point & b){
		Point c( a.x() + b.x(), a.y() + b.y(), a.z() + b.z() );

		if( (a.x_locked() is true) or (b.x_locked() is true) )
			c.lock_x();

		if( (a.y_locked() is true) or (b.y_locked() is true) )
			c.lock_y();

		if( (a.z_locked() is true) or (b.z_locked() is true) )
			c.lock_z();

	return	c;
	}

	Point
	Point::add(const Point & a, const Point & b){
		return	tsx::add(a,b);
	}

	Point
	Point::add(const Point & b)
	const{
		return	tsx::add(*this,b);
	}

	Point
	add(const Point & A, float a, float b, float c){
		Point u(A);

		u.x( u.x() + a );
		u.y( u.y() + b );
		u.z( u.z() + c );
	return	u;
	}

	Point
	Point::add(const Point & A, float a, float b, float c){
		return	tsx::add(A,a,b,c);
	}

	Point
	Point::add(float a, float b, float c)
	const{
		return	tsx::add(*this,a,b,c);
	}

	Point
	sub(const Point & A, const Point & B){
		Point	C(A);
		C.x( C.x() - B.x() );
		C.y( C.y() - B.y() );
		C.z( C.z() - B.z() );
	return	C;
	}

	Point
	Point::sub(const Point & A, const Point & B){
		return	tsx::sub(A,B);
	}

	Point
	Point::sub(const Point & A)
	const{
		return	tsx::sub(*this,A);
	}

	const Point &
	sub_from(Point & A, const Point & B){
		A.x( A.x() - B.x() );
		A.y( A.y() - B.y() );
		A.z( A.z() - B.z() );
	return	A;
	}

	const Point &
	Point::sub_from(Point & A, const Point & B){
		return	tsx::sub_from(A,B);
	}

	const Point &
	Point::sub_from(const Point & A){
		return	tsx::sub_from(*this,A);
	}

	const Point &
	add_to(Point & a, const Point & b){
		a.x( a.x() + b.x() );
		a.y( a.y() + b.y() );
		a.z( a.z() + b.z() );
	return	a;
	}

	const Point &
	Point::add_to(Point & a, const Point & b){
		return	tsx::add_to(a,b);
	}

	const Point &
	scale(Point & a, float all){
		a.x( a.x()*all );
		a.y( a.y()*all );
		a.z( a.z()*all );
	return	a;
	}

	const Point &
	Point::scale(Point & a, float all){
		return	tsx::scale(a,all);
	}

	const Point &
	Point::scale(float all){
		return	tsx::scale(*this,all);
	}

	const Point &
	scale(Point & a, float e1, float e2, std::string axiis){
		if( axiis is "xy" ){
			a.x( a.x()*e1 );
			a.y( a.y()*e2 );
	}else	if( axiis is "yz" ){
			a.y( a.y()*e1 );
			a.z( a.z()*e2 );
	}else	if( axiis is "zx" ){
			a.z( a.z()*e1 );
			a.x( a.x()*e2 );
	}else	if( axiis is "yx" ){
			a.y( a.y()*e1 );
			a.x( a.x()*e2 );
	}else	if( axiis is "zy" ){
			a.z( a.z()*e1 );
			a.y( a.y()*e2 );
	}else	if( axiis is "xz" ){
			a.x( a.x()*e1 );
			a.z( a.z()*e2 );
	}

	return	a;
	}

	const Point &
	Point::scale(Point & a, float e1, float e2, std::string axiis){
		return	tsx::scale(a,e1,e2,axiis);
	}

	const Point &
	Point::scale(float a, float b, std::string aa){
		return	tsx::scale(*this,a,b,aa);
	}

	const Point &
	scale(Point & a, float w, float u, float v){
		a.x( a.x()*w );
		a.y( a.y()*u );
		a.z( a.z()*v );
	return	a;
	}

	const Point &
	Point::scale(Point & a, float w, float u, float v){
		return	tsx::scale(a,w,u,v);
	}

	const Point &
	Point::scale(float w, float u, float v){
		return	tsx::scale(*this,w,u,v);
	}

	const Point &
	scale(Point & a, const Point & b){
		return	tsx::scale(a,b.x(), b.y(), b.z());
	}

	const Point &
	Point::scale(Point & a, const Point & b){
		return	tsx::scale(a,b);
	}

	const Point &
	Point::scale(const Point & b){
		return	tsx::scale(*this,b);
	}

	float
	product(const Point & a, const Point & b){
		float sum = 0.0f;
		sum += a.x() * b.x();
		sum += a.y() * b.y();
		sum += a.z() * b.z();
	return	sum;
	}

	float
	Point::product(const Point & a, const Point & b){
		return	tsx::product(a,b);
	}

	float
	Point::product(const Point & a)
	const{
		return	tsx::product(*this,a);
	}

	float
	distance(const Point & A, const Point & B){
		float	dx = A.x() - B.x();
		float	dy = A.y() - B.y();
		float	dz = A.z() - B.z();

		float	sx = dx*dx;
		float	sy = dy*dy;
		float	sz = dz*dz;
	return	sqrtf(sx+sy+sz);
	}

	float
	Point::distance(const Point & A, const Point & B){
		return	tsx::distance(A,B);
	}

	float
	Point::distance(const Point & A)
	const{
		return	distance(*this,A);
	}

	float
	distance(const Point & A, float u, float v, float w){
		float	dx = A.x() - u;
		float	dy = A.y() - v;
		float	dz = A.z() - w;

		float	sx = dx*dx;
		float	sy = dy*dy;
		float	sz = dz*dz;
	return	sqrtf(sx+sy+sz);
	}

	float
	Point::distance(const Point & A, float u, float v, float w){
		return	tsx::distance(A,u,v,w);
	}

	float
	Point::distance(float u, float v, float w)
	const{
		return	tsx::distance(*this,u,v,w);
	}

	float
	magnitude(const Point & A){
		return	tsx::distance(A,0.0f,0.0f,0.0f);
	}

	float
	Point::magnitude(const Point & A){
		return	tsx::magnitude(A);
	}

	float
	Point::magnitude()
	const{return	magnitude(*this);}
	
	// end friends and statics //

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

	bool
	Point::x_locked()
	const{return lx;}

	bool
	Point::x_locked(const Point & at){
		return	at.x_locked();
	}

	bool
	x_locked(const Point & at){
		return	at.x_locked();
	}

	bool
	Point::y_locked()
	const{return ly;}

	bool
	Point::y_locked(const Point & at){
		return at.y_locked();
	}

	bool
	y_locked(const Point & at){
		return	at.y_locked();
	}

	bool
	Point::z_locked()
	const{return lz;}

	bool
	Point::z_locked(const Point & at){
		return	at.z_locked();
	}

	bool
	z_locked(const Point & at){
		return	at.z_locked();
	}


	void
	Point::lock_x(bool lock)
	{lx=lock;}

	void
	lock_x(Point & x, bool lock){
		x.lock_x(lock);
	}

	void
	Point::lock_x(Point & at, bool l){
		return	tsx::lock_x(at,l);
	}

	void
	lock_y(Point & at, bool l){
		return	at.lock_y(l);
	}

	void
	Point::lock_y(Point & at, bool l){
		return	tsx::lock_y(at,l);
	}

	void
	Point::lock_y(bool lock)
	{ly=lock;}

	void
	Point::lock_z(bool lock)
	{lz=lock;}

	void
	lock_z(Point & at, bool lock){
		at.lock_z(lock);
	}
	
	void
	Point::lock_z(Point & at, bool l){
		tsx::lock_z(at,l);
	}

	void
	remove_locks(Point & at){
		at.remove_locks();
	}

	void
	Point::remove_locks(Point & at){
		tsx::remove_locks(at);
	}

	void
	Point::remove_locks(){
		lx = ly = lz = false;
	}

	bool
	Point::point_locked()
	const{
		return( (lx is true) or (ly is true) or (lz is true) );
	}

	bool
	point_locked(const Point & at){
		return	at.point_locked();
	}

	bool
	Point::point_locked(const Point & at){
		return	tsx::point_locked(at);
	}

	bool
	Point::auto_locked()
	const{
		return	(auto_lock_set is true);
	}

	bool
	auto_locked(const Point & at){
		return	at.auto_locked();
	}

	bool
	Point::auto_locked(const Point & at){
		return	tsx::auto_locked(at);
	}

	void
	Point::auto_lock(bool v){
		auto_lock_set = v;
	}

	void
	auto_lock(Point & at, bool v){
		at.auto_lock(v);
	}

	void
	Point::auto_lock(Point & at, bool v){
		tsx::auto_lock(at,v);
	}



	bool
	Point::operator	== (const Point & at){
		if( x() isnot at.x() )
			return	false;
	else	if( y() isnot at.y() )
			return	false;
	else	if( z() isnot at.z() )
			return	false;
	else	if( x_locked() isnot x_locked(at) )
			return	false;
	else	if( y_locked() isnot y_locked(at) )
			return	false;
	else	if( z_locked() isnot z_locked(at) )
			return	false;
		else	return	true;
	}

	bool
	Point::operator != (const Point & at){
		return	( (*this is at) isnot true );
	}

	const Point &
	Point::operator	 = (const Point & at){
		tsx::set(*this,at);
	return	*this;
	}

	Point
	Point::operator	 + (const Point & at){
		return	tsx::add(*this,at);
	}

	const Point &
	Point::operator	+= (const Point & at){
		return	tsx::add_to(*this,at);
	}

	Point
	Point::operator	 - (const Point & at){
		return	tsx::sub(*this,at);
	}

	const Point &
	Point::operator	-= (const Point & at){
		return	tsx::sub_from(*this,at);
	}

	Point
	Point::operator	 * (const Point & at){
		Point place(*this);
		tsx::scale(place,at);
	return	place;
	}

	Point
	Point::operator	 * (float x){
		Point place(*this);
		tsx::scale(place,x);
	return	place;
	}

	const Point &
	Point::operator *= (float x){
		return	tsx::scale(*this,x);
	}

	const Point &
	Point::operator	*= (const Point & at){
		return	tsx::scale(*this,at);
	}




}



