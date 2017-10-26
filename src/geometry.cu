#include <tsx/geometry.h>

namespace	tsx{

	Rectangle::Rectangle()
	: w(0), h(0){
		max = nullptr;
		min = nullptr;
		iter= nullptr;

		iter_shared	= false;
		max_shared	= false;
		min_shared	= false;
	}

	Rectangle::Rectangle(uint W, uint H)
	: w(W), h(H){
		max = nullptr;
		min = nullptr;
		iter= nullptr;

		iter_shared	= false;
		max_shared	= false;
		min_shared	= false;
	}

	Rectangle::Rectangle(const Rectangle & rect)
	: w(rect.w), h(rect.h){
		if( rect.max isnot null )	init_max(rect.max->w, rect.max->h);
		if( rect.min isnot null )	init_min(rect.min->w, rect.min->h);
		if( rect.iter isnot null )	iteration(rect.iter->w, rect.iter->h);
	}

	Rectangle::~Rectangle(){
		if( min isnot null )
			delete min;
		if( max isnot null )
			delete max;
		if( (iter isnot null) and (iter_shared is false) )
			delete iter;
		else	if( iter_shared is true )
			iter = null;

		iter	= null;
		max	= null;
		min	= null;
	}

	// friend methods //
	
	Rectangle
	add( const Rectangle & A, const Rectangle & B){
		Rectangle C(A);

		C.w += B.width();
		C.h += B.height();

		C.remove_limits();
		C.remove_iterator();
	return	C;
	}

	const Rectangle &
	add_to(Rectangle & A, const Rectangle & B){
		A.w += B.width();
		A.h += B.height();
	return	A;
	}

	// end friends //

	// static methods //

	Rectangle
	Rectangle::create(uint w, uint h){
		Rectangle A(w,h);
	return	A;
	}

	Rectangle *
	Rectangle::create_pointer(uint w, uint h){
		return	new Rectangle(w,h);
	}

	// end statics //

	// protected methods //

	bool
	Rectangle::has_limits()
	const{
		if( (has_max() is true) or (has_min() is true) )
			return	true;
		else	return	false;
	}

	bool
	Rectangle::has_max()
	const{
		if( max is null )
			return	false;
		else	return	true;
	}

	bool
	Rectangle::has_min()
	const{
		if( min is null )
			return	false;
		else	return	true;
	}

	bool
	Rectangle::has_iterator()
	const{
		if( iter is null )
			return	false;
		else	return	true;
	}

	void
	Rectangle::init_max(uint mw, uint mh){
		if( has_max() ){
			max_rectangle(mw,mh);
			return;
		}

		max = new Rectangle(mw,mh);
		return;
	}

	void
	Rectangle::init_min(uint mw, uint mh){
		if( has_min() ){
			min_rectangle(mw, mh);
			return;
		}

		min = new Rectangle(mw,mh);
		return;
	}

	void
	Rectangle::no_double_iter(){
		if( has_iterator() is false )
			return;

		if( iter->iter isnot null ){
			if( iter->iter_shared is true )
				iter->iter = null;
			else	delete	iter->iter;
		}
	}

	void
	Rectangle::no_double_limits(){
		if( has_max() is true ){
			if( max->max isnot null ){
				if( max->max_shared is true )
					max->max = null;
				else	delete	max->max;
			}
		}

		if( has_min() is true ){
			if( min->min isnot null ){
				if( min->min_shared is true )
					min->min = null;
				else	delete	min->min;
			}
		}
	}

	// end protected //

	void
	Rectangle::share_iteration(Rectangle * rect){
		if( rect is null )
			return;
			
		iter = rect->iter;
		iter_shared = true;

		no_double_iter();
	}

	bool
	Rectangle::shared_iterator() const
	{return	(iter_shared is true);}

	void
	Rectangle::share_max(Rectangle * rect){
		if( rect is null )
			return;
	else	if( rect->has_max() is false )
			return;
		else{
			if( ( max_shared is false ) and ( has_max() is true ) ){
				remove_max();
			}
				
			max = rect->max;
			max_shared = true;
		}
	}

	bool
	Rectangle::shared_max() const
	{return	(max_shared is true);}

	bool
	Rectangle::shared_min() const
	{return	(min_shared is true);}

	bool
	Rectangle::shared_limits() const
	{return	( (shared_min() is true) and (shared_max() is true) );}

	void
	Rectangle::share_min(Rectangle * rect){
		if( rect is null )
			return;
	else	if( rect->has_min() is false )
			return;
		else{
			if( ( min_shared is false ) and ( has_min() is true ) ){
				remove_min();
			}

			min = rect->min;
			min_shared = true;
		}
	}

	void
	Rectangle::remove_iterator(){
		if( iter is null )
			return;

		no_double_iter();

		if( iter_shared is true )
			iter = null;
		else	delete iter;

		iter = null;
	}

	void
	Rectangle::remove_max(){
		if(has_max() is false)
			return;
		
		no_double_limits();
		delete	max;
		max = nullptr;
	}

	void
	Rectangle::remove_min(){
		if( has_min() is false )
			return;

		no_double_limits();
		delete	min;
		min = nullptr;
	}

	void
	Rectangle::remove_limits(){
		if( has_limits() is false )
			return;
		remove_min();
		remove_max();
	}

	void
	Rectangle::iteration(int wi, int hi){
		if( iter isnot null ){
			iter->w = wi;
			iter->h = hi;
		return;
		}

		iter = new Rectangle(wi,hi);
	return;
	}

	void
	Rectangle::iteration(const Rectangle & rect, bool keep){
		if( keep is false ){
			remove_iterator();
			iter = new Rectangle(rect);

		}else	*iter = rect;

		no_double_iter();
	}

	Rectangle *
	Rectangle::iterator(){
		if( iter is null )
			return	null;	// return raw null pointer so the address isn't saved outside this class //
					// it must be set before it can be manipulated outside it's class //
					// for destructor and sharing reasons //
		return	iter;
	}

	void
	Rectangle::width(uint W){
		if( has_min() ){
			if( has_max() ){
				if( W gt max->w ){
					w = max->w;
					return;
				}
			}

			if( W lt min->w )
				w = min->w;
			else	w = W;
		return;
		}else	w = W;
	return;
	}

	void
	Rectangle::height(uint H){
		if( has_min() ){
			if( has_max() ){
				if( H gt max->h ){
					h = max->h;
					return;
				}
			}

			if( H lt min->h )
				h = min->h;
			else	h = H;
		return;
		}else	h = H;
	return;
	}

	uint
	Rectangle::width()
	const{return	w;}

	uint
	Rectangle::height()
	const{return	h;}

	void
	Rectangle::max_rectangle(uint mw, uint mh){
		if( has_max() ){
			if( has_min() ){
				if( *min is *max )
					return;
			}

			max->w = mw;
			max->h = mh;
		}else	init_max(mw,mh);

		if( max->max isnot null ){
			if( max->max_shared is true )
				max->max = null;
			else	delete	max->max;

			max->max = null;
		}

	return;
	}

	void
	Rectangle::min_rectangle(uint mw, uint mh){
		if( has_min() ){
			if( has_max() ){
				if( *min is *max )
					return;
			}

			min->w = mw;
			min->h = mh;
		}else	init_min(mw,mh);
		
		if( min->min isnot null ){
			if( min->min_shared is true )
				min->min = null;
			else	delete	min->min;

			min->min = null;
		}

	return;
	}

	const Rectangle &
	Rectangle::min_rectangle()
	const{
		if( has_min() )
			return	*min;
		else	return	create(0,0);
	}

	const Rectangle &
	Rectangle::max_rectangle()
	const{
		if( has_max() )
			return	*max;
		else	return	create(5000,5000);
	}

	Rectangle *
	Rectangle::rectangle_pointer()
	{return	this;}

	Rectangle *
	Rectangle::rectangle_max_pointer(){
		if( has_max() is false )
			return	null;
		else	return	max;
	}

	Rectangle *
	Rectangle::rectangle_min_pointer(){
		if( has_min() is false )
			return	null;
		else	return	min;
	}

	Rectangle &
	Rectangle::rectangle_ref()
	{return	*this;}

	Rectangle &
	Rectangle::rectangle_max_ref(){
		if( has_max() is false ){
			init_max();
		}return	*max;
	}

	Rectangle &
	Rectangle::rectangle_min_ref(){
		if( has_min() is false ){
			init_min();
		}return	*min;
	}



	bool
	Rectangle::operator == (const Rectangle & rect){
		if( w isnot rect.w )
			return	false;
	else	if( h isnot rect.h )
			return	false;
	else	if( has_max() isnot rect.has_max() )
			return	false;
	else	if( has_min() isnot rect.has_min() )
			return	false;
	else	if( has_iterator() isnot rect.has_iterator() )
			return	false;

		if( has_min() ){
			if( (min->w isnot rect.min->w) or (min->h isnot rect.min->h) )
				return	false;
		}

		if( has_max() ){
			if( (max->w isnot rect.max->w) or (max->h isnot rect.max->h) )
				return	false;
		}

		if( has_iterator() ){
			if( (iter->w isnot rect.iter->w) or (iter->h isnot rect.iter->h) )
				return	false;

			if( ( iter->has_limits() isnot rect.iter->has_limits() ) )
				return	false;

			if( iter->has_limits() ){
				if( (iter->has_max() isnot rect.iter->has_max()) )
					return	false;
			else	if( (iter->has_min() isnot rect.iter->has_min()) )
					return	false;
				
				if( iter->has_max() ){
					if(	(iter->max->w isnot rect.iter->max->w) or
						(iter->max->h isnot rect.iter->max->h) )
						return	false;
				}

				if( iter->has_min() ){
					if( 	(iter->min->w isnot rect.iter->min->w) or
						(iter->min->h isnot rect.iter->min->h) )
						return	false;
				}

			}
		}
	return	true;
	}

	bool
	Rectangle::operator != (const Rectangle & rect){
		return	( (*this == rect) is false );
	}


	const Rectangle &
	Rectangle::operator = (const Rectangle & rect){
		w = rect.w;
		h = rect.h;

		if( rect.has_max() is true ){
			if( has_max() is false )
				init_max( rect.max->w, rect.max->h );
		}

		if( rect.has_min() is true ){
			if( has_min() is false )
				init_min( rect.min->w, rect.min->h );
		}

		if( rect.has_iterator() ){
			iteration( *(rect.iter), true );
		}
	return	*this;
	}

	const Rectangle &
	Rectangle::operator + (const Rectangle & rect){
		return	add(*this,rect);
	}

	const Rectangle &
	Rectangle::operator += (const Rectangle & rect){
		return add_to(*this,rect);
	}

}
