#if	!defined( __tsx_rectangle__ )
#	 define	  __tsx_rectangle__

#include <tsx/prefix.h>

namespace tsx{
	

	// for x11 // and general integer sized rectangles //
	class	Rectangle{
		public:
				 Rectangle();
				 Rectangle(float, float);
				 Rectangle(const Rectangle &);
				~Rectangle();
	
	// commonly used names // for lists and such //
	static	Rectangle	create(float, float);
	static	Rectangle	create(const Rectangle &);
	static	Rectangle *	create_pointer(float, float);
	static	Rectangle *	create_pointer(const Rectangle &);

friend		void		set(Rectangle &, float W, float H);
friend		void		set(Rectangle &, const Rectangle &);

static		float		area(const Rectangle &);
static		float		width(const Rectangle &);
static		float		height(const Rectangle &);

static		bool		width_locked(const Rectangle &);
static		bool		height_locked(const Rectangle &);

friend		Rectangle	add(const Rectangle &, const Rectangle &);
friend	const	Rectangle &	add_to(Rectangle &, const Rectangle &);

friend		Rectangle 	sub(const Rectangle &, const Rectangle &);
friend	const	Rectangle &	sub_from(Rectangle &, const Rectangle &);

friend		void		scale(Rectangle &, float);			// floating point because it can be scaled downward //
friend		void		scale_width(Rectangle &, float);
friend		void		scale_height(Rectangle &, float);

			void	width(float);
			float	width()			const;
			void	lock_width(bool =true);
			bool	width_locked()		const;

			void	height(float);
			float	height()		const;
			void	lock_height(bool =true);
			bool	height_locked()		const;

			float	area()			const;

			void	rectangle(float, float);
			void	rectangle(const Rectangle &);

			void	scale(float);
			void	scale_width(float);
			void	scale_height(float);

		// future inheritance methods //
		// return copies of values //
	const	Rectangle &	rectangle()		const;

		// pointers for inherited reasons //
		Rectangle *	rectangle_pointer();

		// reference returns // becuase c++... //
		Rectangle &	rectangle_ref();
			
		bool 		operator	== ( const Rectangle & );
		bool 		operator	!= ( const Rectangle & );
	const	Rectangle &	operator	+= ( const Rectangle & );
	const	Rectangle &	operator	-= ( const Rectangle & );
	const	Rectangle &	operator	 = ( const Rectangle & );
	const	Rectangle &	operator	 + ( const Rectangle & );
	const	Rectangle &	operator	 - ( const Rectangle & );
	const	Rectangle &	operator	 * ( float );

		protected:
			float	w, h;		// width height //
			bool	w_lock;
			bool	h_lock;
	};




}

#endif
