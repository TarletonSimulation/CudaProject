#if	!defined( __tsx_rectangle__ )
#	 define	  __tsx_rectangle__

#include <tsx/prefix.h>

namespace tsx{
	

	// for x11 // and general integer sized rectangles //
	class	Rectangle{
		public:
				 Rectangle();
				 Rectangle(uint, uint);
				 Rectangle(const Rectangle &);
				~Rectangle();
	
	// commonly used names // for lists and such //
	static	Rectangle	create(uint, uint);
	static	Rectangle	create(const Rectangle &);
	static	Rectangle *	create_pointer(uint, uint);
	static	Rectangle *	create_pointer(const Rectangle &);

friend		Rectangle	add(const Rectangle &, const Rectangle &);
friend	const	Rectangle &	add_to(Rectangle &, const Rectangle &);

friend		Rectangle	sub(Rectangle &, const Rectangle &);
friend	const	Rectangle &	sub_from(Rectangle &, const Rectangle &);

friend	const	Rectangle &	scale(Rectangle &, float);			// floating point because it can be scaled downward //
friend	const	Rectangle &	scale_width(Rectangle &, float);
friend	const	Rectangle &	scale_height(Rectangle &, float);

// final parameters are for shared objects // min_ptr, max_ptr, iter_ptr are shared //
friend	bool			copy(Rectangle &, const Rectangle &, bool =false, bool =false, bool =false);

			void	width(uint);
			uint	width()			const;

			void	max_width(uint);
			uint	max_width()		const;

			void	min_width(uint);
			uint	min_width()		const;

			void	height(uint);
			uint	height()		const;

			void	max_height(uint);
			uint	max_height()		const;

			void	min_height(uint);
			uint	min_height()		const;

			uint	area()			const;
			uint	min_area()		const;
			uint	max_area()		const;

			bool	has_min()		const;
			bool	has_max()		const;
			bool	has_iterator()		const;
			bool	has_limits()		const;

			void	rectangle(uint, uint);
			void	rectangle(const Rectangle &);

			void	max_rectangle(uint, uint);
			void	max_rectangle(const Rectangle &);
			void	share_max(Rectangle *);
			bool	shared_max()		const;

			void	remove_limits();
			void	remove_max();
			void	remove_min();
			
			void	min_rectangle(uint, uint);
			void	min_rectangle(const Rectangle &);
			void	share_min(Rectangle *);
			bool	shared_min()		const;
			bool	shared_limits()		const;			// checks for both sharing // i.e. max and min shares //

			void	iteration(int, int);				// set the iteration values individually //
			void	iteration(const Rectangle &, bool =true);	// if final parameter is true //
										// * if false, only the local iterator will have that value //
			void	share_iteration(Rectangle *);			// share address with another iterator //
			bool	shared_iterator()	const;
		Rectangle *	iterator();
			void	remove_iterator();
			void	iterate();

		// future inheritance methods //
		// return copies of values //
	const	Rectangle &	rectangle()		const;
	const	Rectangle &	max_rectangle()		const;
	const	Rectangle &	min_rectangle()		const;

		// pointers for inherited reasons //
		Rectangle *	rectangle_pointer();
		Rectangle *	rectangle_min_pointer();
		Rectangle *	rectangle_max_pointer();

		// reference returns // becuase c++... //
		Rectangle &	rectangle_ref();
		Rectangle &	rectangle_min_ref();
		Rectangle &	rectangle_max_ref();

		bool 		operator	== ( const Rectangle & );
		bool 		operator	!= ( const Rectangle & );
	const	Rectangle &	operator	+= ( const Rectangle & );
	const	Rectangle &	operator	-= ( const Rectangle & );
	const	Rectangle &	operator	 = ( const Rectangle & );
	const	Rectangle &	operator	 + ( const Rectangle & );
	const	Rectangle &	operator	 - ( const Rectangle & );

		protected:
			uint	w, h;		// width height //
		Rectangle *	min;		//
		Rectangle *	max;		//
		Rectangle *	iter;

			bool	iter_shared;	// true if the iterator is shared // false otherwise //
			bool	max_shared;
			bool	min_shared;
		
		private:
			void	init_max(uint =5000, uint =5000);
			void	init_min(uint =0, uint =0);

			void	no_double_iter();	// safety methods //
			void	no_double_limits();	//
	};


	// cloned floating point geometry class //
	// for opengl and cairo //
	class	fRectangle{
		public:
				 fRectangle();
				 fRectangle(float, float);
				~fRectangle();

	static	fRectangle	create(float, float);

			void	width(float);
			float	width();

			void	max_width(float);
			float	max_width();

			void	min_width(float);
			float	min_width();

			void	height(float);
			float	height();

			void	max_height(float);
			float	max_height();

			void	min_height(float);
			float	min_height();

			float	area();
			float	min_area();
			float	max_area();

			void	frectangle(float, float);
			void	frectangle(const fRectangle &);
			void	max_rectangle(float, float);
			void	min_rectangle(float, float);

			void	iteration(float, float);
			void	iteration(const fRectangle &);
		fRectangle *	iterator();	// just returns the pointer to the iterating rectangle // iterating with iter->w and iter->h //
			void	share_iterator(fRectangle *);

		fRectangle	frectangle();
		fRectangle	max_rectangle();
		fRectangle	min_rectangle();

		bool 		operator	== ( const fRectangle & );
		bool 		operator	!= ( const fRectangle & );
	const	fRectangle &	operator	+= ( const fRectangle & );
	const	fRectangle &	operator	-= ( const fRectangle & );
	const	fRectangle &	operator	 = ( const fRectangle & );
	const	fRectangle &	operator	 + ( const fRectangle & );
	const	fRectangle &	operator	 - ( const fRectangle & );

		protected:
			float	w, h;	// width height //
		fRectangle *	min;	//
		fRectangle *	max;	//

		fRectangle *	iter;	// iteration pointer // not for iterating through lists, so no type should be created for it //
	};


	// for x11 //
	class	Point{
		public:
				 Point();
				 Point(int, int);
				~Point();

		static	Point	create(int, int);
		static	Point	origin();
			
			int	x();
			int	y();

			void	x(int);
			void	y(int);

			void	set_point(int,int);
			void	set_min_point(int,int);
			void	set_max_point(int,int);

			Point	get_max_point();
			Point	get_min_point();
			Point	get_point();

			float	distance(const Point &);
			float	distance(int, int);

		bool	operator	== ( const Point & );
		bool	operator	!= ( const Point & );
	const 	Point &	operator	 = ( const Point & );
	const	Point &	operator	 + ( const Point & );
	const	Point &	operator	 - ( const Point & );
	const	Point &	operator	 * ( const Point & );

		protected:
			int	px, py;
			Point	*max, *min;
	};

	// cloned floating point class //
	// for opengl and cairo //
	class	fPoint{
		public:
				 fPoint();
				 fPoint(float, float);
				~fPoint();

		static	fPoint	create(float, float);
		static	fPoint	origin();
			
			float	x();
			float	y();

			void	x(float);
			void	y(float);

			void	set_point(float,float);
			void	set_min_point(float,float);
			void	set_max_point(float,float);

			fPoint	get_max_point();
			fPoint	get_min_point();
			fPoint	get_point();

			float	distance(const fPoint &);
			float	distance(float, float);

		bool	operator	== ( const fPoint & );
		bool	operator	!= ( const fPoint & );
const 	fPoint &	operator	 = ( const fPoint & );
const	fPoint &	operator	 + ( const fPoint & );
const	fPoint &	operator	 - ( const fPoint & );
const	fPoint &	operator	 * ( const fPoint & );

		protected:
			float	px, py;
			fPoint	*max, *min;
	};


}

#endif
