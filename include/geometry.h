#if	!defined( __tsx_rectangle__ )
#	 define	  __tsx_rectangle__

#include <tsx/prefix.h>

// preperation data for opengl and cairo to go along with x11 //

namespace tsx{

	class	Rectangle{
		public:
				 Rectangle();
				 Rectangle(float, float);
				 Rectangle(const Rectangle &);
				~Rectangle();

		typedef		std::list<Rectangle *>	AddressList;
		typedef		std::list<Rectangle>	List;

static	const	float		MinWidth = 0.0f;
static	const	float 		MinHeight= 0.0f;
	
	// commonly used names // for lists and such //
static		Rectangle 	create(float, float);
static		Rectangle *	create_address(float, float);

friend		Rectangle *	free_rectangle(Rectangle *);
static		Rectangle *	free_rectangle(Rectangle *);
	// for inheritance purposes and ease of use for the programmer //
friend		void		set(Rectangle &, float, float);
static		void		set(Rectangle &, float, float);
		void		set(float, float);

friend		void		set(Rectangle &, const Rectangle &);
static		void		set(Rectangle &, const Rectangle &);
		void		set(const Rectangle &);

friend		float		area(const Rectangle &);
static		float		area(const Rectangle &);
		float		area()	const;

friend		float		width(const Rectangle &);
static		float		width(const Rectangle &);
		float		width()	const;
		void		width(float);

friend		float		height(const Rectangle &);
static		float		height(const Rectangle &);
		float		height() const;
		void		height(float);

static		bool		width_locked(const Rectangle &);
friend		bool		width_locked(const Rectangle &);
		bool		width_locked() const;

static		bool		height_locked(const Rectangle &);
friend		bool		height_locked(const Rectangle &);
		bool		height_locked() const;

friend		Rectangle 	add(const Rectangle &, const Rectangle &);
friend		Rectangle	add(const Rectangle &, float, float);
static		Rectangle	add(const Rectangle &, const Rectangle &);
static		Rectangle	add(const Rectangle &, float, float);
	const	Rectangle &	add(const Rectangle &)const;
	const	Rectangle &	add(float, float)	const;

friend	const	Rectangle &	add_to(Rectangle &, const Rectangle &);
friend	const	Rectangle &	add_to(Rectangle &, float, float);
static	const	Rectangle &	add_to(Rectangle &, const Rectangle &);
static	const	Rectangle &	add_to(Rectangle &, float, float);

friend		Rectangle	sub(const Rectangle &, const Rectangle &);
friend		Rectangle	sub(const Rectangle &, float, float);
static		Rectangle	sub(const Rectangle &, const Rectangle &);
static		Rectangle	sub(const Rectangle &, float, float);
	const	Rectangle &	sub(const Rectangle &) const;
	const	Rectangle &	sub(float, float)	const;

friend	const	Rectangle &	sub_from(Rectangle &, const Rectangle &);
friend	const	Rectangle &	sub_from(Rectangle &, float, float);
static	const	Rectangle &	sub_from(Rectangle &, const Rectangle &);
static	const	Rectangle &	sub_from(Rectangle &, float, float);

friend	const	Rectangle &	scale(Rectangle &, float);
static	const	Rectangle &	scale(Rectangle &, float);
	const	Rectangle &	scale(float);

friend	const	Rectangle &	scale(Rectangle &, float, float);
static	const	Rectangle &	scale(Rectangle &, float, float);
	const	Rectangle &	scale(float, float);

friend		Rectangle	copy_to_scale(const Rectangle &, float);
static		Rectangle	copy_to_scale(const Rectangle &, float);
		Rectangle	copy_to_scale(float)	const;

friend		Rectangle	copy_to_scale(const Rectangle &, float, float);
static		Rectangle	copy_to_scale(const Rectangle &, float, float);
		Rectangle	copy_to_scale(float, float)	const;

friend			bool	auto_locked(const Rectangle &);
static			bool	auto_locked(const Rectangle &);
			bool	auto_locked()		const;

friend			void	auto_lock(Rectangle &, bool =true);
static			void	auto_lock(Rectangle &, bool =true);
			void	auto_lock(bool =true);

friend			float	perimeter(const Rectangle &);
static			float	perimeter(const Rectangle &);
			float	perimeter()		const;

friend			float	magnitude(const Rectangle &);
static			float	magnitude(const Rectangle &);
			float	magnitude()		const;

friend			void	lock(Rectangle &, bool =true, bool =true);
static			void	lock(Rectangle &, bool =true, bool =true);
			void	lock(bool =true, bool =true);

friend			void	remove_locks(Rectangle &);
static			void	remove_locks(Rectangle &);
			void	remove_locks();

friend			bool	has_lock(const Rectangle &);
static			bool	has_lock(const Rectangle &);
			bool	has_lock() const;

friend			void	lock_width(Rectangle &, bool =true);
static			void	lock_width(Rectangle &, bool =true);
			void	lock_width(bool =true);

friend			void	lock_height(Rectangle &, bool =true);
static			void	lock_height(Rectangle &, bool =true);
			void	lock_height(bool =true);

		// future inheritance methods //
		// return copies of values //
	const	Rectangle &	rectangle()		const;

		// addresss for inherited reasons //
		Rectangle *	rectangle_address();

		// reference returns // becuase c++... //
		Rectangle &	rectangle_ref();
			
		bool 		operator	== (const Rectangle &);
		bool 		operator	!= (const Rectangle &);
	const	Rectangle &	operator	+= (const Rectangle &);
	const	Rectangle &	operator	-= (const Rectangle &);
		Rectangle	operator	*= (float);
	const	Rectangle &	operator	 = (const Rectangle &);
		Rectangle	operator	 + (const Rectangle &);
		Rectangle	operator	 - (const Rectangle &);
		Rectangle	operator	 * (float);

		protected:
			float	w, h;		// width height //
			bool	w_lock;
			bool	h_lock;

			bool	auto_lock_set;	// if the auto lock is set // the point sets its locks according to another point if is set to that value //
						// else the locks remain the same //
		private:
	friend		float	safe_mult(float);
	friend		bool	can_use_scalar(float);
	};



	
	class	Point{
		public:
				 Point();
				 Point(float, float, float);
				 Point(const Point &);	// the boolean is for copying the other objects point lock info // false does not copy //
				~Point();

		typedef	std::list<Point *>	AddressList;
		typedef	std::list<Point>	List;

		static	Point	create(float, float, float =0.0f);
		static	Point *	create_address(float, float, float =0.0f);

	friend		Point *	free_point(Point *);
	static		Point * free_point(Point *);
	
	friend		Point	add(const Point &, const Point &);
	friend		Point	add(const Point &, float, float, float);
	static		Point	add(const Point &, const Point &);
	static		Point	add(const Point &, float, float, float);
		const	Point &	add(const Point &) const;
		const	Point &	add(float, float, float) const;

	friend	const	Point &	add_to(Point &, const Point &);
	static	const	Point &	add_to(Point &, const Point &);
		const	Point & add_to(const Point &);

	friend	const	Point &	add_to(Point &, float, float, float);
	static	const	Point &	add_to(Point &, float, float, float);
		const	Point & add_to(float, float, float);

	friend		Point	sub(const Point &, const Point &);
	static		Point	sub(const Point &, const Point &);
		const	Point &	sub(const Point &) const;

	friend		Point	sub(const Point &, float, float, float);
	static		Point	sub(const Point &, float, float, float);
		const	Point &	sub(float, float, float);

	friend	const	Point &	sub_from(Point &, const Point &);
	static	const	Point &	sub_from(Point &, const Point &);
		const	Point &	sub_from(const Point &);
		
	friend	const	Point &	sub_from(Point &, float, float, float);
	static	const	Point &	sub_from(Point &, float, float, float);
		const	Point &	sub_from(float, float, float);

	friend	const	Point &	scale(Point &, float);			// mult all //
	static	const	Point &	scale(Point &, float);
		const	Point &	scale(float);

	friend	const	Point & scale(Point &, float, float, std::string ="xy");	// mult given plane //
	static	const	Point & scale(Point &, float, float, std::string ="xy");
		const	Point &	scale(float, float, std::string ="xy");

	friend	const	Point &	scale(Point &, float, float, float);	// mult individual //
	static	const	Point & scale(Point &, float, float, float);
		const	Point &	scale(float, float, float);

	friend	const	Point &	scale(Point &, const Point &);		// point scale //
	static	const	Point & scale(Point &, const Point &);
		const	Point &	scale(const Point &);
			
	friend		float	product(const Point &, const Point &);	// dot product for points // global //
	static		float	product(const Point &, const Point &);	// local static //
			float	product(const Point &)	const;		// local non-static //

	friend		float	distance(const Point &, const Point &);
	static		float	distance(const Point &, const Point &);
			float	distance(const Point &) const;

	friend		float	distance(const Point &, float, float, float);
	static		float	distance(const Point &, float, float, float);
			float	distance(float, float, float) const;
	
	friend		float	magnitude(const Point &);
	static		float	magnitude(const Point &);
			float	magnitude()	const;
	
	friend		float	x(const Point &);
			float	x()		const;
			void	x(float);
	
	friend		float	y(const Point &);
			float	y()		const;
			void	y(float);
	
	friend		float	z(const Point &);
			float	z()		const;
			void	z(float);

			bool	point_locked()	const;
			void	lock_point(bool =true);

			bool	x_locked()	const;
			bool	y_locked()	const;
			bool	z_locked()	const;

			void	lock_x(bool =true);	// lock to x-line //
			void	lock_y(bool =true);	// lock to y-line //
			void	lock_z(bool =true);	// lock to z-line //
			// if all true, point remains constant //

			void	remove_locks();
			void	scale_x(float);
			void	scale_y(float);
			void	scale_z(float);

		const	Point &	point()		const;
			Point *	point_address();
			Point & point_ref();

			bool	operator	== (const Point &);
			bool	operator	!= (const Point &);
		const	Point &	operator	+= (const Point &);
		const	Point &	operator	-= (const Point &);
		const	Point &	operator	*= (const Point &);
		const	Point &	operator	*= (float);
		const	Point &	operator	 = (const Point &);
			Point	operator	 + (const Point &);
			Point	operator	 - (const Point &);
			Point	operator	 * (const Point &);
		const	Point &	operator	 * (float);

		protected:
			float	px, py, pz;
			bool	lx, ly, lz;	// if ly is true, the value will be locked to the y-line // can not change x or z //
						// if all are true, point can not move //
		private:
			bool	can_set_x()	const;
			bool	can_set_y()	const;
			bool	can_set_z()	const;
	};

	float		safe_mult(float);
	bool		can_use_scalar(float);

	void		lock(Rectangle &, bool, bool);
	void		lock_width(Rectangle &, bool);
	void		lock_height(Rectangle &, bool);
	void		auto_lock(Rectangle &, bool);
	bool		auto_locked(Rectangle &);

	bool		width_locked(const Rectangle &);
	bool		height_locked(const Rectangle &);
	bool		has_lock(const Rectangle &);

	Rectangle	add(const Rectangle &, const Rectangle &);
	Rectangle	add(const Rectangle &, float, float);
const	Rectangle &	add_to(Rectangle &, const Rectangle &);
const	Rectangle &	add_to(Rectangle &, float, float);
	
	Rectangle	sub(const Rectangle &, const Rectangle &);
	Rectangle	sub(const Rectangle &, float, float);
const	Rectangle &	sub_from(Rectangle &, const Rectangle &);
const	Rectangle &	sub_from(Rectangle &, float, float);

const	Rectangle &	scale(Rectangle &, float);
const	Rectangle &	scale(Rectangle &, float, float);
const	Rectangle &	scale(Rectangle &, const Rectangle &);

	Rectangle	copy_to_scale(const Rectangle &, float);
	Rectangle	copy_to_scale(const Rectangle &, float, float);
		
		void	set(Rectangle &, float, float);
		void	set(Rectangle &, const Rectangle &);
		
		float	perimeter(const Rectangle &);
		float	magnitude(const Rectangle &);
		float	area(const Rectangle &);
	


const	Point	&	scale(Point &, float);
const	Point	&	scale(Point &, float, float, std::string);
const	Point	&	scale(Point &, float, float, float);
const	Point	&	scale(Point &, const Point &);

		float	distance(const Point &, const Point &);
		float	distance(const Point &, float, float, float);
		float	magnitude(const Point &);

		float	product(const Point &, const Point &);
		float	product(const Point &, float, float, float);
	


}

#endif
