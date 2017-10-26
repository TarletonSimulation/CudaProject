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
	Rectangle::create_pointer(float W, float H){
		return	new Rectangle(W,H);
	}

	Rectangle *
	Rectangle::create_pointer(const Rectangle & rect){
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
	Rectangle::rectangle_pointer()
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


}


